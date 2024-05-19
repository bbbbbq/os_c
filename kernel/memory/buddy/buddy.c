#include "buddy.h"
#include "debug.h"
#include "list.h"
#include "string.h"
// Buddy内存分配器

static int nsizes; // bd_sizes数组中的条目数量
typedef struct list Bd_list;

// 分配器为每个大小k维护一个sz_info，每个sz_info有一个空闲列表，一个alloc数组用于跟踪哪些块被分配，一个split数组用于跟踪哪些块被分割。
// 这些数组类型为char（1字节），但分配器每个块使用1位（因此，一个char记录8个块的信息）。
struct sz_info
{
  Bd_list free;
  char *alloc;
  char *split;
};
typedef struct sz_info Sz_info;

static Sz_info *bd_sizes;
static void *bd_base; // 由buddy分配器管理的内存的起始地址
// static struct spinlock lock;

// 如果数组中索引位置的位被设置为1，则返回1
int bit_isset(char *array, int index)
{
  char b = array[index / 8];
  char m = (1 << (index % 8));
  return (b & m) == m;
}

// 将数组中索引位置的位设置为1
void bit_set(char *array, int index)
{
  char b = array[index / 8];
  char m = (1 << (index % 8));
  array[index / 8] = (b | m);
}

// 清除数组中索引位置的位
void bit_clear(char *array, int index)
{
  char b = array[index / 8];
  char m = (1 << (index % 8));
  array[index / 8] = (b & ~m);
}

// 以1位的范围列表打印位向量
void bd_print_vector(char *vector, int len)
{
  int last, lb;

  last = 1;
  lb = 0;
  for (int b = 0; b < len; b++)
  {
    if (last == bit_isset(vector, b))
      continue;
    lb = b;
    last = bit_isset(vector, b);
  }
  if (lb == 0 || last == 1)
  {
  }
}

// 打印buddy的数据结构
void bd_print()
{
  for (int k = 0; k < nsizes; k++)
  {
    lst_print(&bd_sizes[k].free);
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    if (k > 0)
    {
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    }
  }
}

// 计算使2^k >= n的最小k值是多少？
int firstk(uint64_t n)
{
  int k = 0;
  uint64_t size = LEAF_SIZE;

  while (size < n)
  {
    k++;
    size *= 2;
  }
  return k;
}

// 计算大小为k的块中地址p的块索引
int blk_index(int k, char *p)
{
  int n = p - (char *)bd_base;
  return n / BLK_SIZE(k);
}

// 将大小k的块索引转换回地址
void *addr(int k, int bi)
{
  int n = bi * BLK_SIZE(k);
  return (char *)bd_base + n;
}

// 分配nbytes大小的内存，但malloc不会返回小于LEAF_SIZE的内存
void *bd_malloc(uint64_t nbytes)
{
  int fk, k;

  // acquire(&lock);

  // 找到一个大于等于nbytes的空闲块，从可能的最小k开始
  fk = firstk(nbytes);
  for (k = fk; k < nsizes; k++)
  {
    if (!lst_empty(&bd_sizes[k].free))
      break;
  }
  if (k >= nsizes)
  { // 没有空闲块？
    // release(&lock);
    return 0;
  }

  // 找到一个块；取出它并可能将其分割。
  char *p = lst_pop(&bd_sizes[k].free);
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
  for (; k > fk; k--)
  {
    // 分割大小为k的块，并标记大小为k-1的一半为已分配
    // 并将另一半放入大小为k-1的空闲列表中
    char *q = p + BLK_SIZE(k - 1); // p的伙伴
    bit_set(bd_sizes[k].split, blk_index(k, p));
    bit_set(bd_sizes[k - 1].alloc, blk_index(k - 1, p));
    lst_push(&bd_sizes[k - 1].free, q);
  }
  // release(&lock);

  return p;
}

// 查找指针p指向的块的大小。
int size(char *p)
{
  for (int k = 0; k < nsizes; k++)
  {
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p)))
    {
      return k;
    }
  }
  return 0;
}

// 释放之前使用bd_malloc分配的内存p。
void bd_free(void *p)
{
  void *q;
  int k;

  // acquire(&lock);
  for (k = size(p); k < MAXSIZE; k++)
  {
    int bi = blk_index(k, p);
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    bit_clear(bd_sizes[k].alloc, bi); // 在大小为k的位置释放p
    if (bit_isset(bd_sizes[k].alloc, buddy))
    {        // 伙伴是否已分配？
      break; // 跳出循环
    }
    // 伙伴是空闲的；与伙伴合并
    q = addr(k, buddy);
    lst_remove(q); // 从空闲列表中移除伙伴
    if (buddy % 2 == 0)
    {
      p = q;
    }
    // 在大小为k+1的位置标记合并的伙伴对不再分割
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
  }
  lst_push(&bd_sizes[k].free, p);
  // release(&lock);
}

// 计算在大小为k的块中不包含p的第一个块的索引
int blk_index_next(int k, char *p)
{
  int n = (p - (char *)bd_base) / BLK_SIZE(k);
  if ((p - (char *)bd_base) % BLK_SIZE(k) != 0)
    n++;
  return n;
}

static int _log2(uint64_t n)
{
  int k = 0;
  while (n > 1)
  {
    k++;
    n >>= 1;
  }
  return k;
}

// 将内存范围[start, stop)标记为已分配，从大小0开始。
void bd_mark(void *start, void *stop)
{
  int bi, bj;

  if (((uint64_t)start % LEAF_SIZE != 0) || ((uint64_t)stop % LEAF_SIZE != 0))
    panic("bd_mark\n");

  for (int k = 0; k < nsizes; k++)
  {
    bi = blk_index(k, start);
    bj = blk_index_next(k, stop);
    for (; bi < bj; bi++)
    {
      if (k > 0)
      {
        // 如果在大小k的块已被分配，也标记它已被分割
        bit_set(bd_sizes[k].split, bi);
      }
      bit_set(bd_sizes[k].alloc, bi);
    }
  }
}

// 如果一个块被标记为已分配且其伙伴是空闲的，则将伙伴放入大小为k的空闲列表。
int bd_initfree_pair(int k, int bi)
{
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
  int free = 0;
  if (bit_isset(bd_sizes[k].alloc, bi) != bit_isset(bd_sizes[k].alloc, buddy))
  {
    // 一对中的一个是空闲的
    free = BLK_SIZE(k);
    if (bit_isset(bd_sizes[k].alloc, bi))
      lst_push(&bd_sizes[k].free, addr(k, buddy)); // 将伙伴放入空闲列表
    else
      lst_push(&bd_sizes[k].free, addr(k, bi)); // 将bi放入空闲列表
  }
  return free;
}

// 为每个大小k初始化空闲列表。对于每个大小k，只有两对可能有一个伙伴应该在空闲列表上：bd_left和bd_right。
int bd_initfree(void *bd_left, void *bd_right)
{
  int free = 0;

  for (int k = 0; k < MAXSIZE; k++)
  { // 跳过最大大小
    int left = blk_index_next(k, bd_left);
    int right = blk_index(k, bd_right);
    free += bd_initfree_pair(k, left);
    if (right <= left)
      continue;
    free += bd_initfree_pair(k, right);
  }
  return free;
}

// 将范围[bd_base,p)标记为已分配
int bd_mark_data_structures(char *p)
{
  int meta = p - (char *)bd_base;
  bd_mark(bd_base, p);
  return meta;
}

// 将范围[end, HEAPSIZE)标记为已分配
int bd_mark_unavailable(void *end, void *left)
{
  int unavailable = BLK_SIZE(MAXSIZE) - (end - bd_base);
  if (unavailable > 0)
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);

  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
  bd_mark(bd_end, bd_base + BLK_SIZE(MAXSIZE));
  return unavailable;
}

// 初始化buddy分配器：它管理来自[base, end)的内存。
void bd_init(void *base, void *end)
{
  char *p = (char *)ROUNDUP((uint64_t)base, LEAF_SIZE);
  int sz;

  // initlock(&lock, "buddy");
  bd_base = (void *)p;

  // 计算我们需要管理的大小数量[base, end)
  nsizes = _log2(((char *)end - p) / LEAF_SIZE) + 1;
  if ((char *)end - p > BLK_SIZE(MAXSIZE))
  {
    nsizes++; // 向上取整到下一个2的幂
  }

  // 分配bd_sizes数组
  bd_sizes = (Sz_info *)p;
  p += sizeof(Sz_info) * nsizes;
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);

  // 初始化空闲列表并为每个大小k分配alloc数组
  for (int k = 0; k < nsizes; k++)
  {
    lst_init(&bd_sizes[k].free);
    sz = sizeof(char) * ROUNDUP(NBLK(k), 8) / 8;
    bd_sizes[k].alloc = p;
    memset(bd_sizes[k].alloc, 0, sz);
    p += sz;
  }

  // 为每个大小k分配split数组，除了k=0，因为我们不会分割大小为k=0的最小块。
  for (int k = 1; k < nsizes; k++)
  {
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    bd_sizes[k].split = p;
    memset(bd_sizes[k].split, 0, sz);
    p += sz;
  }
  p = (char *)ROUNDUP((uint64_t)p, LEAF_SIZE);

  // 完成分配；将内存范围[base, p)标记为已分配，以便buddy不会分配这些内存。
  int meta = bd_mark_data_structures(p);

  // 将不可用的内存范围[end, HEAP_SIZE)标记为已分配，以便buddy不会分配这些内存。
  int unavailable = bd_mark_unavailable(end, p);
  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;

  // 为每个大小k初始化空闲列表
  int free = bd_initfree(p, bd_end);

  // 检查空闲的内存量是否符合预期
  if (free != BLK_SIZE(MAXSIZE) - meta - unavailable)
  {
    panic("bd_init: free mem\n");
  }
}

void *malloc(uint64_t nbytes)
{
  bd_malloc(nbytes);
}
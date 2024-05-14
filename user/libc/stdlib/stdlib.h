#ifndef STDLIB_H
#define STDLIB_H
#include "stdint.h"
#define LEAF_SIZE 16                                   // 最小的块大小
#define MAXSIZE (nsizes - 1)                           // bd_sizes数组中最大的索引
#define BLK_SIZE(k) ((1L << (k)) * LEAF_SIZE)          // 第k大小的块的大小
#define HEAP_SIZE BLK_SIZE(MAXSIZE)                    // 堆的大小
#define NBLK(k) (1 << (MAXSIZE - k))                   // 第k大小的块的数量
#define ROUNDUP(n, sz) (((((n)-1) / (sz)) + 1) * (sz)) // 将n向上舍入到最接近的sz倍数

void bd_init(void *, void *);
void bd_free(void *);
void *bd_malloc(uint64_t nbytes);

#endif
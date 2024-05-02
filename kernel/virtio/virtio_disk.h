#include "virtio.h"
#include "config.h"
#include "stdint.h"
#include "block_cache.h"
static struct disk
{
    // VirtIO 驱动程序和设备主要通过一组RAM中的结构进行通信。pages[] 分配了该内存。
    // pages[] 是全局的（而不是调用 kalloc()），因为它必须由两个连续的、页对齐的物理内存页组成。
    char pages[2 * PAGE_SIZE];

    // pages[] 被划分为三个区域（描述符、可用和已用），如 VirtIO 规范的第2.6节所述
    // 对于传统接口的解释。
    // https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

    // pages[] 的第一个区域是一组（不是环）DMA描述符，
    // 驱动程序通过这些描述符告诉设备在哪里读写单个磁盘操作。这里有 NUM 个描述符。
    // 大多数命令由这些描述符的“链”（链接列表）组成。
    // 指向 pages[]。
    struct virtq_desc *desc;

    // 接下来是一个环，在这个环中驱动程序写入希望设备处理的描述符编号。
    // 它只包括每个链的头描述符。环有 NUM 个元素。
    // 指向 pages[]。
    struct virtq_avail *avail;

    // 最后是一个环，设备在其中写入设备已完成处理的描述符编号（只有每个链的头部）。
    // 有 NUM 个已用环条目。
    // 指向 pages[]。
    struct virtq_used *used;

    // 我们自己的记录。
    char free[NUM];    // 描述符是否空闲？
    uint16_t used_idx; // 我们已经查看到 used[2..NUM] 这么远。

    // 跟踪正在进行的操作的信息，
    // 用于完成中断到达时使用。
    // 由链的第一个描述符索引索引。
    struct
    {
        BlockCache *b; // 指向块缓存的指针
        char status;   // 操作状态
    } info[NUM];

    // 磁盘命令头。
    // 与描述符一一对应，方便使用。
    struct virtio_blk_req ops[NUM];
} __attribute__((aligned(PAGE_SIZE))) disk;
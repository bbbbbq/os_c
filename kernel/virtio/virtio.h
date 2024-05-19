#ifndef _VIRTIO_H_
#define _VIRTIO_H_
#include "debug.h"
#include "stdint.h"
#include "config.h"
#include "block_cache.h"
#define VIRTIO_BASE_ADDR 0x10001000
// VirtIO MMIO 控制寄存器，从 0x10001000 开始映射。
#define VIRTIO_MMIO_MAGIC_VALUE 0x000 // 魔数 0x74726976
#define VIRTIO_MMIO_VERSION 0x004     // 版本号；1 表示传统
#define VIRTIO_MMIO_DEVICE_ID 0x008   // 设备类型；1 表示网络，2 表示磁盘
#define VIRTIO_MMIO_VENDOR_ID 0x00c   // 厂商 ID 0x554d4551
#define VIRTIO_MMIO_DEVICE_FEATURES 0x010
#define VIRTIO_MMIO_DRIVER_FEATURES 0x020
#define VIRTIO_MMIO_GUEST_PAGE_SIZE 0x028  // 页大小，仅写
#define VIRTIO_MMIO_QUEUE_SEL 0x030        // 选择队列，仅写
#define VIRTIO_MMIO_QUEUE_NUM_MAX 0x034    // 当前队列的最大大小，只读
#define VIRTIO_MMIO_QUEUE_NUM 0x038        // 当前队列的大小，仅写
#define VIRTIO_MMIO_QUEUE_ALIGN 0x03c      // 环对齐，仅写
#define VIRTIO_MMIO_QUEUE_PFN 0x040        // 队列的物理页号，读/写
#define VIRTIO_MMIO_QUEUE_READY 0x044      // 准备好的标志
#define VIRTIO_MMIO_QUEUE_NOTIFY 0x050     // 通知，仅写
#define VIRTIO_MMIO_INTERRUPT_STATUS 0x060 // 中断状态，只读
#define VIRTIO_MMIO_INTERRUPT_ACK 0x064    // 中断确认，仅写
#define VIRTIO_MMIO_STATUS 0x070           // 状态，读/写

#define VIRTIO_MMIO_QUEUE_DESC_LOW 0x080 // physical address for descriptor table, write-only
#define VIRTIO_MMIO_QUEUE_DESC_HIGH 0x084
#define VIRTIO_MMIO_DRIVER_DESC_LOW 0x090 // physical address for available ring, write-only
#define VIRTIO_MMIO_DRIVER_DESC_HIGH 0x094
#define VIRTIO_MMIO_DEVICE_DESC_LOW 0x0a0 // physical address for used ring, write-only
#define VIRTIO_MMIO_DEVICE_DESC_HIGH 0x0a4

// 状态寄存器位，来自 qemu virtio_config.h
#define VIRTIO_CONFIG_S_ACKNOWLEDGE 1
#define VIRTIO_CONFIG_S_DRIVER 2
#define VIRTIO_CONFIG_S_DRIVER_OK 4
#define VIRTIO_CONFIG_S_FEATURES_OK 8

// 设备特性位
#define VIRTIO_BLK_F_RO 5          /* 磁盘为只读 */
#define VIRTIO_BLK_F_SCSI 7        /* 支持 SCSI 命令透传 */
#define VIRTIO_BLK_F_CONFIG_WCE 11 /* 配置中可设置回写模式 */
#define VIRTIO_BLK_F_MQ 12         /* 支持多于一个队列 */
#define VIRTIO_F_ANY_LAYOUT 27
#define VIRTIO_RING_F_INDIRECT_DESC 28
#define VIRTIO_RING_F_EVENT_IDX 29

// VirtIO 描述符数量。
// 必须是2的幂。
#define NUM 8

// 来自规范的单个描述符。
struct virtq_desc
{
    uint64_t addr;  // 数据缓冲区物理地址
    uint32_t len;   // 数据缓冲区长度
    uint16_t flags; // 标志位
    uint16_t next;  // 下一个描述符索引
};
#define VRING_DESC_F_NEXT 1  // 与另一个描述符链式相连
#define VRING_DESC_F_WRITE 2 // 设备进行写操作（相对于读）

// 完整的可用环，来自规范。
struct virtq_avail
{
    uint16_t flags;     // 总是零
    uint16_t idx;       // 驱动程序接下来将写入 ring[idx]
    uint16_t ring[NUM]; // 链头的描述符编号
    uint16_t unused;
};

// “已用”环中的一个条目，设备通过它告知驱动程序完成的请求。
struct virtq_used_elem
{
    uint32_t id;  // 已完成描述符链的起始索引
    uint32_t len; // 完成的数据长度
};

struct virtq_used
{
    uint16_t flags;                   // 总是零
    uint16_t idx;                     // 设备增加此索引以添加 ring[] 条目
    struct virtq_used_elem ring[NUM]; // 已完成的请求条目
};

#define VIRTIO_BLK_T_IN 0  // 读取磁盘
#define VIRTIO_BLK_T_OUT 1 // 写入磁盘

// 磁盘请求中第一个描述符的格式。
// 后面跟着两个描述符，包含块和一字节状态。
struct virtio_blk_req
{
    uint32_t type;     // VIRTIO_BLK_T_IN 或 VIRTIO_BLK_T_OUT
    uint32_t reserved; // 保留字段
    uint64_t sector;   // 扇区号
};

static void write_addr(uint32_t offset, uint32_t value)
{
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    *addr = value;
}
static uint32_t read_addr(uint32_t offset)
{
    volatile uint32_t *addr = (volatile uint32_t *)(VIRTIO_BASE_ADDR + offset);
    return *addr;
}
#define R(r) ((volatile uint32_t *)(VIRTIO0 + (r)))

BlockDevice *virtio_block_device_init();
void virtio_disk_init();
int alloc3_desc(int *idx);
void free_chain(int i);
void free_desc(int i);
int alloc_desc();
void virtio_disk_rw(BlockCache *b, int write);
void virtio_disk_intr();

#endif

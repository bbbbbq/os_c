#ifndef VIRTIO_H
#define VIRTIO_H
#include "stdint.h"
#include "config.h"
#define NUM_DESCRIPTORS 32
#define VIRTIO_BASE_ADDRESS 0x10001000

// MMIO 控制寄存器偏移量
#define VIRTIO_MMIO_MAGIC_VALUE 0x000      // 魔数，用于验证设备接口
#define VIRTIO_MMIO_VERSION 0x004          // 设备版本，1代表传统接口
#define VIRTIO_MMIO_DEVICE_ID 0x008        // 设备类型ID，1是网络设备，2是磁盘设备
#define VIRTIO_MMIO_VENDOR_ID 0x00c        // 厂商ID
#define VIRTIO_MMIO_DEVICE_FEATURES 0x010  // 设备支持的功能
#define VIRTIO_MMIO_DRIVER_FEATURES 0x020  // 驱动程序选择支持的设备功能
#define VIRTIO_MMIO_GUEST_PAGE_SIZE 0x028  // 客户机页面大小，只写
#define VIRTIO_MMIO_QUEUE_SEL 0x030        // 选择操作的虚拟队列
#define VIRTIO_MMIO_QUEUE_NUM_MAX 0x034    // 可配置的最大队列数量，只读
#define VIRTIO_MMIO_QUEUE_NUM 0x038        // 当前配置的队列数量，只写
#define VIRTIO_MMIO_QUEUE_ALIGN 0x03c      // 队列对齐，只写
#define VIRTIO_MMIO_QUEUE_PFN 0x040        // 队列页帧号，读写
#define VIRTIO_MMIO_QUEUE_READY 0x044      // 队列就绪状态
#define VIRTIO_MMIO_QUEUE_NOTIFY 0x050     // 队列通知
#define VIRTIO_MMIO_INTERRUPT_STATUS 0x060 // 中断状态，只读
#define VIRTIO_MMIO_INTERRUPT_ACK 0x064    // 中断确认，只写
#define VIRTIO_MMIO_STATUS 0x070           // 设备状态，读写

// 状态寄存器位
#define VIRTIO_CONFIG_S_ACKNOWLEDGE 1 // 设备已被驱动程序识别
#define VIRTIO_CONFIG_S_DRIVER 2      // 驱动程序知道如何操作设备
#define VIRTIO_CONFIG_S_DRIVER_OK 4   // 驱动程序准备好控制设备
#define VIRTIO_CONFIG_S_FEATURES_OK 8 // 驱动程序接受设备功能

// 设备特征位
#define VIRTIO_BLK_F_RO 5              /* 磁盘是只读的 */
#define VIRTIO_BLK_F_SCSI 7            /* 支持SCSI命令直通 */
#define VIRTIO_BLK_F_CONFIG_WCE 11     /* 配置中可用的写回模式 */
#define VIRTIO_BLK_F_MQ 12             /* 支持多个虚拟队列 */
#define VIRTIO_F_ANY_LAYOUT 27         /* 支持任意描述符布局 */
#define VIRTIO_RING_F_INDIRECT_DESC 28 /* 支持间接描述符 */
#define VIRTIO_RING_F_EVENT_IDX 29     /* 支持事件索引功能 */

// 描述符、环和请求类型定义
#define NUM 8 // 队列中描述符的数量，必须是2的幂

#define VRING_DESC_F_NEXT 1  // 描述符链中的下一个描述符
#define VRING_DESC_F_WRITE 2 // 设备写操作（相对于设备读）

#define VIRTIO_BLK_T_IN 0  // 读磁盘操作
#define VIRTIO_BLK_T_OUT 1 // 写磁盘操作
#define VIRTIO_MMIO_QUEUE_DESC_LOW 0x080 // physical address for descriptor table, write-only
#define VIRTIO_MMIO_QUEUE_DESC_HIGH 0x084
#define VIRTIO_MMIO_DRIVER_DESC_LOW 0x090 // physical address for available ring, write-only
#define VIRTIO_MMIO_DRIVER_DESC_HIGH 0x094
#define VIRTIO_MMIO_DEVICE_DESC_LOW 0x0a0 // physical address for used ring, write-only
#define VIRTIO_MMIO_DEVICE_DESC_HIGH 0x0a4
typedef struct
{
    uint64_t addr;  // 缓冲区的物理地址
    uint32_t len;   // 缓冲区的长度
    uint16_t flags; // 描述符的控制标志
    uint16_t next;  // 链中下一个描述符的索引
} VirtqDesc;

typedef struct
{
    uint16_t flags;                 // 表示环的状态的标志
    uint16_t idx;                   // 下一个要填充的槽的索引
    uint16_t ring[NUM_DESCRIPTORS]; // 可用描述符头的环形数组
    uint16_t used_event;            // 仅在协商了 VIRTIO_F_EVENT_IDX 功能位时使用
} VirtqAvail;

typedef struct
{
    uint32_t id;  // 使用的描述符链的起始描述符索引
    uint32_t len; // 输出的总长度
} VirtqUsedElem;

typedef struct
{
    uint16_t flags;                      // 表示环的状态的标志
    uint16_t idx;                        // 设备将填充的下一个槽的索引
    VirtqUsedElem ring[NUM_DESCRIPTORS]; // 已使用描述符头的环形数组
    uint16_t avail_event;                // 仅在协商了 VIRTIO_F_EVENT_IDX 功能位时使用
} VirtqUsed;

typedef struct
{
    uint32_t type; // VIRTIO_BLK_T_IN or ..._OUT
    uint32_t reserved;
    uint64_t sector;
} virtio_blk_req;

uint32_t read_reg(uint32_t *addr);
void write_reg(uint32_t *addr, uint32_t val);
#endif
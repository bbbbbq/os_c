/**
 * 资源来源及目的说明 - 本代码为FAT32文件系统的一部分，定义了与数据缓冲区相关的结构和操作，用于文件系统的数据读写缓存。
 * 作者：张三铜
 * 课程网址：http://01ketang.cc
 * 版权声明：本源代码为开源项目，可自由使用、学习、修改和分享。使用前请确保联系原作者。
 */
#ifndef Xbuf_H
#define Xbuf_H

#include "xtypes.h"
#include "xfat_obj.h"

// 定义缓冲区的状态标志
#define XFAT_BUF_STATE_FREE        (0 << 0)          // 缓冲区空闲，没有被写入任何数据
#define XFAT_BUF_STATE_CLEAN       (1 << 0)          // 缓冲区已清理，数据已经被写入磁盘
#define XFAT_BUF_STATE_DIRTY       (2 << 0)          // 缓冲区脏，已有数据写入但还未写入磁盘
#define XFAT_BUF_STATE_MSK         (3 << 0)          // 缓冲区状态掩码，用于获取当前状态

/**
 * 缓冲区结构定义
 */
typedef struct _xfat_buf_t {
    u8_t * buf;                         // 指向缓冲区数据的指针
    u32_t sector_no;                    // 缓冲区数据对应的扇区号
    u32_t flags;                        // 缓冲区的状态标志

    struct _xfat_buf_t * next;          // 指向下一个缓冲区的指针
    struct _xfat_buf_t * pre;           // 指向前一个缓冲区的指针
} xfat_buf_t;

// 获取缓冲区的当前状态
#define xfat_buf_state(buf)       (buf->flags & XFAT_BUF_STATE_MSK)

// 设置缓冲区的状态
void xfat_buf_set_state(xfat_buf_t * buf, u32_t state);

/**
 * 缓冲池结构定义
 */
typedef struct _xfat_bpool_t {
    xfat_buf_t * first;                 // 指向缓冲池中第一个缓冲区的指针
    xfat_buf_t * last;                  // 指向缓冲池中最后一个缓冲区的指针
    u32_t size;                         // 缓冲池的总大小
} xfat_bpool_t;

// 计算缓冲池所需的总空间大小
#define XFAT_BUF_SIZE(sector_size, sector_nr)    ((sizeof(xfat_buf_t) + (sector_size)) * sector_nr)

// 初始化缓冲池
xfat_err_t xfat_bpool_init(xfat_obj_t* obj, u32_t sector_size, u8_t * buffer, u32_t buf_size);

// 读取指定扇区到缓冲区
xfat_err_t xfat_bpool_read_sector(xfat_obj_t* obj, xfat_buf_t** buf, u32_t sector_no);

// 将缓冲区数据写入扇区
xfat_err_t xfat_bpool_write_sector(xfat_obj_t* obj, xfat_buf_t* buf, u8_t is_through);

// 分配一个缓冲区
xfat_err_t xfat_bpool_alloc(xfat_obj_t* obj, xfat_buf_t** buf, u32_t sector_no);

// 刷新缓冲池，将所有脏缓冲区的数据写入磁盘
xfat_err_t xfat_bpool_flush(xfat_obj_t* obj);

// 刷新指定范围内的扇区
xfat_err_t xfat_bpool_flush_sectors(xfat_obj_t* obj, u32_t start_sector, u32_t count);

// 使指定范围内的扇区无效
xfat_err_t xfat_bpool_invalid_sectors(xfat_obj_t* obj, u32_t start_sector, u32_t count);


#endif //Xbuf_H

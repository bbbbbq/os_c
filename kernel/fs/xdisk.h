/**
 * 资源来源及目的说明 - 本代码为FAT32文件系统的一部分，用于定义和管理磁盘及分区相关的操作和数据结构。
 * 作者：张三铜
 * 课程网址：http://01ketang.cc
 * 版权声明：本源代码为开源项目，可自由使用、学习、修改和分享。在使用前，请先联系原作者。
 */
#ifndef XDISK_H
#define XDISK_H

#include "xtypes.h"
#include "xfat_buf.h"
#include "xfat_obj.h"

/**
 * 文件系统类型枚举
 */
typedef enum {
    FS_NOT_VALID = 0x00,            // 无效类型
    FS_FAT32 = 0x01,                // FAT32类型
    FS_EXTEND = 0x05,               // 扩展分区
    FS_WIN95_FAT32_0 = 0xB,         // Windows 95 FAT32 (LBA)
    FS_WIN95_FAT32_1 = 0xC,         // Windows 95 FAT32
} xfs_type_t;

#pragma pack(1)

/**
 * MBR分区表条目结构定义
 */
typedef struct _mbr_part_t {
    u8_t boot_active;               // 活动分区标志
    u8_t start_header;              // 起始磁头号
    u16_t start_sector : 6;         // 起始扇区号
    u16_t start_cylinder : 10;      // 起始柱面号
    u8_t system_id;                 // 分区类型ID
    u8_t end_header;                // 结束磁头号
    u16_t end_sector : 6;           // 结束扇区号
    u16_t end_cylinder : 10;        // 结束柱面号
    u32_t relative_sectors;         // 分区起始相对扇区
    u32_t total_sectors;            // 分区总扇区数
} mbr_part_t;

#define MBR_PRIMARY_PART_NR 4       // 主分区数量

/**
 * 主引导记录（MBR）结构定义
 */
typedef struct _mbr_t {
    u8_t code[446];                 // 引导代码
    mbr_part_t part_info[MBR_PRIMARY_PART_NR]; // 分区信息
    u8_t boot_sig[2];               // 启动签名
} mbr_t;

#pragma pack()

// 磁盘设备前向声明
struct _xdisk_t;

/**
 * 磁盘操作接口定义
 */
typedef struct _xdisk_driver_t {
    xfat_err_t (*open) (struct _xdisk_t * disk, void * init_data);
    xfat_err_t (*close) (struct _xdisk_t * disk);
    xfat_err_t (*curr_time) (struct _xdisk_t * disk, struct _xfile_time_t *timeinfo);
    xfat_err_t (*read_sector) (struct _xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count);
    xfat_err_t (*write_sector) (struct _xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count);
} xdisk_driver_t;

/**
 * 磁盘设备结构定义
 */
typedef struct _xdisk_t {
    xfat_obj_t obj;                 // 基本对象

    const char * name;              // 设备名称
    u32_t sector_size;              // 扇区大小
    u32_t total_sector;             // 总扇区数
    xdisk_driver_t * driver;        // 设备驱动接口
    void * data;                    // 设备自定义数据

    xfat_bpool_t bpool;             // 缓冲池，用于临时存储数据
} xdisk_t;

/**
 * 磁盘分区结构定义
 */
typedef struct _xdisk_part_t {
    u32_t start_sector;             // 分区起始扇区
    u32_t total_sector;             // 分区总扇区数
    u32_t relative_sector;          // 相对扇区位置
    xfs_type_t type;                // 文件系统类型
    xdisk_t * disk;                 // 对应的磁盘设备
} xdisk_part_t;

// 磁盘操作函数
xfat_err_t xdisk_open(xdisk_t* disk, const char* name, xdisk_driver_t* driver,
                      void* init_data, u8_t* disk_buf, u32_t buf_size);
xfat_err_t xdisk_close(xdisk_t * disk);
xfat_err_t xdisk_get_part_count(xdisk_t *disk, u32_t *count);
xfat_err_t xdisk_get_part(xdisk_t *disk, xdisk_part_t *xdisk_part, int part_no);
xfat_err_t xdisk_curr_time(xdisk_t *disk, struct _xfile_time_t *timeinfo);
xfat_err_t xdisk_read_sector(xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count);
xfat_err_t xdisk_write_sector(xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count);
xfat_err_t xdisk_set_part_type(xdisk_part_t * part, xfs_type_t type);

#endif /* XDISK_H */

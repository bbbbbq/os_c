#ifndef XFAT_H
#define XFAT_H

#include "xtypes.h"
#include "xdisk.h"
#include "xfat_obj.h"

#pragma pack(1)
#define XFAT_NAME_LEN 30
#define X_FILEINFO_NAME_SIZE 30
// FAT文件系统的BPB结构
typedef struct _bpb_t
{
    u8_t BS_jmpBoot[3];   // 跳转指令
    u8_t BS_OEMName[8];   // OEM名称
    u16_t BPB_BytsPerSec; // 每扇区字节数
    u8_t BPB_SecPerClus;  // 每簇扇区数
    u16_t BPB_RsvdSecCnt; // 保留扇区数
    u8_t BPB_NumFATs;     // FAT表数量
    u16_t BPB_RootEntCnt; // 根目录项目数
    u16_t BPB_TotSec16;   // 总扇区数（16位）
    u8_t BPB_Media;       // 媒体描述符
    u16_t BPB_FATSz16;    // 每个FAT扇区数
    u16_t BPB_SecPerTrk;  // 每磁道扇区数
    u16_t BPB_NumHeads;   // 磁头数
    u32_t BPB_HiddSec;    // 隐藏扇区数
    u32_t BPB_TotSec32;   // 总扇区数（32位）
} bpb_t;

// FAT32扩展BPB结构
typedef struct _fat32_hdr_t
{
    u32_t BPB_FATSz32;      // FAT扇区大小
    u16_t BPB_ExtFlags;     // 扩展标志
    u16_t BPB_FSVer;        // 文件系统版本
    u32_t BPB_RootClus;     // 根目录起始簇号
    u16_t BPB_FsInfo;       // FSInfo扇区号
    u16_t BPB_BkBootSec;    // 备份引导扇区
    u8_t BPB_Reserved[12];  // 保留字段
    u8_t BS_DrvNum;         // 驱动器号
    u8_t BS_Reserved1;      // 保留字段
    u8_t BS_BootSig;        // 扩展签名
    u32_t BS_VolID;         // 卷序列号
    u8_t BS_VolLab[11];     // 卷标
    u8_t BS_FileSysType[8]; // 文件系统类型
} fat32_hdr_t;

// DBR (BIOS Parameter Block) 结构
typedef struct _dbr_t
{
    bpb_t bpb;         // BPB结构
    fat32_hdr_t fat32; // FAT32扩展结构
} dbr_t;

// 定义一些常用标记
#define CLUSTER_INVALID 0x0FFFFFFF // 无效的簇号
#define CLUSTER_FREE 0x00          // 空闲簇
#define FILE_DEFAULT_CLUSTER 0x00  // 默认簇号

#define DIRITEM_NAME_FREE 0xE5 // 目录项已删除标记
#define DIRITEM_NAME_END 0x00  // 目录项结束标记

#define DIRITEM_NTRES_BODY_LOWER 0x08 // 文件名小写
#define DIRITEM_NTRES_EXT_LOWER 0x10  // 扩展名小写
#define DIRITEM_NTRES_ALL_UPPER 0x00  // 全部大写
#define DIRITEM_NTRES_CASE_MASK 0x18  // 大小写掩码

#define DIRITEM_ATTR_READ_ONLY 0x01 // 文件属性：只读
#define DIRITEM_ATTR_HIDDEN 0x02    // 文件属性：隐藏
#define DIRITEM_ATTR_SYSTEM 0x04    // 文件属性：系统文件
#define DIRITEM_ATTR_VOLUME_ID 0x08 // 文件属性：卷标
#define DIRITEM_ATTR_DIRECTORY 0x10 // 文件属性：目录
#define DIRITEM_ATTR_ARCHIVE 0x20   // 文件属性：存档
#define DIRITEM_ATTR_LONG_NAME 0x0F // 文件属性：长文件名

#define DIRITEM_GET_FREE (1 << 0)
#define DIRITEM_GET_USED (1 << 2)
#define DIRITEM_GET_END (1 << 3)
#define DIRITEM_GET_ALL 0xff

// FAT目录日期结构
typedef struct _diritem_date_t
{
    u16_t day : 5;            // 日
    u16_t month : 4;          // 月
    u16_t year_from_1980 : 7; // 年
} diritem_date_t;

// FAT目录时间结构
typedef struct _diritem_time_t
{
    u16_t second_2 : 5; // 2秒
    u16_t minute : 6;   // 分钟
    u16_t hour : 5;     // 小时
} diritem_time_t;

// FAT目录项
typedef struct _diritem_t
{
    u8_t DIR_Name[8];    // 文件名
    u8_t DIR_ExtName[3]; // 扩展名
    u8_t DIR_Attr;       // 属性
    u8_t DIR_NTRes;
    u8_t DIR_CrtTimeTeenth;         // 创建时间的十分之一秒
    diritem_time_t DIR_CrtTime;     // 创建时间
    diritem_date_t DIR_CrtDate;     // 创建日期
    diritem_date_t DIR_LastAccDate; // 最后访问日期
    u16_t DIR_FstClusHI;            // 首簇高16位
    diritem_time_t DIR_WrtTime;     // 修改时间
    diritem_date_t DIR_WrtDate;     // 修改日期
    u16_t DIR_FstClusL0;            // 首簇低16位
    u32_t DIR_FileSize;             // 文件字节大小
} diritem_t;

/**
 * 一个用于文件系统的32位集群结构。
 */
typedef union _cluster32_t
{
    struct
    {
        u32_t next : 28;    // 下一个集群的索引
        u32_t reserved : 4; // 保留位，应设置为0
    } s;
    u32_t v; // 用于直接访问32位值的联合成员
} cluster32_t;

/**
 * FSInfo结构体，用于文件系统信息的存储。
 */
typedef struct _fsinfo_t
{
    u32_t FSI_LoadSig;       // 固定值，用于标识该结构体的开始，值为0x41615252
    u8_t FSI_Reserved1[480]; // 保留区域，用于将来的扩展
    u32_t FSI_StrucSig;      // 固定值，用于确认此结构的正确性，值为0x61417272
    u32_t FSI_Free_Count;    // 文件系统中剩余的空闲集群数量
    u32_t FSI_Next_Free;     // 下一个可用的空闲集群
    u8_t FSI_Reserved2[12];  // 另一个保留区域
    u32_t FSI_TrailSig;      // 结构结束的固定值标识，值为0xAA550000
} fsinfo_t;

/**
 * 定义了XFAT文件系统的主结构体。
 */
typedef struct _xfat_t
{
    xfat_obj_t obj; // XFAT对象的通用头部

    char name[XFAT_NAME_LEN]; // XFAT文件系统的名称
    u32_t fat_start_sector;   // FAT区的起始扇区号
    u32_t fat_tbl_nr;         // FAT表的数量
    u32_t fat_tbl_sectors;    // 每个FAT表占用的扇区数
    u32_t sec_per_cluster;    // 每个集群的扇区数
    u32_t root_cluster;       // 根目录的起始集群号
    u32_t cluster_byte_size;  // 每个集群的字节大小
    u32_t total_sectors;      // 文件系统总的扇区数

    u32_t fsi_sector;         // FSInfo扇区的位置
    u32_t backup_sector;      // 备份扇区的位置
    u32_t cluster_next_free;  // 下一个空闲集群的号码（估算值）
    u32_t cluster_total_free; // 总的空闲集群数（估算值）

    xdisk_part_t *disk_part; // 指向对应的磁盘分区信息的指针

    xfat_bpool_t bpool; // 缓冲池，用于缓存文件数据的结构体

    struct _xfat_t *next; // 指向下一个xfat结构体的指针

} xfat_t;

/**
 * 文件时间信息结构体。
 */
typedef struct _xfile_time_t
{
    u16_t year;  // 年份
    u8_t month;  // 月份
    u8_t day;    // 日期
    u8_t hour;   // 小时
    u8_t minute; // 分钟
    u8_t second; // 秒
} xfile_time_t;

/**
 * 文件类型枚举，定义了不同的文件类型。
 */
typedef enum _xfile_type_t
{
    FAT_DIR,  // 目录
    FAT_FILE, // 文件
    FAT_VOL,  // 卷标
} xfile_type_t;

/**
 * 文件信息结构体，用于存储关于文件的详细信息。
 */
typedef struct _xfileinfo_t
{
    char file_name[X_FILEINFO_NAME_SIZE]; // 文件名
    u32_t size;                           // 文件的字节大小
    u16_t attr;                           // 文件属性
    xfile_type_t type;                    // 文件类型
    xfile_time_t create_time;             // 创建时间
    xfile_time_t last_acctime;            // 最后访问时间
    xfile_time_t modify_time;             // 最后修改时间
} xfileinfo_t;

/**
 * 文件操作结构体，定义了一个文件实例的状态和操作信息。
 */
typedef struct _xfile_t
{
    xfat_obj_t obj; // 通用对象头部

    xfat_t *xfat; // 指向关联的XFAT结构的指针

    u32_t size;        // 文件大小
    u16_t attr;        // 文件属性
    xfile_type_t type; // 文件类型
    u32_t pos;         // 文件内的当前位置
    xfat_err_t err;    // 最近的错误状态

    u32_t start_cluster;      // 文件的起始集群号
    u32_t curr_cluster;       // 当前集群号
    u32_t dir_cluster;        // 父目录的集群号
    u32_t dir_cluster_offset; // 在父目录文件中的偏移位置

    xfat_bpool_t bpool; // 文件数据的缓冲池
} xfile_t;

/**
 * 文件搜索定位枚举，用于定义搜索文件的方法。
 */
typedef enum _xfile_orgin_t
{
    XFAT_SEEK_SET, // 从文件开始位置
    XFAT_SEEK_CUR, // 从当前位置
    XFAT_SEEK_END, // 从文件末尾
} xfile_orgin_t;

/**
 * 时间修改类型枚举，定义了可以修改的时间类型。
 */
typedef enum _stime_type_t
{
    XFAT_TIME_ATIME, // 访问时间
    XFAT_TIME_CTIME, // 创建时间
    XFAT_TIME_MTIME, // 修改时间
} stime_type_t;

/**
 * 集群大小枚举，定义了不同的集群大小选项。
 */
typedef enum _xcluster_size_t
{
    XFAT_CLUSTER_512B = 512,        // 512字节
    XFAT_CLUSTER_1K = (1 * 1024),   // 1KB
    XFAT_CLUSTER_2K = (2 * 1024),   // 2KB
    XFAT_CLUSTER_4K = (4 * 1024),   // 4KB
    XFAT_CLUSTER_8K = (8 * 1024),   // 8KB
    XFAT_CLUSTER_16K = (16 * 1024), // 16KB
    XFAT_CLUSTER_32K = (32 * 1024), // 32KB
    XFAT_CLUSTER_AUTO,              // 自动选择最优大小
} xcluster_size_t;

/**
 * 格式化控制结构体，用于文件系统格式化时的设置。
 */
typedef struct _xfat_fmt_ctrl_t
{
    xfs_type_t type;              // 文件系统类型
    xcluster_size_t cluster_size; // 集群大小
    const char *vol_name;         // 卷标名称
} xfat_fmt_ctrl_t;
typedef struct _xfat_fmt_info_t
{
    u8_t fat_count;        // FAT表的数量
    u8_t media;            // 媒体类型
    u32_t fat_sectors;     // FAT区占用的扇区数
    u32_t rsvd_sectors;    // 保留扇区数
    u32_t root_cluster;    // 根目录的起始集群号
    u16_t sec_per_cluster; // 每个集群占用的扇区数

    u32_t backup_sector; // 备份扇区的位置
    u32_t fsinfo_sector; // 文件系统信息扇区的位置
} xfat_fmt_info_t;

/**
 * 计算给定集群号的第一个扇区的扇区号。
 */
u32_t cluster_fist_sector(xfat_t *xfat, u32_t cluster_no);

/**
 * 检查集群号是否有效。
 */
xfat_err_t is_cluster_valid(u32_t cluster);

/**
 * 获取当前集群的下一个集群号。
 */
xfat_err_t get_next_cluster(xfat_t *xfat, u32_t curr_cluster_no, u32_t *next_cluster);

/**
 * 读取指定集群的数据到缓冲区。
 */
xfat_err_t read_cluster(xfat_t *xfat, u8_t *buffer, u32_t cluster, u32_t count);

/**
 * 初始化XFAT文件系统。
 */
xfat_err_t xfat_init(void);

/**
 * 挂载XFAT文件系统。
 */
xfat_err_t xfat_mount(xfat_t *xfat, xdisk_part_t *xdisk_part, const char *mount_name);

/**
 * 卸载XFAT文件系统。
 */
void xfat_unmount(xfat_t *xfat);

/**
 * 设置XFAT文件系统的缓冲区。
 */
xfat_err_t xfat_set_buf(xfat_t *xfat, u8_t *buf, u32_t size);

/**
 * 初始化文件系统格式化控制结构体。
 */
xfat_err_t xfat_fmt_ctrl_init(xfat_fmt_ctrl_t *ctrl);

/**
 * 格式化XFAT文件系统。
 */
xfat_err_t xfat_format(xdisk_part_t *xdisk_part, xfat_fmt_ctrl_t *ctrl);

/**
 * 打开一个文件。
 */
xfat_err_t xfile_open(xfile_t *file, const char *path);

/**
 * 在指定目录下打开一个子路径的文件。
 */
xfat_err_t xfile_open_sub(xfile_t *dir, const char *sub_path, xfile_t *sub_file);

/**
 * 关闭一个文件。
 */
xfat_err_t xfile_close(xfile_t *file);

/**
 * 获取目录中的第一个文件信息。
 */
xfat_err_t xdir_first_file(xfile_t *file, xfileinfo_t *info);

/**
 * 获取目录中的下一个文件信息。
 */
xfat_err_t xdir_next_file(xfile_t *file, xfileinfo_t *info);

/**
 * 获取文件的最近错误信息。
 */
xfat_err_t xfile_error(xfile_t *file);

/**
 * 清除文件的错误状态。
 */
void xfile_clear_err(xfile_t *file);

/**
 * 创建一个目录。
 */
xfat_err_t xfile_mkdir(const char *path);

/**
 * 创建一个文件。
 */
xfat_err_t xfile_mkfile(const char *path);

/**
 * 删除一个文件。
 */
xfat_err_t xfile_rmfile(const char *path);

/**
 * 删除一个目录。
 */
xfat_err_t xfile_rmdir(const char *path);

/**
 * 递归删除一个目录及其内容。
 */
xfat_err_t xfile_rmdir_tree(const char *path);

/**
 * 从文件中读取数据。
 */
xfile_size_t xfile_read(void *buffer, xfile_size_t elem_size, xfile_size_t count, xfile_t *file);

/**
 * 向文件中写入数据。
 */
xfile_size_t xfile_write(void *buffer, xfile_size_t elem_size, xfile_size_t count, xfile_t *file);

/**
 * 检查文件是否已到达末尾。
 */
xfat_err_t xfile_eof(xfile_t *file);

/**
 * 获取当前文件的读/写位置。
 */
xfile_size_t xfile_tell(xfile_t *file);

/**
 * 设置文件的读/写位置。
 */
xfat_err_t xfile_seek(xfile_t *file, xfile_ssize_t offset, xfile_orgin_t origin);

/**
 * 获取文件的大小。
 */
xfat_err_t xfile_size(xfile_t *file, xfile_size_t *size);

/**
 * 修改文件的大小。
 */
xfat_err_t xfile_resize(xfile_t *file, xfile_size_t size);

/**
 * 重命名一个文件或目录。
 */
xfat_err_t xfile_rename(const char *path, const char *new_name);

/**
 * 设置文件的访问时间。
 */
xfat_err_t xfile_set_atime(const char *path, xfile_time_t *time);

/**
 * 设置文件的修改时间。
 */
xfat_err_t xfile_set_mtime(const char *path, xfile_time_t *time);

/**
 * 设置文件的创建时间。
 */
xfat_err_t xfile_set_ctime(const char *path, xfile_time_t *time);

/**
 * 设置文件的缓冲区。
 */
xfat_err_t xfile_set_buf(xfile_t *file, u8_t *buf, u32_t size);

#endif
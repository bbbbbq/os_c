#ifndef FS_GLOBLE_H
#define FS_GLOBLE_H
#include "virtio_disk.h"
#define SectorsPerCluster 1
// Global variables for file system parameters
extern char g_OEMName[9];           // OEM字符串
extern uint16_t g_BytesPerSector;   // 每扇区字节数
extern uint8_t g_SectorsPerCluster; // 每簇扇区数
extern uint16_t g_ReservedSectors;  // 保留扇区数
extern uint8_t g_NumberOfFATs;      // FAT表的数量
extern uint16_t g_RootEntryCount;   // 根目录文件数最大值（FAT16）
extern uint32_t g_TotalSectors;     // 总扇区数
extern uint8_t g_MediaType;         // 媒体类型
extern uint16_t g_FATSize16;        // 每FAT扇区数（FAT16）
extern uint32_t g_FATSize32;        // 每FAT扇区数（FAT32）
extern uint32_t g_RootCluster;      // 根目录起始簇（FAT32）
extern char g_VolumeLabel[12];      // 卷标
extern char g_FileSystemType[9];    // 文件系统类型

#define SECTORS_PER_CLUSTER 4

// 定义获取第一个数据扇区的宏
#define FIRST_DATA_SECTOR (g_ReservedSectors + (g_NumberOfFATs * g_FATSize32))

// 定义根据簇号计算其起始扇区号的宏
#define CLUSTER_TO_SECTOR(cluster) (((cluster) - 2) * g_SectorsPerCluster + FIRST_DATA_SECTOR)
struct BPB_common
{
    char BS_jmpBoot[3];
    char BS_OEMName[8];
    uint16_t BPB_BytsPerSec;
    uint8_t BPB_SecPerClus;
    uint16_t BPB_RsvdSecCnt;
    uint8_t BPB_NumFATs;
    uint16_t BPB_RootEntCnt;
    uint16_t BPB_TotSec16;
    uint8_t BPB_Media;
    uint16_t BPB_FATSz16;
    uint16_t BPB_SecPerTrk;
    uint16_t BPB_NumHeads;
    uint32_t BPB_HiddSec;
    uint32_t BPB_TotSec32;
} __attribute__((__packed__));

struct BPB_32bit
{
    uint32_t BPB_FATSz32;    // FAT表大小（以扇区计）（在FAT32中，该值用来存储FAT表的扇区数）
    uint16_t BPB_ExtFlags;   // 扩展属性标志
    uint16_t BPB_FSVer;      // 文件系统版本
    uint32_t BPB_RootClus;   // 根目录簇号
    uint16_t BPB_FSInfo;     // FSINFO扇区的扇区号
    uint16_t BPB_BkBootSec;  // 备份引导扇区的扇区号
    char BPB_Reserved[12];   // 保留字段
    uint8_t BS_DrvNum;       // 中断13调用时的驱动器号
    uint8_t BS_Reserved1;    // 保留字段
    uint8_t BS_BootSig;      // 扩展引导标志
    uint32_t BS_VolID;       // 卷ID号
    char BS_VolLab[11];      // 卷标
    char BS_FilSysType[8];   // 文件系统类型
    uint8_t __padding[420];  // 对齐填充字节
    uint16_t Signature_word; // 标识字（固定为0xAA55）
} __attribute__((__packed__));
extern struct BPB_32bit bpb_32bit;

struct FSInfo
{
    uint32_t FSI_LeadSig[4]; /*   0 */
    uint8_t FSI_rsvc1[480];  /*   4 */
    uint32_t FSI_StrucBig;   /* 484 */
    uint32_t FSI_Free_Count; /* 488 */
    uint32_t FSI_Nxt_Free;   /* 492 */
    uint8_t FSI_rsvd2[12];   /* 496 */
    uint32_t FSI_TrailSig;   /* 508 */
} __attribute__((__packed__));
extern struct FSInfo fs_info;

void parse_and_print_boot_sector(const Block *block);
void parse_boot_sector(const Block *block);
void init_fat_32();
#endif
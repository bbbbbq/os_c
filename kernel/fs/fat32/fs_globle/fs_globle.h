#ifndef FS_GLOBLE_H
#define FS_GLOBLE_H
#include <stdint.h>
#include "fs_driver.h"
#define SECTOR_SIZE 512
#define BPB_LOCATION_SECTOR 0
#define BLOCK_SIZE 512
#define BPB_BACK_LOCATION_SECTOR 6
#define DISK_MEMORY_SUM 104857600
#define SECTORS_PER_CLUSTER 8
// 宏定义：根据簇号计算LBA地址
#define cluster_begin_lba 157
#define CLUSTER_TO_LBA(cluster_number) (cluster_begin_lba + ((cluster_number - 2) * SECTORS_PER_CLUSTER))

extern struct BPB_common bpb_commen;
// BIOS Parameter Block
// BS_jmpBoot：包含了一个 3 个字节的 riscv 格式的无条件跳转指令，用于跳转到操作系统的 bootstrap code。boot code 通常位于 boot sector 的尾部，跟在 BPB 后面。两种常见的 jump instruction 的格式为：

// BS_OEMName：占 8 个字节，可以在 FAT 的实现中被指定为任何值。其内容通常为格式化该磁盘的系统名称 (比如如果使用 Linux 的 mkfs.fat 命令创建磁盘镜像，该字段就会是 “mfks.fat”)。

// BPB_BytsPerSec：每个 sector 的字节数。该值只能是 512, 1024, 2048, 4096 中的一个。

// BPB_SecPerClus：每个 cluster 的 sector 数。该值必须大于 0 且是 2 的幂次。因为该字段只占一个字节，因此合法的值只有 1, 2, 4, 8, 16, 32, 64, 128。

// BPB_RsvdSecCnt：reserved region 中的 reserved sector 的个数。该值可以是任何非零整数。通常情况下，这个字段用于使数据区的开头 (即 cluster #2) 地址对齐。

// BPB_NumFATs：file allocation table 的个数。通常来说 2 是一个比较推荐的数值 (为了防止磁盘受损导致的文件系统损坏)，但 1 也是允许的。

// BPB_RootEntCnt：对于 FAT12 和 FAT16，该字段表示根目录下 32-byte 目录项的个数，BPB_RootEntCnt * 32 理应是 BPB_BytsPerSec 的偶数倍。在 FAT16 中，为了达到最大的兼容性，该值应当设置为 512。对于 FAT32，该值必须是 0。

// BPB_TotSec16：对于 FAT12 和 FAT16，该字段表示了文件系统中 sector 的数目。该字段只有 2 个字节，如果 sector 的数目大于等于 0x10000，则高位部分会存储到 BPB_TotSec32 中。对于 FAT32，该字段必须是 0。

// BPB_Media：合法的值有 0xF0, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE 和 0xFF。对于不可移动的固定磁盘，0xF8 是标准值；如果是可移动设备，该字段通常是 0xF0。

// BPB_FATSz16：对于 FAT12 和 FAT16，该字段表示一个 FAT 中 16-bit sector 的个数。对于 FAT32，该字段必须是 0。

// BPB_SecPerTrk：该字段只在一些有着特定几何特征 (一个 volume 被划分成多个轨道，有多个读写头) 的设备上有用，表示了每个 track 上 sector 的数目。该字段是为 0x13 号中断准备的。

// BPB_NumHeads：读写头数量。该字段也是为 0x13 号中断准备的。

// BPB_HiddSec：该字段表示了这个 FAT 分区后面的隐藏 sector 的数目，也是为 0x13 号中断准备的。对于没有分区的设备，该字段必须为 0。此外，利用该字段来对齐数据区是不正确的。

// BPB_TotSec32：对于 FAT32，该字段表示了文件系统中 sector 的数目。对于 FAT12 和 FAT16，如果 BPB_TotSec16 足够存放对应数值，则该字段为 0，否则该字段会存储数据的高位。
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
void initialize_BPB();

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
void initialize_BPB_32bit();

// FSI_LeadSig：值为 0x41615252，用于确认 FSInfo 格式的签名。
// FSI_Rsvd1：reserved，必须置为 0。
// FSI_StrucSig：值为 0x61417272，一个额外用于确认 FSInfo 格式的签名。
// FSI_Free_Count：该字段值为磁盘中空闲 cluster 的数量，如果不清楚则置为 0xFFFFFFFF。该字段必须在 volume 挂载时确定，手册建议该字段在 volume 解挂载时仍然保存正确的 count。
// FSI_Next_Free：保存了磁盘上第一个空闲 cluster 的编号，如果不清楚则置为 0xFFFFFFFF。该字段必须在 volume 挂载时确定，手册建议该字段在 volume 解挂载时仍然保存正确的编号。
// FSI_Rsvd2：reserved，必须置为 0。
// FSI_TrailSig：值为 0xAA550000，用于确认 FSInfo 格式的签名

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
void initialize_FSInfo();

// DIR_Name：“短”文件名，不超过 11 个字节。

// DIR_Attr：文件的属性，合法的属性值如下所示

// ATTR_READ_ONLY	ATTR_HIDDEN	ATTR_SYSTEM	ATTR_VOLUME_ID
// 0x01	0x02	0x04	0x08
// ATTR_DIRECTORY	ATTR_ARCHIVE	ATTR_LONG_NAME
// 0x10	0x20	0x0F (前四个的或)
// DIR_Attr 的高两个 bit 保留，必须被置为 0。

// DIR_NTRes：reserved，必须置为 0。

// DIR_CrtTimeTenth：创建时间 (低位)，以 1/10 秒为单位，合法范围是 0<=DIR_CrtTimeTenth<=199。

// DIR_CrtTime：创建时间 (高位)，颗粒度为 2s。

// DIR_CrtDate：创建日期。

// DIR_LstAccDate：上一次 access 该文件的日期。这里的 access 指的是对该文件/目录的 read/write 操作。该字段必须在文件修改时更新 (即写操作时)，填写的日期必须与 DIR_WrtDate 相同。

// DIR_FstClusHI：该文件/目录的第一个 cluster 的编号的高 16 位。该字段仅对 FAT32 有效，FAT12/FAT16 中该字段必须置为 0。

// DIR_WrtTime：上一次修改该文件的时间。在文件刚刚创建的时候，该字段的值应当与 DIR_CrtTime 一样。

// DIR_WrtDate：上一次修改该文件的日期。在文件刚刚创建的时候，该字段的值应当与 DIR_CrtDate 一样。

// DIR_FstClusLO：该文件/目录的第一个 cluster 的编号的低 16 位。

// DIR_FileSize：文件大小，以字节为单位。

// struct Dirent
// {
//     char DIR_Name[11];        /* 0  */
//     uint8_t DIR_Attr;         /* 11 */
//     uint8_t DIR_NTRes;        /* 12 */
//     uint8_t DIR_CrtTimeTenth; /* 13 */
//     uint16_t DIR_CrtTime;     /* 14 */
//     uint16_t DIR_CrtDate;     /* 16 */
//     uint16_t DIR_LstAccDate;  /* 18 */
//     uint16_t DIR_FstClusHI;   /* 20 */
//     uint16_t DIR_WrtTime;     /* 22 */
//     uint16_t DIR_WrtDate;     /* 24 */
//     uint16_t DIR_FstClusLO;   /* 26 */
//     uint32_t DIR_FileSize;    /* 28 */
// } __attribute__((__packed__));

// LDIR_Ord：该字段表示该长名目录项是其对应的短名目录项的第几个 (一个很长的名字可能需要多个长名目录项来存储)。对于最后一个长名目录项，其 LDIR_Ord 必须或上 LAST_LONG_ENTRY (0x40)。

// LDIR_Name1：长名的第 1 ~ 5 个字符。

// LDIR_Attr：长名目录项的 LDIR_Attr 必须被设置为 ATTR_LONG_NAME：

// ATTR_LONG_NAME = ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID;
// 用来判断一个目录项是否是长名目录项的 Mask 为

// #define ATTR_LONG_NAME_MASK (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID | ATTR_DIRECTORY | ATTR_ARCHIVE);
// LDIR_Type：必须被置为 0。

// LDIR_ChkSum：针对其对应的短名目录项算出来的一个校验值。

// LDIR_Name2：长名的第 6 ~ 11 个字符。

// LDIR_FstClusLO：必须被置为 0。

// LDIR_Name3：长名的第 12 ~ 13 个字符。

// 一个短名目录项对应的一系列附属的长名目录项在 LDIR_Ord 这个字段上应当满足如下要求：

// 第一个长名目录项满足 LDIR_Ord == 1。
// 后续的长名目录项的 LDIR_Ord 保证严格单调递增。
// 最后一个长名目录项满足 LDIR_Ord == (N | LAST_LONG_ENTRY)。
// 如果以上任何一条不满足，我们就认为该长名目录项集合被损坏了。
struct LongDirent
{
    uint8_t LDIR_Ord;        /* 0  */
    char LDIR_Name1[10];     /* 1  */
    uint8_t LDIR_Attr;       /* 11 */
    uint8_t LDIR_Type;       /* 12 */
    uint8_t LDIR_Chksum;     /* 13 */
    char LDIR_Name2[12];     /* 14 */
    uint16_t LDIR_FstClusLO; /* 26 */
    char LDIR_Name3[4];      /* 28 */
} __attribute__((__packed__));


void formate_fat32();

#endif
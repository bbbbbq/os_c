#include "fs_globle.h"
#include "console.h"

// Global variables for file system parameters
char g_OEMName[9];           // OEM字符串
uint16_t g_BytesPerSector;   // 每扇区字节数
uint8_t g_SectorsPerCluster; // 每簇扇区数
uint16_t g_ReservedSectors;  // 保留扇区数
uint8_t g_NumberOfFATs;      // FAT表的数量
uint16_t g_RootEntryCount;   // 根目录文件数最大值（FAT16）
uint32_t g_TotalSectors;     // 总扇区数
uint8_t g_MediaType;         // 媒体类型
uint16_t g_FATSize16;        // 每FAT扇区数（FAT16）
uint32_t g_FATSize32;        // 每FAT扇区数（FAT32）
uint32_t g_RootCluster;      // 根目录起始簇（FAT32）
char g_VolumeLabel[12];      // 卷标
char g_FileSystemType[9];    // 文件系统类型

void parse_and_print_boot_sector(const Block *block)
{
    const struct BPB_common *bpb = (const struct BPB_common *)block->data;
    const struct BPB_32bit *bpb32 = (const struct BPB_32bit *)(block->data + 36); // BPB_32bit 位于偏移36

    print_str("\nBPB Common:\n");
    print_str("OEM Name: ");
    char oemName[9];
    memcpy(oemName, bpb->BS_OEMName, 8);
    oemName[8] = '\0'; // Ensure null-terminated
    print_str(oemName);
    print_str("\nBytes Per Sector: ");
    print_uint32(bpb->BPB_BytsPerSec);
    print_str("\nSectors Per Cluster: ");
    print_uint32(bpb->BPB_SecPerClus);
    print_str("\nReserved Sector Count: ");
    print_uint32(bpb->BPB_RsvdSecCnt);
    print_str("\nNumber of FATs: ");
    print_uint32(bpb->BPB_NumFATs);
    print_str("\nRoot Entry Count: ");
    print_uint32(bpb->BPB_RootEntCnt);
    print_str("\nTotal Sectors 16: ");
    print_uint32(bpb->BPB_TotSec16);
    print_str("\nMedia: ");
    print_uint32(bpb->BPB_Media);
    print_str("\nFAT Size 16: ");
    print_uint32(bpb->BPB_FATSz16);
    print_str("\nSectors Per Track: ");
    print_uint32(bpb->BPB_SecPerTrk);
    print_str("\nNumber of Heads: ");
    print_uint32(bpb->BPB_NumHeads);
    print_str("\nHidden Sectors: ");
    print_uint32(bpb->BPB_HiddSec);
    print_str("\nTotal Sectors 32: ");
    print_uint32(bpb->BPB_TotSec32);

    print_str("\n\nBPB 32bit:\n");
    print_str("FAT Size 32: ");
    print_uint32(bpb32->BPB_FATSz32);
    print_str("\nExt Flags: ");
    print_uint32(bpb32->BPB_ExtFlags);
    print_str("\nFS Version: ");
    print_uint32(bpb32->BPB_FSVer);
    print_str("\nRoot Cluster: ");
    print_uint32(bpb32->BPB_RootClus);
    print_str("\nFS Info: ");
    print_uint32(bpb32->BPB_FSInfo);
    print_str("\nBackup Boot Sector: ");
    print_uint32(bpb32->BPB_BkBootSec);
    print_str("\nDrive Number: ");
    print_uint32(bpb32->BS_DrvNum);
    print_str("\nBoot Signature: ");
    print_uint32(bpb32->BS_BootSig);
    print_str("\nVolume ID: ");
    print_uint32(bpb32->BS_VolID);
    print_str("\nVolume Label: ");
    char volLabel[12];
    memcpy(volLabel, bpb32->BS_VolLab, 11);
    volLabel[11] = '\0'; // Ensure null-terminated
    print_str(volLabel);
    print_str("\nFile System Type: ");
    char sysType[9];
    memcpy(sysType, bpb32->BS_FilSysType, 8);
    sysType[8] = '\0'; // Ensure null-terminated
    print_str(sysType);
    print_str("\n");
}

void parse_boot_sector(const Block *block)
{
    const struct BPB_common *bpb = (const struct BPB_common *)block->data;
    const struct BPB_32bit *bpb32 = (const struct BPB_32bit *)(block->data + 36); // BPB_32bit 位于偏移36

    // 解析并存储全局变量
    memcpy(g_OEMName, bpb->BS_OEMName, 8);
    g_OEMName[8] = '\0'; // 确保字符串以null结尾
    g_BytesPerSector = bpb->BPB_BytsPerSec;
    g_SectorsPerCluster = bpb->BPB_SecPerClus;
    g_ReservedSectors = bpb->BPB_RsvdSecCnt;
    g_NumberOfFATs = bpb->BPB_NumFATs;
    g_RootEntryCount = bpb->BPB_RootEntCnt;
    g_TotalSectors = bpb->BPB_TotSec16 ? bpb->BPB_TotSec16 : bpb->BPB_TotSec32;
    g_MediaType = bpb->BPB_Media;
    g_FATSize16 = bpb->BPB_FATSz16;
    g_FATSize32 = bpb32->BPB_FATSz32;
    g_RootCluster = bpb32->BPB_RootClus;
    memcpy(g_VolumeLabel, bpb32->BS_VolLab, 11);
    g_VolumeLabel[11] = '\0'; // 确保字符串以null结尾
    memcpy(g_FileSystemType, bpb32->BS_FilSysType, 8);
    g_FileSystemType[8] = '\0'; // 确保字符串以null结尾

    // 这里可以继续添加代码以打印这些全局变量，或在其它函数中使用它们
}

void init_fat_32()
{
    Block block;
    block = read_block(0);
    parse_boot_sector(&block);
    init_root_entry();
}
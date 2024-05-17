#include "fs_globle.h"
#include <string.h>
#include <stdlib.h>
#include <string.h>
#include "driver.h"
#include <assert.h>
#include <stdio.h>
Device myDevice;
struct BPB_32bit bpb_32bit;
struct FSInfo fs_info;
struct BPB_common bpb_commen;
void initialize_BPB_common()
{
    bpb_commen.BS_jmpBoot[0] = 0xEB;
    bpb_commen.BS_jmpBoot[1] = 0x58;
    bpb_commen.BS_jmpBoot[2] = 0x90;
    strncpy(bpb_commen.BS_OEMName, "mkfs.fat", 8);
    bpb_commen.BPB_BytsPerSec = SECTOR_SIZE;

    // 设置每个 cluster 的 sector 数
    bpb_commen.BPB_SecPerClus = SECTORS_PER_CLUSTER;

    // 设置 reserved sector 的个数，通常为32个扇区
    bpb_commen.BPB_RsvdSecCnt = 32;

    // 设置 file allocation table 的个数
    bpb_commen.BPB_NumFATs = 2;

    // 设置根目录下的目录项数，对于FAT32，该值应为0
    bpb_commen.BPB_RootEntCnt = 0;

    // 设置文件系统中 sector 的数目
    bpb_commen.BPB_TotSec16 = 0;
    bpb_commen.BPB_TotSec32 = 8388576;

    // 设置磁盘类型，对于SD卡
    bpb_commen.BPB_Media = 0xF0;

    // 对于FAT32，该字段必须是0
    bpb_commen.BPB_FATSz16 = 0;

    // 可以设为0，表示不使用
    bpb_commen.BPB_SecPerTrk = 63;
    bpb_commen.BPB_NumHeads = 255;

    // 对于没有分区的设备，该字段为0
    bpb_commen.BPB_HiddSec = 0;
}

void initialize_BPB_32bit()
{
    // 初始化FAT表大小
    bpb_32bit.BPB_FATSz32 = 8176; 

    // 初始化扩展属性标志
    bpb_32bit.BPB_ExtFlags = 0;

    // 初始化文件系统版本
    bpb_32bit.BPB_FSVer = 0;

    // 初始化根目录簇号
    bpb_32bit.BPB_RootClus = 2; // 通常根目录簇号为2

    // 初始化 FSINFO扇区的扇区号
    bpb_32bit.BPB_FSInfo = 1; // 假设为1

    // 初始化备份引导扇区的扇区号
    bpb_32bit.BPB_BkBootSec = 6; // 假设为6

    // 初始化保留字段
    memset(bpb_32bit.BPB_Reserved, 0, sizeof(bpb_32bit.BPB_Reserved));

    // 初始化驱动器号
    bpb_32bit.BS_DrvNum = 0x80; // 假设为0x80，表示硬盘

    // 初始化保留字段
    bpb_32bit.BS_Reserved1 = 0;

    // 初始化扩展引导标志
    bpb_32bit.BS_BootSig = 0x29; // 表示下面的三个字段有效

    // 初始化卷ID号
    bpb_32bit.BS_VolID = 0x03f4885b; // 示例值

    // 初始化卷标
    strncpy(bpb_32bit.BS_VolLab, "NO NAME    ", 11);

    // 初始化文件系统类型
    strncpy(bpb_32bit.BS_FilSysType, "FAT32   ", 8);

    // 初始化对齐填充字节
    memset(bpb_32bit.__padding, 0, sizeof(bpb_32bit.__padding));

    // 初始化标识字
    bpb_32bit.Signature_word = 0xAA55;
}
void initialize_FSInfo()
{
    // 设置FSI_LeadSig
    fs_info.FSI_LeadSig[0] = 0x41615252;
    fs_info.FSI_LeadSig[1] = 0;

    // 初始化FSI_rsvc1
    memset(fs_info.FSI_rsvc1, 0, sizeof(fs_info.FSI_rsvc1));

    // 设置FSI_StrucSig
    fs_info.FSI_StrucBig = 0x61417272;

    // 设置FSI_Free_Count，不清楚则置为0xFFFFFFFF
    fs_info.FSI_Free_Count = 0x000ff7fb;

    // 设置FSI_Nxt_Free，不清楚则置为0xFFFFFFFF
    fs_info.FSI_Nxt_Free = 0x00000002;

    // 初始化FSI_rsvd2
    memset(fs_info.FSI_rsvd2, 0, sizeof(fs_info.FSI_rsvd2));

    // 设置FSI_TrailSig
    fs_info.FSI_TrailSig = 0xAA550000;
}

void init_fat32()
{
    //printf("init_fat32_start\n");
    initialize_BPB_common();
    initialize_BPB_32bit();
    initialize_FSInfo();

    char *buf = (char *)malloc(512);
    if (buf == NULL)
    {
        perror("Failed to allocate memory");
        return;
    }

    // 将 BPB_common 和 BPB_32bit 数据复制到缓冲区
    memcpy(buf, &bpb_commen, sizeof(bpb_commen));
    memcpy(buf + sizeof(bpb_commen), &bpb_32bit, sizeof(bpb_32bit));

<<<<<<< HEAD
    // 将缓冲区写入第一个块
    if (write_block(&myDevice, 0, buf) != 0)
=======
    // 写入 bpb_commen 和 bpb_32bit 到第 0 扇区
    int result = write_multiple_blocks(device, 0, bpb_buffer, sizeof(bpb_buffer));
    if (result != 1)
>>>>>>> a45d3da (完成创建目录功能)
    {
        perror("failed to write block\n");
        free(buf); // 确保在错误情况下释放内存
        return;
    }
<<<<<<< HEAD
    if (write_block(&myDevice, 5, buf) != 0)
=======

    // 写入 fs_info 到第一个扇区
    result = write_multiple_blocks(device, 1, &fs_info, sizeof(fs_info));
    if (result != 1)
>>>>>>> a45d3da (完成创建目录功能)
    {
        perror("failed to write block\n");
        free(buf); // 确保在错误情况下释放内存
        return;
    }
    printf("\n\n%ld\n\n",sizeof(fs_info));
    // 断言检查 FSInfo 大小，确保其大小为512字节

<<<<<<< HEAD
    // 将 FSInfo 数据复制到缓冲区
    memcpy(buf, &fs_info, sizeof(fs_info));
    write_multiple_sectors(&myDevice, buf, 1, 524);
    uint8_t data[] = {0xf8, 0xff, 0xff, 0x0f, 0xff, 0xff, 0xff, 0x0f, 0xf8, 0xff, 0xff, 0x0f};
    memset(buf,0,512);
    memcpy(buf, data, sizeof(data));
    if (write_block(&myDevice, 32, buf) != 0)
=======
    result = write_multiple_blocks(device, 6, &fs_info, sizeof(fs_info));
    if (result != 1)
>>>>>>> a45d3da (完成创建目录功能)
    {
        perror("failed to write block\n");
        free(buf); // 确保在错误情况下释放内存
        return;
    }
<<<<<<< HEAD
    free(buf); // 释放内存
}
=======

    result = write_multiple_blocks(device, 6, bpb_buffer, sizeof(bpb_buffer));
    if (result != 1)
    {
        printf("Error writing BPB to sector 0\n");
        return;
    }

    printf("FAT32 formatted successfully\n");
    
}
>>>>>>> a45d3da (完成创建目录功能)

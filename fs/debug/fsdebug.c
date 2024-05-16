
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fsdebug.h"

void parse_fsinfo(const char *filename)
{
    FILE *fp = fopen(filename, "rb");
    if (!fp)
    {
        perror("Failed to open file");
        return;
    }

    // 分配缓冲区
    char *buf = (char *)malloc(512);
    if (!buf)
    {
        perror("Failed to allocate memory");
        fclose(fp);
        return;
    }

    // 读取第1号块的数据
    if (fseek(fp, 512, SEEK_SET) != 0)
    {
        perror("Failed to seek to FSINFO sector");
        free(buf);
        fclose(fp);
        return;
    }

    if (fread(buf, 1, 512, fp) != 512)
    {
        perror("Failed to read FSINFO sector");
        free(buf);
        fclose(fp);
        return;
    }

    // 解析 FSInfo 结构体
    struct FSInfo fs_info;
    memcpy(&fs_info, buf, sizeof(fs_info));

    // 输出 FSInfo 信息
    printf("FSInfo:\n");
    printf("  FSI_LeadSig: 0x%08x\n", fs_info.FSI_LeadSig);
    printf("  FSI_StrucSig: 0x%08x\n", fs_info.FSI_StrucBig);
    printf("  FSI_Free_Count: %u\n", fs_info.FSI_Free_Count);
    printf("  FSI_Nxt_Free: %u\n", fs_info.FSI_Nxt_Free);
    printf("  FSI_TrailSig: 0x%08x\n", fs_info.FSI_TrailSig);

    // 清理
    free(buf);
    fclose(fp);
}

void parse_fat32_bpb(const char *filename)
{
    FILE *fp = fopen(filename, "rb");
    if (!fp)
    {
        perror("Failed to open file");
        return;
    }

    // 分配缓冲区
    char *buf = (char *)malloc(512);
    if (!buf)
    {
        perror("Failed to allocate memory");
        fclose(fp);
        return;
    }

    // 读取第0号块的数据
    if (fread(buf, 1, 512, fp) != 512)
    {
        perror("Failed to read block");
        free(buf);
        fclose(fp);
        return;
    }

    // 解析 BPB_common 结构体
    struct BPB_common bpb_common;
    memcpy(&bpb_common, buf, sizeof(bpb_common));

    // 解析 BPB_32bit 结构体
    struct BPB_32bit bpb_32bit;
    memcpy(&bpb_32bit, buf + sizeof(bpb_common), sizeof(bpb_32bit));

    // 输出 BPB_common 信息
    printf("BPB_common:\n");
    printf("  BS_jmpBoot: %02x %02x %02x\n", bpb_common.BS_jmpBoot[0], bpb_common.BS_jmpBoot[1], bpb_common.BS_jmpBoot[2]);
    printf("  BS_OEMName: %.8s\n", bpb_common.BS_OEMName);
    printf("  BPB_BytsPerSec: %u\n", bpb_common.BPB_BytsPerSec);
    printf("  BPB_SecPerClus: %u\n", bpb_common.BPB_SecPerClus);
    printf("  BPB_RsvdSecCnt: %u\n", bpb_common.BPB_RsvdSecCnt);
    printf("  BPB_NumFATs: %u\n", bpb_common.BPB_NumFATs);
    printf("  BPB_RootEntCnt: %u\n", bpb_common.BPB_RootEntCnt);
    printf("  BPB_TotSec16: %u\n", bpb_common.BPB_TotSec16);
    printf("  BPB_Media: 0x%02x\n", bpb_common.BPB_Media);
    printf("  BPB_FATSz16: %u\n", bpb_common.BPB_FATSz16);
    printf("  BPB_SecPerTrk: %u\n", bpb_common.BPB_SecPerTrk);
    printf("  BPB_NumHeads: %u\n", bpb_common.BPB_NumHeads);
    printf("  BPB_HiddSec: %u\n", bpb_common.BPB_HiddSec);
    printf("  BPB_TotSec32: %u\n", bpb_common.BPB_TotSec32);

    // 输出 BPB_32bit 信息
    printf("BPB_32bit:\n");
    printf("  BPB_FATSz32: %u\n", bpb_32bit.BPB_FATSz32);
    printf("  BPB_ExtFlags: %u\n", bpb_32bit.BPB_ExtFlags);
    printf("  BPB_FSVer: %u\n", bpb_32bit.BPB_FSVer);
    printf("  BPB_RootClus: %u\n", bpb_32bit.BPB_RootClus);
    printf("  BPB_FSInfo: %u\n", bpb_32bit.BPB_FSInfo);
    printf("  BPB_BkBootSec: %u\n", bpb_32bit.BPB_BkBootSec);
    printf("  BPB_Reserved: %.12s\n", bpb_32bit.BPB_Reserved);
    printf("  BS_DrvNum: %u\n", bpb_32bit.BS_DrvNum);
    printf("  BS_Reserved1: %u\n", bpb_32bit.BS_Reserved1);
    printf("  BS_BootSig: %u\n", bpb_32bit.BS_BootSig);
    printf("  BS_VolID: %u\n", bpb_32bit.BS_VolID);
    printf("  BS_VolLab: %.11s\n", bpb_32bit.BS_VolLab);
    printf("  BS_FilSysType: %.8s\n", bpb_32bit.BS_FilSysType);
    printf("  Signature_word: 0x%04x\n", bpb_32bit.Signature_word);

    // 清理
    free(buf);
    fclose(fp);
}

void print_sector_data(Device *device, uint64_t sector_num)
{
    if (!device || sector_num >= device->total_blocks)
    {
        fprintf(stderr, "Invalid device or sector number\n");
        return;
    }

    uint32_t block_size = device->block_size;
    char *buffer = (char *)malloc(block_size);
    if (!buffer)
    {
        perror("Failed to allocate memory");
        return;
    }

    // 读取指定扇区的数据
    if (read_block(device, sector_num, buffer) != 0)
    {
        fprintf(stderr, "Failed to read from device at sector %llu\n", sector_num);
        free(buffer);
        return;
    }

    // 打印读取到的数据的所有字节
    printf("Data read from sector %lu:\n", sector_num);
    for (uint32_t i = 0; i < block_size; i++)
    {
        printf("%02x ", (unsigned char)buffer[i]);
        if ((i + 1) % 16 == 0)
            printf("\n");
    }
    if (block_size % 16 != 0 && block_size % 16 != 0)
    {
        printf("\n");
    }
    printf("\n\n\n");
    free(buffer); // 释放内存
}

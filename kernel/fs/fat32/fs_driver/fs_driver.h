#ifndef FS_DRIVER_H
#define FS_DRIVER_H
#include "stdint.h"
#include "virtio_disk.h"
#include "fs_globle.h"
#define FIRST_DATA_SECTOR (g_ReservedSectors + (g_NumberOfFATs * g_FATSize32))

// 定义根据簇号计算其起始扇区号的宏
#define CLUSTER_TO_SECTOR(cluster) (((cluster) - 2) * g_SectorsPerCluster + FIRST_DATA_SECTOR)
typedef struct
{
    uint32_t cluser_num;
    uint32_t sector_num;
    uint32_t offset;
} location;

typedef struct
{
    uint32_t cluster_num;
    Block block_arr[1];
} cluster_data;
void write_cluser(cluster_data data);
cluster_data read_cluser(uint32_t cluser_num);

#endif
#include "fs_driver.h"
#include "fs_globle.h"
void write_cluser(cluster_data data)
{
    Block block_tmp_arr[SECTORS_PER_CLUSTER];
    for (int i = 0; i < SECTORS_PER_CLUSTER; i++)
    {
        block_tmp_arr[i] = data.block_arr[i];
        block_tmp_arr[i].sector_number = CLUSTER_TO_SECTOR(data.cluster_num) + i;
    }
    for (int i = 0; i < SECTORS_PER_CLUSTER; i++)
    {
        block_tmp_arr[i] = data.block_arr[i];
    }
    for (int i = 0; i < SECTORS_PER_CLUSTER; i++)
    {
        write_block(block_tmp_arr[i]);
    }
}

cluster_data read_cluster(uint32_t cluster_num)
{
    cluster_data clust;
    clust.cluster_num = cluster_num; // 设置簇号
    Block block_tmp_arr[SECTORS_PER_CLUSTER];
    for (int i = 0; i < SECTORS_PER_CLUSTER; i++)
    {
        block_tmp_arr[i].sector_number = CLUSTER_TO_SECTOR(cluster_num) + i;
        block_tmp_arr[i] = read_block(block_tmp_arr[i].sector_number);
    }
    for (int i = 0; i < SECTORS_PER_CLUSTER; i++)
    {
        clust.block_arr[i] = block_tmp_arr[i];
    }
    return clust;
}
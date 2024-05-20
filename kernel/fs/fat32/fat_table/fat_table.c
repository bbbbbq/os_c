#include "fat_table.h"
Fat32Table fat_table;
uint64_t find_first_valid_cluster()
{
    for (uint32_t i = 0; i < FAT_ENTRY_NUM; i++)
    {
        if (fat_table.entries[i].entry_value == 0x00000000)
        {
            return i + 2; // FAT表中的簇号从2开始
        }
    }
    return -1; // 没有找到有效簇
}

uint64_t find_next_free_cluster(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2; // 转换为FAT表索引
    for (uint32_t i = index; i < FAT_ENTRY_NUM; i++)
    {
        if (fat_table.entries[i].entry_value == 0x00000000)
        {
            return i + 2;
        }
    }
    return -1; // 没有找到空闲簇
}

uint64_t is_cluster_free(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2; // 转换为FAT表索引
    return fat_table.entries[index].entry_value == 0x00000000;
}

void set_cluster_end(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2;                  // 转换为FAT表索引
    fat_table.entries[index].entry_value = 0x0FFFFFFF; // FAT32的结束标记
}

void set_cluster_free(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2;                  // 转换为FAT表索引
    fat_table.entries[index].entry_value = 0x00000000; // 设置为0表示空闲
}

uint64_t parse_cluster_number(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2;            // 转换为FAT表索引
    return fat_table.entries[index].entry_value; // 返回簇的值
}

void set_cluster_number(uint64_t cluster_num, uint32_t new_cluster_number)
{
    uint32_t index = cluster_num - 2;                          // 转换为FAT表索引
    fat_table.entries[index].entry_value = new_cluster_number; // 更新FAT表项的值
}

uint64_t find_cluser_link_end(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2;
    uint32_t entry = fat_table.entries[index].entry_value;

    while (entry != FAT32_END_OF_CHAIN && entry < FAT_ENTRY_NUM)
    {
        cluster_num = entry;
        index = cluster_num - 2;
        entry = fat_table.entries[index].entry_value;
    }
    return cluster_num;
}

uint64_t is_end_of_cluster(uint64_t cluster_num)
{
    uint32_t index = cluster_num - 2; // FAT表的簇号从2开始
    return fat_table.entries[index].entry_value == 0x0FFFFFFF;
}

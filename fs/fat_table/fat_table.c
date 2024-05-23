#include "fat_table.h"
#include <assert.h>
#include "fs_driver.h"
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
Fat32Table fat_table;
void format_fat_table()
{
    for (int i = 0; i < FAT_ENTRY_NUM; ++i)
    {
        fat_table.entries[i].entry_value = 0x00000000;
    }
    fat_table.entries[0].entry_value = 0x0FFFFFF8;
}

// 在FAT表中查找第一个有效的簇（未被使用的簇）
uint64_t find_first_valid_cluster()
{
    for (uint64_t i = 0; i < FAT_ENTRY_NUM; ++i)
    {
        if (fat_table.entries[i].entry_value == 0)
        {
            return i;
        }
    }
    return -1; // 未找到有效簇
}

// 在FAT表中从给定索引开始查找下一个有效的簇
uint64_t find_next_free_cluster(uint64_t index)
{
    for (uint64_t i = index + 1; i < FAT_ENTRY_NUM; ++i)
    {
        if (fat_table.entries[i].entry_value == 0)
        {
            return i;
        }
    }
    return -1; // 未找到有效簇
}

uint64_t is_cluster_free(uint64_t index)
{
    if (index < FAT_ENTRY_NUM && fat_table.entries[index].entry_value == 0)
    {
        return 1; // 空闲簇
    }
    return 0; // 非空闲簇
}

// 将指定索引处的簇设置为有效
void set_cluser_end(uint64_t index)
{
    if (index < FAT_ENTRY_NUM)
    {
        fat_table.entries[index].entry_value = 0xFFFFFFFF;
    }
}

// 将指定索引处的簇设置为无效
void set_cluser_free(uint64_t index)
{
    if (index < FAT_ENTRY_NUM)
    {
        fat_table.entries[index].entry_value = 0;
    }
}

uint64_t parse_cluster_number(uint64_t index)
{
    uint32_t tmp = fat_table.entries[index].entry_value & 0x0FFFFFFF;
    return tmp;
}

void set_cluster_number(uint64_t index, uint32_t cluster_number)
{
    fat_table.entries[index].entry_value = cluster_number; // 设置新的簇号
}

// uint32_t fat_table_index_to_cluser_num(uint64_t index)
// {
//     uint32_t tmp = fat_table.entries[index].entry_value;
// }

// 检查指定索引处的簇是否是文件或目录的结尾
uint64_t is_end_of_cluster(uint64_t index)
{
    index = fat_table.entries[index].entry_value;
    // FAT32文件系统中，0xFFFFFF8 ~ 0xFFFFFFF 表示文件或目录的结束
    if ((index >= 0xFFFFFF8 && index <= 0xFFFFFFF) || index == 0xFFFFFFFF)
    {
        return 1; // 是结尾
    }
    return 0; // 不是结尾
}

uint64_t find_last_cluster(uint64_t index)
{
    if (is_end_of_cluster(index) == 1)
        return index;
    while (is_end_of_cluster(index) == 0)
    {
        index = parse_cluster_number(index);
    }
    return index;
}

void release_linked_clusters(uint32_t start_cluster)
{
    uint32_t current_cluster = start_cluster;
    // 循环释放链条上的所有簇
    while (!is_end_of_cluster(current_cluster - 2))
    {
        uint32_t next_cluster = parse_cluster_number(current_cluster - 2);
        set_cluser_free(current_cluster - 2);
        current_cluster = next_cluster;
    }
    set_cluser_free(start_cluster - 2);
}

bool init_fat_table()
{
    uint32_t start_block_num = 33;
    uint32_t end_block_num = 32 + (8176 * 4 + 511) / 512;
    uint32_t cur_block_num = start_block_num;
    uint32_t total_entries_needed = 8176;
    uint32_t entries_processed = 0;

    while (cur_block_num < end_block_num)
    {
        Block block = read_block(cur_block_num);
        uint32_t entries_in_this_block = BLOCK_SIZE / 4;
        if (entries_processed + entries_in_this_block > total_entries_needed)
        {
            entries_in_this_block = total_entries_needed - entries_processed;
        }

        for (int i = 0; i < entries_in_this_block; i++)
        {
            if (entries_processed >= total_entries_needed)
            {
                break; // 不再处理超出需要的表项
            }
            memcpy(&fat_table.entries[entries_processed].entry_value, &block.data[i * 4], sizeof(uint32_t));
            entries_processed++;
        }

        cur_block_num++;
        if (entries_processed >= total_entries_needed)
        {
            break; // 如果已处理足够的表项，提前退出循环
        }
    }
    return true;
}
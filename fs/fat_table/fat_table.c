#include "fat_table.h"
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
uint64_t find_next_valid_cluster(uint64_t index)
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

// 检查指定索引处的簇是否有效
uint64_t is_valid_cluster(uint64_t index)
{
    if (index < FAT_ENTRY_NUM && fat_table.entries[index].entry_value == 0)
    {
        return 1; // 有效簇
    }
    return 0; // 无效簇
}

// 将指定索引处的簇设置为有效
void convert_cluster_valid(uint64_t index)
{
    if (index < FAT_ENTRY_NUM)
    {
        fat_table.entries[index].entry_value = 0xFFFFFFFF;
    }
}

// 将指定索引处的簇设置为无效
void convert_cluster_invalid(uint64_t index)
{
    if (index < FAT_ENTRY_NUM)
    {
        fat_table.entries[index].entry_value = 0;
    }
}

uint64_t parse_cluster_number(uint64_t index)
{
    return fat_table.entries[index].entry_value & 0x0FFFFFFF;
}

void set_cluster_number(uint64_t index, uint64_t cluster_number)
{
    cluster_number &= 0x0FFFFFFF;
    fat_table.entries[index].entry_value &= 0xF0000000;     // 清除原有簇号
    fat_table.entries[index].entry_value |= cluster_number; // 设置新的簇号
}

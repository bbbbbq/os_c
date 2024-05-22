#ifndef FAT_TABLE_H
#define FAT_TABLE_H
#include "stdint.h"
#define FAT_ENTRY_NUM 8176
// FAT32表项的结构体定义
typedef struct
{
    uint32_t entry_value; // FAT32表项的值
} Fat32Entry;

typedef struct
{
    Fat32Entry entries[FAT_ENTRY_NUM]; // 所有FAT32表项
} Fat32Table;

extern Fat32Table fat_table;

uint64_t is_end_of_cluster(uint64_t index);
void format_fat_table();
uint64_t find_first_valid_cluster();
uint64_t find_next_free_cluster(uint64_t index);
uint64_t is_cluster_free(uint64_t index);
void set_cluser_end(uint64_t index);
void set_cluser_free(uint64_t index);
uint64_t parse_cluster_number(uint64_t index);
void set_cluster_number(uint64_t index, uint32_t cluster_number);
uint64_t find_last_cluster(uint64_t index);
void release_linked_clusters(uint32_t start_cluster);
#endif
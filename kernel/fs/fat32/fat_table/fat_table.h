#ifndef FAT_TABLE_H
#define FAT_TABLE_H
#include "stdint.h"
#include "fs_globle.h"
#define FAT_ENTRY_NUM g_FATSize32
#define FAT32_END_OF_CHAIN 0x0FFFFFFF
typedef struct
{
    uint32_t entry_value; // FAT32表项的值
} Fat32Entry;

typedef struct
{
    Fat32Entry entries[1576]; // 所有FAT32表项
} Fat32Table;
extern Fat32Table fat_table;

uint64_t is_end_of_cluster(uint64_t cluster_num);
uint64_t find_first_valid_cluster();
uint64_t find_next_free_cluster(uint64_t cluster_num);
uint64_t is_cluster_free(uint64_t cluster_num);
void set_cluster_end(uint64_t cluster_num);
void set_cluster_free(uint64_t cluster_num);
uint64_t parse_cluster_number(uint64_t cluster_num);
void set_cluster_number(uint64_t cluster_num, uint32_t cluster_number);
uint64_t find_cluser_link_end(uint64_t cluster_num);
#endif
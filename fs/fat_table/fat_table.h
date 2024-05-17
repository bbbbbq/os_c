#ifndef FAT_TABLE_H
#define FAT_TABLE_H
#include <stdint.h>
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

void format_fat_table();
uint64_t find_first_valid_cluster();
uint64_t find_next_valid_cluster(uint64_t index);
uint64_t is_valid_cluster(uint64_t index);
void convert_cluster_valid(uint64_t index);
void convert_cluster_invalid(uint64_t index);
uint64_t parse_cluster_number(uint64_t index);
void set_cluster_number(uint64_t index, uint64_t cluster_number);


#endif
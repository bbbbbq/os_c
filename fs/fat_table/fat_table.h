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

void formate_fat_table();
#endif
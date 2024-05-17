#ifndef FILE_H
#define FILE_H
#include "stdint.h"
#include "dir.h"
#define MAX_FILENAME_LENGTH 11
typedef struct 
{
    char filename[MAX_FILENAME_LENGTH + 1];
    uint64_t fat_entry_number; // 文件的索引节点号
    //uint32_t flags; //当前状态标记
    Dirent dir;
    //uint32_t device_number;     // 文件所属设备号
};

#endif
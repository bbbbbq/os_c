#ifndef FILE_H
#define FILE_H
#include "stdint.h"
#include "dir.h"
#define MAX_FILENAME_LENGTH 11
typedef struct 
{
    char filename[MAX_FILENAME_LENGTH + 1];
    uint64_t fat_entry_number;
    Dirent dir;
};
#endif
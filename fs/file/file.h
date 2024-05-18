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
}file_desciptor;

void read_file(char* name,void* buffer,Device* fat_device);
void over_write_file(char *name, void *buffer, Device *fat_device, size_t buffer_size);
void append_to_file(char *name, void *buffer, size_t buffer_size, Device *fat_device);
void remove_file(char* name);
void rename_file_or_dir(char *name, char *new_name);
#endif
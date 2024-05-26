#ifndef FILE_H
#define FILE_H
#include "stdint.h"
#include "dir.h"
#include "file_desc.h"
#define MAX_FILENAME_LENGTH 11
typedef struct
{
    char filename[MAX_FILENAME_LENGTH + 1];
    uint64_t fat_entry_number;
    Dirent dir;
} file_desciptor;

void read_file(char *name, void *buffer);
void over_write_file(char *name, void *buffer, size_t buffer_size);
void append_to_file(char *name, void *buffer, size_t buffer_size);
void remove_file(char *name);
void rename_file_or_dir(char *name, char *new_name);
void read_file_by_byte(Dirent *dir, uint32_t offset, char *buffer, size_t read_size);
void write_file_by_byte(Dirent *dir, uint32_t offset, char *buffer, size_t write_size);
Dirent *find_dir_by_path(char *path);
Dirent *create_file_or_dir_by_path(char *path, uint32_t attr);
bool append_to_file_by_dir(Dirent *dir, void *buffer, size_t buffer_size);
#endif
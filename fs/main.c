#include "fs_globle.h"
#include "dir.h"
#include "file.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "fs_driver.h"
#include <string.h>
#include "fat_table.h"
void print_block_data(const unsigned char *block_data, int block_size)
{
    for (int i = 0; i < block_size; ++i)
    {
        printf("%02x ", block_data[i]);
        if ((i + 1) % 16 == 0)
        {
            printf("\n");
        }
    }
}

void import_file_to_os(char *source_file_name, char *target_file_name, Dirent *parent_dir)
{
    // 打开源文件
    FILE *file = fopen(source_file_name, "rb");
    if (!file)
    {
        perror("Failed to open source file");
        exit(EXIT_FAILURE);
    }

    // 获取文件大小
    fseek(file, 0, SEEK_END);
    size_t file_size = ftell(file);
    fseek(file, 0, SEEK_SET);

    // 读取文件内容
    char *buffer = malloc(file_size);
    if (!buffer)
    {
        perror("Memory allocation failed");
        fclose(file);
        exit(EXIT_FAILURE);
    }
    if (fread(buffer, 1, file_size, file) != file_size)
    {
        perror("Failed to read file");
        free(buffer);
        fclose(file);
        exit(EXIT_FAILURE);
    }

    fclose(file);
    Dirent target_file = add_file_or_dir_to_parent_directory(target_file_name, ATTR_FILE, &root_dir_entry);
    over_write_file(target_file_name,buffer,file_size);

    free(buffer);
}

// int main()
// {
//     FILE *file;
//     char line[256]; // Assuming file names will not exceed 255 characters
//     const char *directory_prefix = "../user/riscv64/";

//     init_fat_table();
//     parse_root_dir();
//     init_root_entry();

//     file = fopen("output.txt", "r");
//     if (file == NULL)
//     {
//         perror("Failed to open output.txt");
//         return EXIT_FAILURE;
//     }

//     while (fgets(line, sizeof(line), file))
//     {
//         line[strcspn(line, "\n")] = 0;

//         char src_path[512];
//         snprintf(src_path, sizeof(src_path), "%s%s", directory_prefix, line);

//         printf("Processing file: %s\n", line);
//         import_file_to_os(src_path, line, &root_dir_entry);
//     }

//     printf("Final directory listing:\n");
//     ls_dir(&root_dir_entry);

//     fclose(file);
//     return 0;
// }

#include "fs_globle.h"
#include "dir.h"
#include "file.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "fs_driver.h"
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

// int main()
// {
//     const uint32_t block_size = 512;
//     const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size;
//     //BlockCache_manager_init();
//     //formate_fat32(&fat_device);
//     init_root_entry();
//     add_elf_to_root("brk.elf");
//     ls_dir(&root_dir_entry);
// }

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

    printf("add_file_or_dir_to_parent_directory\n");
    Dirent target_file = add_file_or_dir_to_parent_directory(target_file_name, ATTR_FILE, parent_dir);

    printf("append_to_file\n");
    // 将数据追加到目标文件
    over_write_file(target_file_name,buffer,file_size);

    free(buffer);
}

int main(int argc, char *argv[])
{
    // 检查是否有足够的参数传入
    if (argc < 3)
    {
        fprintf(stderr, "Usage: %s <source file> <target file>\n", argv[0]);
        return 1;
    }

    // 初始化根目录项
    init_root_entry();

    // 导入文件到操作系统中
    // argv[1] 为源文件名，argv[2] 为目标文件名
    import_file_to_os(argv[1], argv[2], &root_dir_entry);

    // 列出根目录下的文件
    ls_dir(&root_dir_entry);

    return 0;
}
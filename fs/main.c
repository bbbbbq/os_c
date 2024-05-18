#include "block_cache.h"
#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include "fs_globle.h"
#include "dir.h"
#include "queue.h"
Device fat_device;
void print_block_data(const unsigned char *block_data, int block_size)
{
    for (int i = 0; i <block_size ; ++i)
    {
        printf("%02x ", block_data[i]);
        if ((i + 1) % 16 == 0)
        {
            printf("\n");
        }
    }
}
int main()
{
    const uint32_t block_size = 512;
    const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size;
    if (initialize_device(&fat_device, "myfilesystem.img", total_blocks, block_size) != 0)
    {
        fprintf(stderr, "Failed to initialize device\n");
        return 1;
    }
    BlockCache_manager_init();
    formate_fat32(&fat_device);
    init_root_entry();
    add_file_or_dir_to_parent_directory("123",ATTR_DIRECTORY,&root_dir_entry,&fat_device);
    add_file_or_dir_to_parent_directory("wode", ATTR_DIRECTORY, &root_dir_entry, &fat_device);
    add_file_or_dir_to_parent_directory("wode123", ATTR_DIRECTORY, &root_dir_entry, &fat_device);
    add_file_or_dir_to_parent_directory("txt", ATTR_FILE, &root_dir_entry, &fat_device);
    //add_file_or_dir_to_parent_directory("txt", ATTR_FILE, &root_dir_entry, &fat_device);
    ls_dir(&root_dir_entry);
    Dirent *test = find_parent_directory_bfs("123", &root_dir_entry);
    if (test == NULL)
    {
        printf("123\n");
    }else
    {
        print_directory_entry(test);
    }
}

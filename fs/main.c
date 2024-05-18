#include "block_cache.h"
#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include "fs_globle.h"
#include "dir.h"
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
    char *buf = malloc(512);
    read_block(&fat_device, CLUSTER_TO_LBA(2), buf);
    print_by_cluster(&fat_device,2);
    init_root_entry();
    Dirent tmp_dirent;
    creat_dir_entry(&tmp_dirent, "123", ATTR_DIRECTORY);
    create_dir(&root_dir_entry, tmp_dirent, &fat_device);
    void *buffer = malloc(32);
    read_by_byte_cluser(&fat_device,2,32,32,buffer);
    print_hex_data(buffer,32);
    Dirent tmp = parse_directory_entry(buffer);
    print_directory_entry(&tmp);
    ls_dir(&root_dir_entry);
}

#include "block_cache.h"
#include "driver.h"
#include <stdio.h>
#include <stdlib.h>
#include "fs_globle.h"
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
    const uint32_t block_size = 512;                                      // 设置每个块的大小
    const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size; // 计算总块数
    if (initialize_device(&fat_device, "myfilesystem.img", total_blocks, block_size) != 0)
    {
        fprintf(stderr, "Failed to initialize device\n");
        return 1;
    }
    BlockCache_manager_init();
    formate_fat32(&fat_device);
    char *buf = malloc(512);
    read_block(&fat_device,CLUSTER_TO_LBA(2),buf);
    init_root_entry();
}
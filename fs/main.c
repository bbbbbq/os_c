#include <stdio.h>
#include <stdlib.h>
#include "driver.h"
#include "fs_globle.h"


int main()
{
    //printf("main_start\n");
    const uint32_t block_size = 512;                                      // 设置每个块的大小
    const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size; // 计算总块数

    // 初始化设备
    if (initialize_device(&myDevice, "raw_image.img", total_blocks, block_size) != 0)
    {
        fprintf(stderr, "Failed to initialize device\n");
        return 1;
    }
    //init_fat32();
    print_sector_data(&myDevice, FirstDataSector);
}

#include <stdio.h>
#include <stdlib.h>
#include "driver.h"
#include "fs_globle.h"
<<<<<<< HEAD

=======
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
>>>>>>> a45d3da (完成创建目录功能)

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
<<<<<<< HEAD
    //init_fat32();
    print_sector_data(&myDevice, FirstDataSector);
}
=======
    BlockCache_manager_init();
    formate_fat32(&fat_device);
    char *buf = malloc(512);
    read_block(&fat_device,CLUSTER_TO_LBA(2),buf);
    init_root_entry();
    Dirent tmp_dirent;
    creat_dir_entry(&tmp_dirent, "FILENAME", 0x10, 1234, 5678, 9101, 1121, 2222, 3333, 1000);
    create_dir(&root_dir_entry, tmp_dirent, &fat_device);
}
>>>>>>> a45d3da (完成创建目录功能)

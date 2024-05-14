#include <stdio.h>
#include <stdlib.h>
#include "driver.h"
#include "fs_globle.h"
int main()
{
    Device myDevice;
    const uint32_t block_size = 512;                                      // 设置每个块的大小
    const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size; // 计算总块数

    // 初始化设备
    if (initialize_device(&myDevice, "raw_image.img", total_blocks, block_size) != 0)
    {
        fprintf(stderr, "Failed to initialize device\n");
        return 1;
    }

    // 读取第一个块的数据
    char buffer[block_size];
    if (myDevice.read_block(&myDevice, 0, buffer) != 0)
    {
        fprintf(stderr, "Failed to read from device\n");
        return 1;
    }

    // 打印读取到的数据的前64字节，假设是可打印的字符
    printf("Data read from the first block:\n");
    for (int i = 0; i < 64; i++)
    {
        printf("%02x ", (unsigned char)buffer[i]);
        if ((i + 1) % 16 == 0)
            printf("\n");
    }

    return 0;
}
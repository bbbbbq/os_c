#include "dir.h"
#include "virtio_disk.h"
#include "fs_driver.h"
#include "string.h"
void create_dir_entry(Dirent *dir, const char *name, uint8_t attr)
{
    memset(dir, 0, sizeof(Dirent));

    // 格式化文件名
    size_t name_len = strlen(name);
    for (size_t i = 0; i < 11; i++)
    {
        dir->DIR_Name[i] = (i < name_len) ? name[i] : ' ';
    }

    // 设置文件属性
    dir->DIR_Attr = attr;

    // 静态分配的示例时间和日期：2021-01-01 12:00:00
    uint16_t static_date = ((2021 - 1980) << 9) | (1 << 5) | 1; // 年月日
    uint16_t static_time = (12 << 11) | (0 << 5) | (0 / 2);     // 时分秒

    dir->DIR_CrtTime = static_time;
    dir->DIR_CrtDate = static_date;
    dir->DIR_LstAccDate = static_date;
    dir->DIR_WrtTime = static_time;
    dir->DIR_WrtDate = static_date;

    dir->DIR_FstClusHI = 0;
    dir->DIR_FstClusLO = 0;
    dir->DIR_FileSize = 0;
}

void init_root_entry()
{
    create_dir_entry(&root_dir, "ROOT", 0x10);
    cluster_data data;
    data.cluster_num = 2;
    memcpy(data.block_arr[0].data, &root_dir, sizeof(root_dir));
    write_block(data.block_arr[0]);
}
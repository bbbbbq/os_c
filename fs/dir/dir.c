#include "dir.h"
#include <stdint.h>
#include <stddef.h>
#include "driver.h"
#include "fs_globle.h"
#include "fat_table.h"
extern Device fat_device;
void creat_dir_entry(Dirent *dir, const char *name, uint8_t attr, uint16_t crt_time,
                     uint16_t crt_date, uint16_t wrt_time, uint16_t wrt_date,
                     uint16_t fst_clus_hi, uint16_t fst_clus_lo, uint32_t file_size)
{
    // 检查参数有效性
    if (dir == NULL || name == NULL)
    {
        return;
    }

    // 复制文件名
    for (int i = 0; i < 11; ++i)
    {
        dir->DIR_Name[i] = name[i];
    }

    // 设置其他属性值
    dir->DIR_Attr = attr;
    dir->DIR_NTRes = 0;
    dir->DIR_CrtTimeTenth = 0;
    dir->DIR_CrtTime = crt_time;
    dir->DIR_CrtDate = crt_date;
    dir->DIR_LstAccDate = crt_date;
    dir->DIR_FstClusHI = fst_clus_hi;
    dir->DIR_WrtTime = wrt_time;
    dir->DIR_WrtDate = wrt_date;
    dir->DIR_FstClusLO = fst_clus_lo;
    dir->DIR_FileSize = file_size;
}

void init_root_entry()
{
    printf("init_root_entry_start\n");
    memset(&root_dir_entry, 0, sizeof(Dirent));
    strncpy(root_dir_entry.DIR_Name, "ROOT     ", 11);
    root_dir_entry.DIR_Attr = 0x10;
    write_by_cluster(&fat_device,2,&root_dir_entry,sizeof(Dirent));
    uint64_t index = find_first_valid_cluster();
    convert_cluster_valid(index);
    printf("init_root_entry_end\n");
}


void read_and_parse_root_entry(Device *device)
{
    // 为根目录项分配缓冲区
    Dirent root_dir_entry;
    uint64_t cluster_size = SECTOR_SIZE * 8; // 簇大小
    uint64_t root_cluster = 2;                      // 根目录所在的簇号
    void *buffer = malloc(cluster_size);            // 缓冲区大小为一个簇的大小
    if (buffer == NULL)
    {
        printf("Error: Memory allocation failed.\n");
        return;
    }
    uint64_t root_block = CLUSTER_TO_LBA(2);
    // 读取根目录所在的簇的数据
    if (read_by_byte(device, root_cluster, 0, sizeof(Dirent), buffer) != 0)
    {
        printf("Error: Failed to read root directory data.\n");
        free(buffer);
        return;
    }

    // 将缓冲区中的数据解析为根目录项
    memcpy(&root_dir_entry, buffer, sizeof(Dirent));

    // 输出根目录项的信息
    printf("Root Directory Entry:\n");
    printf("Name: %s\n", root_dir_entry.DIR_Name);
    printf("Attribute: %d\n", root_dir_entry.DIR_Attr);
    printf("Creation Time: %u\n", root_dir_entry.DIR_CrtTime);
    printf("Creation Date: %u\n", root_dir_entry.DIR_CrtDate);
    printf("Last Access Date: %u\n", root_dir_entry.DIR_LstAccDate);
    printf("First Cluster High: %u\n", root_dir_entry.DIR_FstClusHI);
    printf("Write Time: %u\n", root_dir_entry.DIR_WrtTime);
    printf("Write Date: %u\n", root_dir_entry.DIR_WrtDate);
    printf("First Cluster Low: %u\n", root_dir_entry.DIR_FstClusLO);
    printf("File Size: %lu\n", root_dir_entry.DIR_FileSize);

    // 释放缓冲区
    free(buffer);
}

uint32_t get_file_or_dir_size(const Dirent *entry)
{
    return entry->DIR_FileSize;
}

uint64_t get_creation_time(const Dirent *entry)
{
    uint64_t creation_time = entry->DIR_CrtDate;
    creation_time <<= 16;
    creation_time |= entry->DIR_CrtTime;
    return creation_time;
}

uint64_t get_last_modified_time(const Dirent *entry)
{
    uint64_t modified_time = entry->DIR_WrtDate;
    modified_time <<= 16;
    modified_time |= entry->DIR_WrtTime;
    return modified_time;
}

uint64_t get_last_access_time(const Dirent *entry)
{
    return entry->DIR_LstAccDate;
}

void set_file_or_dir_attribute(Dirent *entry, uint8_t attribute)
{
    entry->DIR_Attr = attribute;
}

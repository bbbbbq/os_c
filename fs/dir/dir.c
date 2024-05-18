#include "dir.h"
#include <stdint.h>
#include <stddef.h>
#include "driver.h"
#include "fs_globle.h"
#include "fat_table.h"
#include "stdio.h"
#include "string.h"
#include <stdlib.h>
#include <stdbool.h>
#include "fat_table.h"
// 外部变量声明
extern Device fat_device;
extern Fat32Table fat_table;
Dirent root_dir_entry;
// 创建目录项函数实现
void creat_dir_entry(Dirent *dir, const char *name, uint8_t attr)
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
    dir->DIR_CrtTime = 0;
    dir->DIR_CrtDate = 0;
    dir->DIR_LstAccDate = 0;
    dir->DIR_WrtTime = 0;
    dir->DIR_WrtDate = 0;
    dir->DIR_FileSize = 0;

    // 获取第一个有效簇号
    uint32_t first_valid_cluster = find_first_valid_cluster();
    dir->DIR_FstClusHI = (first_valid_cluster >> 16) & 0xFFFF; // 高16位
    dir->DIR_FstClusLO = first_valid_cluster & 0xFFFF;         // 低16位
}

// 初始化根目录函数实现
void init_root_entry()
{
    printf("init_root_entry_start\n");
    memset(&root_dir_entry, 0, sizeof(Dirent));
    strncpy(root_dir_entry.DIR_Name, "ROOT     ", 11);
    root_dir_entry.DIR_Attr = 0x10;
    root_dir_entry.DIR_FstClusHI=0x0000;
    root_dir_entry.DIR_FstClusLO=0x0002;
    write_by_cluster(&fat_device, 2, &root_dir_entry, sizeof(Dirent));
    uint64_t index = find_first_valid_cluster();
    set_cluser_end(index);
    printf("init_root_entry_end\n");
}

// 读取并解析根目录项函数实现
void read_and_parse_root_entry(Device *device)
{
    // 为根目录项分配缓冲区
    uint64_t cluster_size = SECTOR_SIZE * 8; // 簇大小
    uint64_t root_cluster = 2;               // 根目录所在的簇号
    void *buffer = malloc(cluster_size);     // 缓冲区大小为一个簇的大小
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

// 获取文件或目录大小函数实现
uint32_t get_file_or_dir_size(const Dirent *entry)
{
    return entry->DIR_FileSize;
}

// 获取创建时间函数实现
uint64_t get_creation_time(const Dirent *entry)
{
    uint64_t creation_time = entry->DIR_CrtDate;
    creation_time <<= 16;
    creation_time |= entry->DIR_CrtTime;
    return creation_time;
}

// 获取最后修改时间函数实现
uint64_t get_last_modified_time(const Dirent *entry)
{
    uint64_t modified_time = entry->DIR_WrtDate;
    modified_time <<= 16;
    modified_time |= entry->DIR_WrtTime;
    return modified_time;
}

// 获取最后访问时间函数实现
uint64_t get_last_access_time(const Dirent *entry)
{
    return entry->DIR_LstAccDate;
}

// 设置文件或目录属性函数实现
void set_file_or_dir_attribute(Dirent *entry, uint8_t attribute)
{
    entry->DIR_Attr = attribute;
}

// 提取目录项中的簇号函数实现
uint32_t extract_cluster_number(const Dirent *dir_entry)
{
    // 从目录项中提取簇号的高16位和低16位
    uint16_t cluster_hi = dir_entry->DIR_FstClusHI;
    uint16_t cluster_lo = dir_entry->DIR_FstClusLO;

    // 合并高16位和低16位得到完整的32位簇号
    uint32_t cluster_number = ((uint32_t)cluster_hi << 16) | cluster_lo;

    // 忽略最高的4位，只保留低28位
    cluster_number &= 0x0FFFFFFF;

    return cluster_number;
}

// 比较目录项名称函数实现
int compare_dir_entry_name(Dirent *dir_entry, char *name)
{
    return strncmp(dir_entry->DIR_Name, name, 11) == 0;
}

// 解析目录项函数实现
Dirent parse_directory_entry(void *buffer)
{
    Dirent dir_entry;

    // 将数据按字节逐个解析到目录项结构体中
    memcpy(dir_entry.DIR_Name, buffer, 11); // 目录项名称占用 11 字节
    dir_entry.DIR_Attr = *((uint8_t *)(buffer + 11));
    dir_entry.DIR_NTRes = *((uint8_t *)(buffer + 12));
    dir_entry.DIR_CrtTimeTenth = *((uint8_t *)(buffer + 13));
    dir_entry.DIR_CrtTime = *((uint16_t *)(buffer + 14));
    dir_entry.DIR_CrtDate = *((uint16_t *)(buffer + 16));
    dir_entry.DIR_LstAccDate = *((uint16_t *)(buffer + 18));
    dir_entry.DIR_FstClusHI = *((uint16_t *)(buffer + 20));
    dir_entry.DIR_WrtTime = *((uint16_t *)(buffer + 22));
    dir_entry.DIR_WrtDate = *((uint16_t *)(buffer + 24));
    dir_entry.DIR_FstClusLO = *((uint16_t *)(buffer + 26));
    dir_entry.DIR_FileSize = *((uint32_t *)(buffer + 28));

    return dir_entry;
}

// 查找目录项函数实现
Dirent *find_dir_entry(Dirent *parent_dir_entry, char *dir_name)
{
    uint32_t dir_cluster = extract_cluster_number(parent_dir_entry);
    uint8_t buffer[CLUSER_SIZE];
    read_by_cluster(&fat_device, dir_cluster, buffer);

    for (int i = 0; i < CLUSER_SIZE / sizeof(Dirent); i++)
    {
        // 计算当前目录项在缓冲区中的偏移量
        size_t offset = i * sizeof(Dirent);
        Dirent tmp = parse_directory_entry(buffer + offset);
        if (compare_dir_entry_name(&tmp, dir_name) == 1)
        {
            // 如果找到目录项，返回指向目录项的指针
            return &tmp;
        }
    }
    return NULL;
}

// 查找文件或目录尾部簇号函数实现
uint32_t find_file_or_dir_tail_cluser(Dirent *dir_entry)
{
    uint32_t cluser_num = extract_cluster_number(dir_entry);
    return (uint32_t)find_last_cluster((uint64_t)cluser_num - 2);
}
// ?????
void append_data_to_directory(Device *device, Dirent *dir_entry, const void *data, size_t data_size)
{
    uint32_t file_size = get_file_or_dir_size(dir_entry);
    uint32_t cluser_num = file_size / CLUSER_SIZE;
    if(file_size%CLUSER_SIZE>0) cluser_num ++;
    uint32_t cluser_offset_start = file_size%CLUSER_SIZE+1;
}

void set_file_or_dir_size(Dirent *entry, uint32_t new_size)
{
    entry->DIR_FileSize = new_size;
}

// 创建目录函数实现
void create_dir(Dirent *parent_dir_entry, Dirent new_dir_entry, Device *device)
{
    // 获取父目录的最后一个簇号和文件大小
    uint32_t last_dir_cluster_index = find_file_or_dir_tail_cluser(parent_dir_entry);
    uint64_t file_size = get_file_or_dir_size(parent_dir_entry);

    // 计算最后一个簇中文件的结束偏移量
    uint64_t last_cluster_end_offset = file_size % CLUSER_SIZE;

    // 如果剩余空间不够放置新的目录项，需要找到下一个有效簇
    if (CLUSER_SIZE - last_cluster_end_offset < sizeof(Dirent))
    {
        // 找到下一个有效簇
        uint32_t next_cluster_index = find_next_free_cluster(last_dir_cluster_index);

        // 更新父目录的页表项
        set_cluster_number(last_dir_cluster_index, next_cluster_index);
        set_cluster_number(next_cluster_index,0xffffffff);
            // 更新最后一个簇号和文件大小
        last_dir_cluster_index = next_cluster_index;
        last_cluster_end_offset = 0;
    }

    // 计算新目录项的写入位置
    uint64_t write_offset = last_cluster_end_offset;

    // 在最后一个簇中写入新的目录项
    if (write_by_byte_cluser(device, last_dir_cluster_index, write_offset, sizeof(Dirent), &new_dir_entry) != 0)
    {
        printf("Error: Failed to create directory.\n");
        return;
    }
    set_file_or_dir_size(parent_dir_entry, file_size + sizeof(Dirent));
    uint32_t new_dir_cluser_num = extract_cluster_number(&new_dir_entry);
    set_cluser_end(new_dir_cluser_num);
}


Dirent create_dirent_entry(const char *name, uint8_t attr, uint16_t crt_time,
                     uint16_t crt_date, uint16_t wrt_time, uint16_t wrt_date,
                     uint16_t fst_clus_hi, uint16_t fst_clus_lo, uint32_t file_size)
{
    Dirent dirent;
    strncpy(dirent.DIR_Name, name, 11);
    dirent.DIR_Attr = attr;
    dirent.DIR_NTRes = 0;
    dirent.DIR_CrtTimeTenth = 0;
    dirent.DIR_CrtTime = crt_time;
    dirent.DIR_CrtDate = crt_date;
    dirent.DIR_LstAccDate = crt_date; // Assume last access date is the same as creation date
    dirent.DIR_FstClusHI = fst_clus_hi;
    dirent.DIR_WrtTime = wrt_time;
    dirent.DIR_WrtDate = wrt_date;
    dirent.DIR_FstClusLO = fst_clus_lo;
    dirent.DIR_FileSize = file_size;
    return dirent;
}

uint32_t is_directory(const Dirent *entry)
{
    // 如果目录项的属性字段包含 ATTR_DIRECTORY 标志，则表示它是一个目录
    return (entry->DIR_Attr & ATTR_DIRECTORY) != 0;
}

void print_directory_entry(const Dirent *dir_entry)
{
    printf("Name: %s\n", dir_entry->DIR_Name);
    printf("Attribute: %u\n", dir_entry->DIR_Attr);
    printf("Cluster Number: %u\n", (uint32_t)((dir_entry->DIR_FstClusHI << 16) | dir_entry->DIR_FstClusLO));
    printf("File Size: %u bytes\n", dir_entry->DIR_FileSize);
    printf("\n");
}


bool ls_dir(Dirent *parent_dir)
{
    if (!is_directory(parent_dir))
    {
        printf("Not a directory.\n");
        return false;
    }

    uint32_t cluster_num = extract_cluster_number(parent_dir);
    uint32_t total_size = get_file_or_dir_size(parent_dir);
    uint32_t bytes_read = 0;

    // 循环读取每个簇的数据
    while (bytes_read < total_size)
    {
        uint8_t buffer[CLUSER_SIZE]; // 定义一个缓冲区用于读取簇的数据
        read_by_cluster(cluster_num, buffer, CLUSER_SIZE);

        // 解析目录项并输出
        for (int i = 0; i < CLUSER_SIZE / sizeof(Dirent); i++)
        {
            Dirent dir_entry = parse_directory_entry(buffer + i * sizeof(Dirent));
            if (dir_entry.DIR_Name[0] == '\0') // 目录项为空，表示结束
            {
                printf("End of directory.\n");
                return true;
            }

            // 输出目录项信息，可根据需要进行处理
            printf("Name: %s\n", dir_entry.DIR_Name);
            printf("Attribute: %u\n", dir_entry.DIR_Attr);
            printf("Cluster Number: %u\n", (uint32_t)((dir_entry.DIR_FstClusHI << 16) | dir_entry.DIR_FstClusLO));
            printf("File Size: %u bytes\n", dir_entry.DIR_FileSize);
            printf("\n");
        }

        // 更新已读取的字节数
        bytes_read += CLUSER_SIZE;

        // 检查是否需要读取下一个簇
        if (bytes_read < total_size)
        {
            cluster_num = (uint32_t)parse_cluster_number(cluster_num);
            if (cluster_num == 0xffffffff)
            {
                printf("End of directory.\n");
                return true;
            }
        }
    }
    return true;
}

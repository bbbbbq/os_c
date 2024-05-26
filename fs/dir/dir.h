#ifndef DIR_H
#define DIR_H

#include <stdint.h>
#include "fs_driver.h"
#include "stdbool.h"
#define ATTR_READ_ONLY 0x01 // 只读属性
#define ATTR_HIDDEN 0x02    // 隐藏属性
#define ATTR_SYSTEM 0x04    // 系统属性
#define ATTR_VOLUME_ID 0x08 // 卷标属性
#define ATTR_DIRECTORY 0x10 // 子目录属性
#define ATTR_ARCHIVE 0x20   // 归档属性
#define ATTR_FILE 0x03
#define ATTR_DELETED 0x05
// 目录项结构体定义
typedef struct
{
    char DIR_Name[11];        /* 文件或目录的名称 */
    uint8_t DIR_Attr;         /* 文件或目录的属性 */
    uint8_t DIR_NTRes;        /* 未使用，保留为0 */
    uint8_t DIR_CrtTimeTenth; /* 创建时间的1/100秒部分 */
    uint16_t DIR_CrtTime;     /* 创建时间的时、分、秒 */
    uint16_t DIR_CrtDate;     /* 创建日期的年、月、日 */
    uint16_t DIR_LstAccDate;  /* 最后访问日期的年、月、日 */
    uint16_t DIR_FstClusHI;   /* 文件或目录的第一个簇号的高16位 */
    uint16_t DIR_WrtTime;     /* 最后修改时间的时、分、秒 */
    uint16_t DIR_WrtDate;     /* 最后修改日期的年、月、日 */
    uint16_t DIR_FstClusLO;   /* 文件或目录的第一个簇号的低16位 */
    uint32_t DIR_FileSize;    /* 文件的大小（以字节为单位） */
} Dirent __attribute__((__packed__));

// 根目录项
extern Dirent root_dir_entry;

// 创建目录项函数声明
void creat_dir_entry(Dirent *dir, const char *name, uint8_t attr);
// 初始化根目录函数声明
void init_root_entry();

// 读取并解析根目录项函数声明
void read_and_parse_root_entry();

// 获取文件或目录大小函数声明
uint32_t get_file_or_dir_size(const Dirent *entry);

// 获取创建时间函数声明
uint64_t get_creation_time(const Dirent *entry);

// 获取最后修改时间函数声明
uint64_t get_last_modified_time(const Dirent *entry);

// 获取最后访问时间函数声明
uint64_t get_last_access_time(const Dirent *entry);

// 设置文件或目录属性函数声明
void set_file_or_dir_attribute(Dirent *entry, uint8_t attribute);

// 提取目录项中的簇号函数声明
uint32_t extract_cluster_number(const Dirent *dir_entry);

// 比较目录项名称函数声明
int compare_dir_entry_name(Dirent *dir_entry, char *name);

// 解析目录项函数声明
Dirent parse_directory_entry(void *buffer);

// 查找目录项函数声明
Dirent *find_dir_entry(Dirent *parent_dir_entry, char *dir_name);

// 查找文件或目录尾部簇号函数声明
uint32_t find_file_or_dir_tail_cluser(Dirent *dir_entry);

// 创建目录函数声明
void create_dir(Dirent *parent_dir_entry, Dirent new_dir_entry);

void append_data_to_directory(Dirent *dir_entry, const void *data, size_t data_size);

void set_file_or_dir_size(Dirent *entry, uint32_t new_size);

bool ls_dir(Dirent *parent_dir);

void print_directory_entry(const Dirent *dir_entry);

uint32_t is_directory(const Dirent *entry);

Dirent add_file_or_dir_to_parent_directory(char *name, uint64_t attr, Dirent *parent_dir);

Dirent *find_directory_bfs(char *name, Dirent start_dir);

Dirent *find_parent_directory_bfs(char *name, Dirent *start_dir);

uint32_t dir_child_dir_num(Dirent *parent_dir);

uint32_t find_dir_cluster_and_offset(char *name, uint32_t *cluser_num, uint32_t *offset);

uint32_t update_dir(char *name, Dirent *new_dir);

void parse_root_dir();
#endif
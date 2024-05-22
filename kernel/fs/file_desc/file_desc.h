#ifndef FILE_DESC_H
#define FILE_DESC_H
#include "../fat32/dir/dir.h"
#include "stdint.h"
#include "buddy.h"
#include "file.h"
#include "debug.h"
typedef struct
{
    Dirent dir;
    int64_t ref_cnt;
    uint64_t offset;
    bool readable;
    bool writable;
    bool append;
} Inode;

inline bool Inode_is_readable(Inode inode) { return inode.readable; };
inline bool Inode_is_writable(Inode inode) { return inode.writable; };
uint32_t Inode_read_file(Inode *inode, char *buffer);
uint32_t Inode_write_file(Inode *inode, char *buffer, size_t size);
Inode Inode_new_by_file_name(char *name, bool read, bool write);
Inode Inode_new_by_dirent(Dirent *dir, bool read, bool write, bool append);
#define RDONLY 0x0      // 只读标志位，由于它是0，意味着默认不设置任何位
#define WRONLY (1 << 0) // 只写标志位
#define RDWR (1 << 1)   // 读写标志位
#define CREATE (1 << 9) // 创建文件标志位
#define TRUNC (1 << 10) // 截断文件标志位
typedef struct
{
    uint32_t flags;
} OpenFlags;

#define O_RDONLY 0x000
#define O_WRONLY 0x001
#define O_RDWR 0x002
#define O_CREAT 0x040
#define O_EXCL 0x080
#define O_TRUNC 0x100
#define O_APPEND 0x200
#define O_DIRECTORY 0x200000

void read_write(const OpenFlags *flags, bool *readable, bool *writable);

#define MAX_PATH_COMPONENTS 10
#define MAX_COMPONENT_LENGTH 12
#define MAX_PATH_LENGTH 1024
typedef struct
{
    char value[MAX_PATH_LENGTH]; // 存储路径的字符串
} Path;
bool is_valid_path(const Path *path);
void parse_path(const char *path, char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH]);
void remove_last_path_component(char *path);
const char *get_last_path_component(const char *path);
void analyze_open_flags(OpenFlags *of, bool *readable, bool *writable, bool *creat, bool *excl, bool *trunc, bool *append, bool *directory);
#endif
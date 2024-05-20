#ifndef DIR_H
#define DIR_H
#include "stdint.h"
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
Dirent root_dir;
void create_dir_entry(Dirent *dir, const char *name, uint8_t attr);
// 初始化根目录函数声明
void init_root_entry();
uint32_t get_file_or_dir_size(const Dirent *entry);
uint64_t get_creation_time(const Dirent *entry);
#endif
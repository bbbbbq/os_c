#include "dir.h"
#include <stdint.h>
#include <stddef.h>
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

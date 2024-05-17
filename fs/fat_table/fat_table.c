#include "fat_table.h"
Fat32Table fat_table;

void format_fat_table()
{
    for (int i = 0; i < FAT_ENTRY_NUM; ++i)
    {
        fat_table.entries[i].entry_value = 0x00000000;
    }
    fat_table.entries[0].entry_value = 0x0FFFFFF8;
}

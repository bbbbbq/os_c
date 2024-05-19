#include "buddy.h"
#include "string.h"
char *strdup(const char *str)
{
    size_t len = strlen(str) + 1;           // 计算字符串的长度，包括终止符 '\0'
    char *new_str = (char *)bd_malloc(len); // 分配足够的内存空间
    if (new_str != NULL)
    {
        strcpy(new_str, str); // 复制字符串到新分配的内存空间
    }
    return new_str;
}
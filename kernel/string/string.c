
#include "string.h"

int strlen_t(const char *src)
{
    int i;
    for (i = 0; src[i] != '\0'; i++)
    {
    }
    return i;
}

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    for (; len != 0; len--)
    {
        *dest++ = *src++;
    }
}

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    for (int i = 0; i < num; ++i)
    {
        if (((char *)ptr1)[i] != ((char *)ptr2)[i])
        {
            return ((char *)ptr1)[i] - ((char *)ptr2)[i];
        }
    }
    return 0;
}

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    u8 temp[len];
    i32 i;
    for (i = 0; len != 0; len--)
    {
        temp[i] = *src++;
    }
    for (; len != 0; len--)
    {
        *dest++ = temp[i];
    }
}

void memset_t(void *dest, u8 val, u32 len)
{
    u8 *dst = (u8 *)dest;

    for (; len != 0; len--)
    {
        *dst++ = val;
    }
}

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }

int strcmp_t(const char *str1, const char *str2)
{
    while (*str1 && *str2)
    {
        if (*str1 != *str2)
        {
            return (*str1) - (*str2);
        }
        ++str1;
        ++str2;
    }
    return (*str1) - (*str2);
}

char *strcpy_t(char *dest, const char *src)
{
    char *tmp = dest;

    while (*src)
    {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

char *strcat_t(char *dest, const char *src)
{
    char *tmp = dest;

    while (*dest != '\0')
    {
        dest++;
    }
    while (*src)
    {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    while (len--)
    {
        *dest++ = *src++;
    }
}

void memset(void *dest, u8 val, u32 len)
{
    memset_t(dest, val, len);
}
int memcmp(const void *ptr1, const void *ptr2, size_t num)
{
    const unsigned char *p1 = ptr1, *p2 = ptr2;
    for (size_t i = 0; i < num; i++)
    {
        if (p1[i] != p2[i])
        {
            return (int)p1[i] - (int)p2[i];
        }
    }
    return 0;
}

void *memmove(void *dest, const void *src, size_t n)
{
    u8 *d = (u8 *)dest;
    const u8 *s = (const u8 *)src;

    // 如果源和目标相同，就没有复制的必要
    if (d == s)
    {
        return dest;
    }

    // 如果源地址小于目标地址，并且两者重叠，则从后向前复制
    if (s < d && d < s + n)
    {
        for (size_t i = n; i != 0; i--)
        {
            d[i - 1] = s[i - 1];
        }
    }
    else
    {
        // 否则，从前向后复制
        for (size_t i = 0; i < n; i++)
        {
            d[i] = s[i];
        }
    }

    return dest;
}
char *strcpy(char *restrict d, const char *s)
{
    char *dest = d;
    while ((*dest++ = *s++) != '\0')
        ;
    return d;
}

size_t strlen(const char *s)
{
    size_t len = 0;
    while (*s != '\0')
    {
        len++;
        s++;
    }
    return len;
}

char *strncpy(char *dest, const char *src, size_t n)
{
    size_t i;
    for (i = 0; i < n && src[i] != '\0'; i++)
    {
        dest[i] = src[i];
    }
    for (; i < n; i++)
    {
        dest[i] = '\0'; // Fill the rest of the array with null characters if src is shorter than n
    }
    return dest;
}

int strncmp(const char *s1, const char *s2, size_t n)
{
    for (size_t i = 0; i < n; i++)
    {
        if (s1[i] != s2[i])
        {
            return ((unsigned char)s1[i] - (unsigned char)s2[i]);
        }
        if (s1[i] == '\0')
        {
            return 0; // Both strings are equal until the end of one of them
        }
    }
    return 0; // Strings are equal up to the first n characters
}

char *strchr(const char *str, int c)
{
    // 循环遍历字符串直到遇到字符串结束符 '\0'
    while (*str != '\0')
    {
        if (*str == (char)c)
        {                       // 检查当前字符是否是要查找的字符
            return (char *)str; // 返回指向该字符的指针
        }
        str++; // 移动到下一个字符
    }

    // 如果搜索字符是 '\0'，则应返回指向它的指针
    if (c == '\0')
    {
        return (char *)str;
    }

    return NULL; // 如果未找到字符，则返回 NULL
}

char *strncat(char *dest, const char *src, size_t n)
{
    char *ptr = dest + strlen(dest); // 找到 dest 的结尾
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    {
        ptr[i] = src[i]; // 复制字符
    }
    ptr[i] = '\0'; // 确保字符串正确结束

    return dest; // 返回 dest 的指针
}

int strcmp(const char *s1, const char *s2)
{
    while (*s1 && (*s1 == *s2))
    {
        s1++;
        s2++;
    }
    return (unsigned char)*s1 - (unsigned char)*s2;
}

char *strrchr(const char *str, int c)
{
    const char *last_occurrence = NULL; // 初始化指针，用于存放最后一次出现的位置

    // 遍历字符串直到遇到字符串终结符 '\0'
    while (*str != '\0')
    {
        if (*str == (char)c)
        {
            last_occurrence = str; // 如果找到匹配字符，更新最后出现的位置
        }
        str++; // 移动到下一个字符
    }

    // 需要检查字符串最后一个字符后的'\0'，因为可能需要查找'\0'
    if (*str == (char)c)
    {
        last_occurrence = str;
    }

    return (char *)last_occurrence; // 强制类型转换并返回最后一次出现的位置
}

char *get_last_part(const char *path)
{
    if (path == NULL)
    {
        return NULL; // 如果输入的路径为NULL，返回NULL
    }

    // 使用 strrchr 来找到最后一个出现的斜杠
    const char *last_slash = strrchr(path, '/');
    if (last_slash == NULL)
    {
        return (char *)path; // 如果没有斜杠，返回整个字符串
    }
    else
    {
        return (char *)(last_slash + 1); // 返回最后一个斜杠后面的部分
    }
}
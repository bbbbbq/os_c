
#include "string.h"


int strlen_t(const char *src)
{
    int i;
    for (i = 0; src[i] != '\0'; i++) {
    }
    return i;
}

void memcpy_t(u8 *dest, const u8 *src, u32 len)
{
    for (; len != 0; len--) {
        *dest++ = *src++;
    }
}

int memcmp_t(const void *ptr1, const void *ptr2, u32 num)
{
    for (int i = 0; i < num; ++i) {
        if (((char*)ptr1)[i] != ((char*)ptr2)[i]) {
            return ((char*)ptr1)[i] - ((char*)ptr2)[i];
        }
    }
    return 0;
}

void memmove_t(u8 *dest, const u8 *src, u32 len)
{
    u8 temp[len];
    i32 i;
    for (i = 0; len != 0; len--) {
        temp[i] = *src++;
    }
    for (; len != 0; len--) {
        *dest++ = temp[i];
    }
}

void memset_t(void *dest, u8 val, u32 len)
{
    u8 *dst = (u8 *)dest;

    for (; len != 0; len--) {
        *dst++ = val;
    }
}

void bzero_t(void *dest, u32 len) { memset_t(dest, 0, len); }

int strcmp_t(const char *str1, const char *str2)
{
    while (*str1 && *str2) {
        if (*str1 != *str2) {
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

    while (*src) {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

char *strcat_t(char *dest, const char *src)
{
    char *tmp = dest;

    while (*dest != '\0') { dest++; }
    while (*src) {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

void memcpy(u8 *dest, const u8 *src, u32 len)
{
    while (len--) {
        *dest++ = *src++;
    }
}

void memset(void *dest, u8 val, u32 len)
{
    memset_t(dest,val,len);
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


void *memmove(void *dest, const void *src, size_t n) {
    u8 *d = (u8 *)dest;
    const u8 *s = (const u8 *)src;

    // 如果源和目标相同，就没有复制的必要
    if (d == s) {
        return dest;
    }

    // 如果源地址小于目标地址，并且两者重叠，则从后向前复制
    if (s < d && d < s + n) {
        for (size_t i = n; i != 0; i--) {
            d[i - 1] = s[i - 1];
        }
    } else {
        // 否则，从前向后复制
        for (size_t i = 0; i < n; i++) {
            d[i] = s[i];
        }
    }

    return dest;
}
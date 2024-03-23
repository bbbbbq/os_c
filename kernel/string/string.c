
#include "string.h"


unsigned long strlen_user(const char *src)
{
    unsigned long i;
    for (i = 0; src[i] != '\0'; i++) {
    }
    return i;
}

void memcpy(char *dest, const char *src, unsigned int len)
{
    for (; len != 0; len--) {
        *dest++ = *src++;
    }
}

int memcmp_user(const void *ptr1, const void *ptr2, unsigned int num)
{
    for (int i = 0; i < num; ++i) {
        if (((char*)ptr1)[i] != ((char*)ptr2)[i]) {
            return ((char*)ptr1)[i] - ((char*)ptr2)[i];
        }
    }
    return 0;
}

void memmove_user(char *dest, const char *src, unsigned int len)
{
    char temp[len];
    unsigned int i;
    for (i = 0; len != 0; len--) {
        temp[i] = *src++;
    }
    for (; len != 0; len--) {
        *dest++ = temp[i];
    }
}

void memset_user(void *dest, char val, unsigned int len)
{
    char *dst = (char *)dest;

    for (; len != 0; len--) {
        *dst++ = val;
    }
}


int strcmp_user(const char *str1, const char *str2)
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

char *strcpy_user(char *dest, const char *src)
{
    char *tmp = dest;

    while (*src) {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

char *strcat_user(char *dest, const char *src)
{
    char *tmp = dest;

    while (*dest != '\0') { dest++; }
    while (*src) {
        *dest++ = *src++;
    }

    *dest = '\0';

    return tmp;
}

void strrev_user(char* str) {
    int len = strlen_user(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

#ifndef STRING_H_
#define STRING_H_

// void memcpy_user(char *dest, const char *src, unsigned int len);
void memset_user(void *dest, char val, unsigned int len);
void memmove_user(char *dest, const char *src, unsigned int len);
int memcmp_user(const void *ptr1, const void *ptr2, unsigned int num);
int strcmp_user(const char *str1, const char *str2);
char *strcpy_user(char *dest, const char *src);
char *strcat_user(char *dest, const char *src);
unsigned long strlen_user(const char *src);
void strrev_user(char* str);
#endif
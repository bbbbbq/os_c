#ifndef CONSOLE_H
#define CONSOLE_H
#include "stdint.h"
void print_str(const char* str);
void print_uint32(uint32_t value);
void reverse_str(char* str, int length);
void print_uint64(uint64_t value);
void print_uint64_hex(uint64_t value);
#include <stddef.h>

void print_hex(const void *data, size_t size);

#endif
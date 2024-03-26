// syscall.h

#ifndef SYSCALL_H
#define SYSCALL_H
#include "stdint.h"

// 定义系统调用ID
#define SYSCALL_WRITE 64
#define SYSCALL_EXIT  93

// 系统调用函数原型
int64_t syscall(uint64_t syscall_id, uint64_t args[3]);
int32_t exit(int32_t value);
int64_t write(uint64_t fd, const void *buf, uint64_t count);
#endif // SYSCALL_H

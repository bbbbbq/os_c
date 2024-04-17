// syscall.h
#ifndef SYSCALL_H
#define SYSCALL_H
#include "stdint.h"

// 定义系统调用ID

#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#define SYSCALL_YIELD 124
#define SYSCALL_SET_PRIORITY 140
#define SYSCALL_GET_TIME 169
#define SYSCALL_MUNMAP 215
#define SYSCALL_MMAP 222
// 系统调用函数原型
int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2);
int32_t exit(int32_t value);
int64_t write(uint64_t fd, char *buf, uint64_t count);
int64_t yield();
size_t read(int32_t fd, uint8_t *buf, size_t len);
int64_t sys_waitpid(int64_t pid, int *exit_code_ptr);
#endif // SYSCALL_H

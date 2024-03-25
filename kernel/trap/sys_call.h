#ifndef SYS_CALL_H
#define SYS_CALL_H
#include "batch.h"
#include "console.h"
#define SYSCALL_WRITE 1
#define SYSCALL_EXIT 2

extern void sys_write(unsigned int fd, const char *buf, uint32_t len);
extern void sys_exit(int xstate);

long syscall(long syscall_id, long arg1, long arg2, long arg3);
#endif
#ifndef SYSCALL_H
#define SYSCALL_H

#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#include "string.h"
void sys_exit(int exit_code);
long long sys_write(unsigned long long fd,const char *buf);

#endif
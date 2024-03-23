#ifndef SYSCALL_H
#define SYSCALL_H

#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#include "string.h"
long long  syscall(unsigned long long  id, unsigned long long  arg0, unsigned long long  arg1, unsigned long long  arg2);
void sys_exit(int exit_code);
long long sys_write(unsigned long long fd,const char *buf);

#endif

#ifndef __SYSCALL_H
#define __SYSCALL_H

#include "stdint.h"
#include "string.h"
int64_t sys_write(uint64_t fd, const char *buf, uint64_t count);
void sys_exit(int32_t id);
void sys_yield(void);
int64_t sys_set_priority(int64_t priority);
int64_t sys_getpid(void);
int64_t sys_munmap(uint64_t addr, uint64_t len);
int64_t sys_fork(void);
int64_t sys_exec(const char *path);
int64_t sys_mmap(uint64_t addr, uint64_t length, uint64_t prot);
int64_t sys_waitpid(int64_t pid, int32_t *status);
int64_t sys_spawn(const char *path);

// Generic syscall function
int64_t syscall(uint64_t id, uint64_t arg0, uint64_t arg1, uint64_t arg2);

#endif /* __SYSCALL_H */

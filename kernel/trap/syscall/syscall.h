// syscall.h
#ifndef SYSCALL_H
#define SYSCALL_H
#include "stdint.h"
#include "file_desc.h"
// 定义系统调用ID
#define SYS_GETCWD 17
#define SYS_PIPE2 59
#define SYS_DUP 23
#define SYS_DUP3 24
#define SYS_CHDIR 49
#define SYS_OPENAT 56
#define SYS_CLOSE 57
#define SYS_READ 63
#define SYS_WRITE 64
#define SYS_LINKAT 37
#define SYS_UNLINKAT 35
#define SYS_MKDIRAT 34
#define SYS_UMOUNT2 39
#define SYS_MOUNT 40
#define SYS_FSTAT 80
#define SYS_CLONE 220
#define SYS_EXECVE 221
#define SYS_WAIT4 260
#define SYS_EXIT 93
#define SYS_GETPPID 173
#define SYS_GETPID 172
#define SYS_BRK 214
#define SYS_MUNMAP 215
#define SYS_MMAP 222
#define SYS_TIMES 153
#define SYS_UNAME 160
#define SYS_SCHED_YIELD 124
#define SYS_GETTIME 169
#define SYS_NANOSLEEP 101
#define SYS_GETDENTS64 61
#define SYS_SPAWN 400
#define SYS_OPEN 180
struct timespec
{
    uint64_t tv_sec; // 秒
    long tv_nsec;    // 纳秒
};

// 系统调用函数原型
int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2);
int32_t exit(int32_t value);
int64_t write(uint64_t fd, char *buf, size_t count);
int64_t yield();
size_t read(int32_t fd, uint8_t *buf, size_t len);
int64_t sys_waitpid(int64_t pid, int *exit_code_ptr);
int64_t sys_fork();
int64_t sys_exec(char *path);
int64_t sys_getpid();
void sys_exit(int32_t status);
int64_t sys_openat(int32_t fd, char *path, OpenFlags flage);
int64_t sys_open(const char *pathname, uint32_t flage_t);
int32_t sys_close(uint32_t fd);
int64_t SYS_getdents64(int64_t fd, char *buffer);
int64_t SYS_read(int64_t fd, char *buffer, uint32_t count);
int64_t SYS_mkdirat(char *path, uint64_t mode);
int64_t SYS_write(int64_t fd, char *buffer, uint64_t count);
int64_t SYS_times(char *uts);
int64_t SYS_uname(char *uts);
int64_t SYS_dup3(int64_t old_fd, int64_t new_fd);
int64_t SYS_dup(int64_t fd);
int64_t SYS_chdir(char *path);
int64_t SYS_getcwd(char *buffer, size_t size);
int64_t SYS_fstat(int64_t fd, char *kst);
int64_t SYS_brk(uint64_t address_change);
int64_t sys_munmap(uint64_t start, uint64_t len);
int64_t sys_getppid();
uint64_t sys_mmap(uint64_t addr, uint64_t len, uint64_t prot,
                  uint64_t flags, uint64_t fd, uint64_t pgoff);
int64_t SYS_gettimeofday(char *buffer, int64_t t1);
#endif

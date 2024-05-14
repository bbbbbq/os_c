#include "syscall.h"
#include "string.h"

// 系统调用号定义
#define SYSCALL_READ 63
#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#define SYSCALL_YIELD 124
#define SYSCALL_SET_PRIORITY 140
#define SYSCALL_GET_TIME 169
#define SYSCALL_GETPID 172
#define SYSCALL_MUNMAP 215
#define SYSCALL_FORK 220
#define SYSCALL_EXEC 221
#define SYSCALL_MMAP 222
#define SYSCALL_WAITPID 260
#define SYSCALL_SPAWN 400

/**
 * 执行系统调用
 * @param id 系统调用编号
 * @param arg0 第一个参数
 * @param arg1 第二个参数
 * @param arg2 第三个参数
 * @return 系统调用返回值
 */
int64_t syscall(uint64_t id, uint64_t arg0, uint64_t arg1, uint64_t arg2)
{
    register uint64_t a0 asm("a0") = arg0;
    register uint64_t a1 asm("a1") = arg1;
    register uint64_t a2 asm("a2") = arg2;
    register uint64_t a7 asm("a7") = id;
    asm volatile("ecall"
                 : "+r"(a0)
                 : "r"(a1), "r"(a2), "r"(a7)
                 : "memory");
    return (int64_t)a0;
}

// 写文件系统调用
int64_t sys_write(uint64_t fd, const char *buf, size_t count)
{
    return syscall(SYSCALL_WRITE, fd, (uint64_t)buf, strlen(buf));
}

// 退出进程系统调用
void sys_exit(int32_t exit_code)
{
    syscall(SYSCALL_EXIT, (uint64_t)exit_code, 0, 0);
    while (1)
    {
    } // 保证如果系统调用返回则挂起进程
}

// 让出CPU时间片系统调用
void sys_yield(void)
{
    syscall(SYSCALL_YIELD, 0, 0, 0);
}

// 设置进程优先级系统调用
int64_t sys_set_priority(int64_t priority)
{
    return syscall(SYSCALL_SET_PRIORITY, (uint64_t)priority, 0, 0);
}

// 获取进程ID系统调用
int64_t sys_getpid()
{
    return syscall(SYSCALL_GETPID, 0, 0, 0);
}

// 取消内存映射系统调用
int64_t sys_munmap(uint64_t addr, uint64_t len)
{
    return syscall(SYSCALL_MUNMAP, addr, len, 0);
}

// 创建子进程系统调用
int64_t sys_fork(void)
{
    return syscall(SYSCALL_FORK, 0, 0, 0);
}

// 执行程序系统调用
int64_t sys_exec(const char *path)
{
    return syscall(SYSCALL_EXEC, (uint64_t)path, 0, 0);
}

// 内存映射系统调用
int64_t sys_mmap(uint64_t addr, uint64_t length, uint64_t prot)
{
    return syscall(SYSCALL_MMAP, addr, length, prot);
}

// 等待子进程退出系统调用
int64_t sys_waitpid(int64_t pid, int32_t *status)
{
    return syscall(SYSCALL_WAITPID, (uint64_t)pid, (uint64_t)status, 0);
}

// 创建并执行新进程系统调用
int64_t sys_spawn(const char *path)
{
    return syscall(SYSCALL_SPAWN, (uint64_t)path, 0, 0);
}

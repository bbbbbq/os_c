// syscall.c

#include "syscall.h"
#include "console.h"
#include "debug.h"
#include "task.h"


int32_t exit(int32_t value)
{
    print_str("exit : ");
    print_uint32((uint32_t)value);
    print_str("\n");
    return value;
}

int64_t write(uint64_t fd, const void *buf, uint64_t count)
{
    if(fd==1)
    {
        buf = (char*) buf;
        print_str(buf);
        print_str("\n");
    }else 
    {
        ASSERT(0);
    }
    return count;
}

int64_t yield()
{
    print_str("\n-------yield------\n");
    run_next_task(1);
    return 1;
}

int64_t sys_write(uint64_t fd, const void *buf, uint64_t count) 
{
    return write(fd, buf, count); // 使用POSIX write
}

void sys_exit(int32_t status) 
{
    exit(status);
}

int64_t sys_yield()
{
    return yield();
}

// 系统调用处理函数
int64_t syscall(uint64_t syscall_id, uint64_t args[3]) 
{
    switch (syscall_id)
    {
        case SYSCALL_WRITE:
            //print_str("------sys_write-----\n");
            return sys_write(args[0], (const void*)args[1], args[2]);
        case SYSCALL_EXIT:
            sys_exit((int)args[0]);
            return 0;
        case SYSCALL_YIELD:
            //print_str("----sys_yield----\n");
            return sys_yield();
        default:
            print_str("unsupportable syscall_id\n");
            ASSERT(0);
    }
    ASSERT(0);
    return -1;
}

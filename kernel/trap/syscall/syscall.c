// syscall.c

#include "syscall.h"
#include "console.h"
#include "debug.h"
#include "task.h"
#include "sbi.h"


int32_t exit(int32_t value)
{
    print_str("exit : ");
    print_uint32((uint32_t)value);
    print_str("\n");
    return value;
}

int64_t write(uint64_t fd, char* buf, uint64_t count)
{
    printk("\n\nwrite\n\n");
    if(fd==1)
    {
        for (uint64_t i = 0; i < count; i++) 
        {
            console_putchar(buf[i]);
        }
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

int64_t sys_write(uint64_t fd, char *buf, uint64_t count) 
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
int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2)
{   
    printk("syscall\n");
    switch (syscall_id)
    {
        case SYSCALL_WRITE:
            return sys_write(a0, (char *)a1, a2);
        case SYSCALL_EXIT:
            sys_exit((int32_t)a0);
        case SYSCALL_YIELD:
            return sys_yield();
        default:
            print_str("unsupportable syscall_id\n");
            ASSERT(0);
    }
    ASSERT(0);
    return -1;
}

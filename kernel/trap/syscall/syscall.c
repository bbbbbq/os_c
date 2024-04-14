// syscall.c

#include "syscall.h"
#include "console.h"
#include "debug.h"
#include "task.h"
#include "sbi.h"
#include "mem.h"
#include "stdint.h"
#include "trap.h"
int32_t exit(int32_t value)
{
    print_str("exit : ");
    print_uint32((uint32_t)value);
    print_str("\n");
    return value;
}

int64_t write(uint64_t fd, char *buf, uint64_t len) {
  static uint8_t sys_write_buf[1024];

  switch (fd) {
  case 1:
    ;uint64_t tmp = task_current_user_token();
    copy_byte_buffer(tmp, sys_write_buf, (uint8_t *)buf,
                     len, FROM_USER);
    for (uint64_t i = 0; i < len; i++) 
    {
      console_putchar(sys_write_buf[i]);
    }
    return (int64_t)len;
  default:
    break;
  }
  return -1;
}

int64_t yield()
{
    print_str("\n-------yield------\n");
    task_suspend_current_and_run_next();
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
            task_exit_current_and_run_next();
        case SYSCALL_YIELD:
            // task_exit_current_and_run_next();
            return sys_yield();
        default:
            print_str("unsupportable syscall_id\n");
            ASSERT(0);
    }
    ASSERT(0);
    return -1;
}

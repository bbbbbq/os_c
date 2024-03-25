#ifndef SYS_CALL_H
#define SYS_CALL_H
#include "batch.h"
#include "console.h"
#define SYSCALL_WRITE 1
#define SYSCALL_EXIT 2
extern void __restore(struct TrapContext* ctx);
extern void sys_write(unsigned int fd, const char *buf, uint32_t len);
extern void sys_exit(int xstate);

long syscall(long syscall_id, long arg1, long arg2, long arg3) 
{
    switch (syscall_id) 
    {
        case SYSCALL_WRITE:
            sys_write((unsigned int)arg1, (const char *)arg2, (int64_t)arg3);
            return arg3;
        case SYSCALL_EXIT:
            sys_exit((int)arg1);
            run_next_app();
            while(1) {};
        default:
            print_str("Unsupported syscall_id!\n");
            return -1;
    }
}
#endif
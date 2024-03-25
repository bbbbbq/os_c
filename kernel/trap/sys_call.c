#include "sys_call.h"
#include "stdint.h"
const unsigned int FD_STDOUT = 1;
void sys_write(unsigned int fd, const char *buf, uint32_t len) {
    if (fd == FD_STDOUT) {
        print_str(buf);
        print_str("\n");
    } else {
        print_str("Unsupported fd in sys_write!\n");
    }
}

void sys_exit(int xstate) {
    print_str("[kernel] Application exited with code ");
    print_uint32((uint32_t)xstate);
    print_str("\n");
    run_next_app(); // 切换到下一个应用程序或重置应用状态
}


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
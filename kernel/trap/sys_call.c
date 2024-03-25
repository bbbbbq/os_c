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
#include "syscall.h"
#include "string.h"
#include "debug.h"
#include "console.h"
int main()
{
    // char *msg = "hello_word";
    // sys_write(1, msg);
    asm volatile ("ecall");
    // sys_exit(0);
    // ASSERT(0);
    while(1);
}

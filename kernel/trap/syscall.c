#include "syscall.h"
#include "debug.h"
#include "console.h"
#include "batch.h"
#include "string.h"
long long  syscall(unsigned long long  id, unsigned long long  arg0, unsigned long long  arg1, unsigned long long  arg2) {
    register unsigned long long  a0 asm("a0") = (unsigned long long )(arg0); 
    register unsigned long long  a1 asm("a1") = (unsigned long long )(arg1); 
    register unsigned long long  a2 asm("a2") = (unsigned long long )(arg2); 
    register unsigned long long  a7 asm("a7") = (unsigned long long )(id); 
    asm volatile("ecall" : "+r"(a0) : "r"(a1), "r"(a2), "r"(a7) : "memory"); 
    return (long long )a0; 
}

long long sys_write(unsigned long long fd, const char *buf) 
{
    if(fd==1)
    {
        print_str(buf);
        print_str("\n");
        return strlen_user(buf);
    }
    else
    {
        return -1;
    }
}

void sys_exit(int id) 
{
    print_str("sys_exit\n");
    syscall(SYSCALL_EXIT, id, 0, 0);
    run_app();
}


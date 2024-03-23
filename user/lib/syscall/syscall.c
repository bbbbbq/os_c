#include "syscall.h"
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
    return syscall(SYSCALL_WRITE, fd, (unsigned long long)buf, (unsigned long)strlen_user(buf));
}

void sys_exit(int id) {
    syscall(SYSCALL_EXIT, id, 0, 0);
}

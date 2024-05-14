#include "stdint.h"
#include "stdio.h"
int main()
{
    const char *text = "Hello, world from write syscall!\n";
    const char *filename = "output.txt";
    printf("Hello, world from write syscall!\n");
    for (int i = 0; i < 1000000; i++)
    {
        if (i % 100001 == 0)
            sys_yield();
        if (i % 10000 == 0)
            printf("[01t] : %d\n", i);
    }
    printf("initproc tasks completed. System is ready.\n");
    sys_exit(-1);
    return 0;
}

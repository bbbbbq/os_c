#include "syscall.h"
#include "lib/string.h"
#include "lib/stdio.h" // Make sure this header supports file operations if needed

int main()
{
    const char *text = "Hello, world from write syscall!\n";
    const char *filename = "output.txt";
    printf("Hello, world from write syscall!\n");
    for (int i = 0; i < 1000000; i++)
    {
        if (i % 100000 == 0)
            sys_yield();
        if (i % 10000 == 0)
            printf("[01t] : %d\n", i);
    }
    return 0;
}

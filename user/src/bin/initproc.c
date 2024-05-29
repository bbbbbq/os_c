#include <stdint.h>

#include "stdio.h"
#include "syscall.h"

char *syscall[] = {
    "brk",
    "chdir",
};

char *argv[] = {NULL};

int main(void)
{
    int i, pid;
    for (i = 0; i < sizeof(syscall) / sizeof(char *); ++i)
    {
        printf("app_index : %d\n", i);
        pid = fork();
        if (pid == 0)
            exec(syscall[i]);
        else
            wait(0);
    }
}

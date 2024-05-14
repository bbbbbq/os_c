#include "stdint.h"
#include "stdio.h"

int64_t main(void)
{
    printf("initproc started\n");

    // Demonstrating the use of the fork system call
    int64_t pid = sys_fork();
    // int64_t pid_01t = sys_exec("01t");

    // printf("[user] pid_01t pid : %d\n", pid_01t);
    printf("children pid : %d \n", pid);
    if (pid == 0)
    { // Child process
        printf("This is the child process. PID = 0\n");
        printf("Child is performing some tasks...\n");
        for (uint64_t i = 0; i < 5000000; i++)
        {
            if (i % 1000000 == 0)
            {
                printf("Child task at step: %d\n", i / 1000000);
            }
        }
        printf("Child process is exiting now.\n");
        sys_exit(0); // Child exits here
    }
    else if (pid > 0)
    { // Parent process, which is initproc in this case
        printf("initproc (Parent) created a child process with PID: %ld\n", pid);
        printf("initproc is waiting for the child process to complete...\n");

        // Parent waits for the child to exit
        int exit_code;
        sys_waitpid(pid, &exit_code);
        printf("Child process exited with code %d. Continuing initproc tasks.\n", exit_code);

        // Perform additional tasks
        printf("initproc performing additional initialization tasks...\n");
        for (uint64_t j = 0; j < 5000000; j++)
        {
            if (j % 1000000 == 0)
            {
                printf("initproc task at step: %d\n", j / 1000000);
            }
        }
    }
    else
    {
        printf("Failed to fork a new process.\n");
    }

    printf("initproc tasks completed. System is ready.\n");
    return 0;
}

#include "lib/stdio.h"
#include "user_lib.h"
#include "type.h"
#include "thread.h"
int64_t main(void)
{
    int64_t pid = sys_fork(); // Perform the fork

    // Check if we are in the child process
    if (pid == 0)
    {
        // Child process
        printf("Child process: PID is 0\n");
        for (uint64_t i = 0; i < 10000000; i++)
        {
            if (i % 1000000 == 0)
            {
                printf("Child: %d\n", i / 1000000);
            }
        }
        printf("Child process exiting.\n");
        sys_exit(0); // Exit the child process
    }
    else if (pid > 0)
    {
        // Parent process
        printf("Parent process: Child's PID is %ld\n", pid);
        for (uint64_t i = 0; i < 10000000; i++)
        {
            if (i % 1000000 == 0)
            {
                printf("Parent: %d\n", i / 1000000);
            }
        }
        printf("Parent process completed.\n");
    }
    else
    {
        // Fork failed
        printf("Fork failed!\n");
        return -1;
    }

    return 0;
}

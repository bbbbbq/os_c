#include "syscall.h"
#include "string.h"
#include "debug.h"
#include "console.h"
int main()
{
    char *msg = "hello_word";
    sys_write(1, msg);
    sys_exit(0);
    ASSERT(0);
}

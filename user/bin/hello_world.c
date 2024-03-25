#include "syscall.h"
#include "string.h"
#include "debug.h"
#include "console.h"
int main()
{
    const char *msg = "hello_word";
    print_str(msg);
    // ASSERT(0);
    while(1);
}

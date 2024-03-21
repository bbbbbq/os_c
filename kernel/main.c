// #include "console.h"
// #include "stdint.h"
#include "console.h"
#include "sbi.h"
#include "debug.h"
int main_os()
{
    console_putchar('1');
    print_str("123123\n");
    ASSERT(1==2);
    while(1);
}

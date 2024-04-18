#include "console.h"
#include "sbi.h"
// panic函数现在接收文件名和行号作为参数
void _panic(const char *file, int line, const char *msg)
{
    printk("PANIC in %s at line %d: %s\n", file, line, msg);
    sbi_shutdown();
}

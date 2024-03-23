#include "console.h"
#include "syscall.h"
#include "string.h"
void print_str(const char* str)
{
    sys_write(1,str);
    sys_write(1,"\n");
}

void print_uint32(unsigned int num) {
    char buffer[12];  // 足够存储32位整数的最大值和终止符'\0'
    int i = 0;

    if (num == 0) {
        buffer[i++] = '0';  // 处理num为0的特殊情况
    } else {
        while (num > 0) {
            buffer[i++] = (num % 10) + '0'; // 将数字转换为字符
            num /= 10;
        }
    }

    buffer[i] = '\0'; // 添加字符串终止符

    strrev(buffer); // 反转字符串，因为我们是从低位向高位生成的字符

    print_str(buffer); // 使用print_str函数打印转换后的字符串
}
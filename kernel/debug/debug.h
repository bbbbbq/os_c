// 在 console.h 中
#ifndef DEBUG_H
#define DEBUG_H


// 重新定义panic宏，以便也包括文件名和行号
#define panic(msg) _panic(__FILE__, __LINE__, msg)
// 定义一个新的assert宏，包括文件名和行号
#define ASSERT(expr) \
    if (!(expr)) { \
        _panic(__FILE__, __LINE__, "Assertion failed: " #expr); \
    }

void _panic(const char* file, int line, const char* msg);
#endif // CONSOLE_H

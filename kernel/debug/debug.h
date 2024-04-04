// 在 console.h 中
#ifndef DEBUG_H
#define DEBUG_H


#define ASSERT(condition) \
    if(!(condition)) \
    {  \
        panic(__FILE__, __LINE__); \
    } 

void panic(const char *file, int line);

#endif // CONSOLE_H

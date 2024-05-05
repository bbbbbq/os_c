#ifndef THREAD_H
#define THREAD_H
typedef struct
{
    uint64_t ra;    // return address (x1)
    uint64_t sp;    // stack pointer (x2)
    uint64_t s[12]; // saved registers x8 (s0) to x27 (s11)
    uint64_t nx_ra; // new return address
} ThreadContext;

typedef enum
{
    AVAILABLE, // 线程空闲，可以被分配
    RUNNING,   // 线程正在运行
    READY      // 线程准备就绪，可以被调度
} State;

typedef struct
{
    size_t id;         // 线程ID
    void *stack;       // 栈指针
    size_t stack_size; // 栈的大小
    ThreadContext ctx; // 线程上下文
    State state;       // 线程状态
} Thread;

Thread Thread_init(uint64_t thread_id);

#endif
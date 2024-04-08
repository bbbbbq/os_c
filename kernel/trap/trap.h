#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"

#define TRAP_CAUSE_USER_ENV_CALL       0x08    // 环境调用来自U模式
#define TRAP_CAUSE_STORE_FAULT         0x07    // 存储错误
#define TRAP_CAUSE_STORE_PAGE_FAULT    0x0F    // 存储页面错误
#define TRAP_CAUSE_ILLEGAL_INSTRUCTION 0x02    // 非法指令

void set_user_trap_entry();
void init_interrupt();
struct TrapContext* trap_handler(struct TrapContext* trapframe);
void print_sepc();
void trap_return();
#endif
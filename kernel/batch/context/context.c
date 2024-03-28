// TrapContext.c
#include "stdint.h"
#include "context.h"
void set_sstatus_spp_user(uint64_t *sstatus) 
{
    uint64_t mask = 1UL << 8;
    *sstatus &= ~mask;
}

// 假设的sstatus读取和设置函数
uint64_t read_sstatus(void) {
    return READ_CSR(sstatus);
}

// 设置栈指针
void set_sp(struct TrapContext *ctx, uint64_t sp) {
    ctx->x[2] = sp;
}

// 初始化应用程序上下文
struct TrapContext app_init_context(uint64_t entry, uint64_t sp) 
{
    struct TrapContext ctx;
    uint64_t sstatus = read_sstatus();
    set_sstatus_spp_user(&sstatus); // 设置为用户模式
    ctx.sstatus = sstatus;
    ctx.sepc = entry; // 设置入口地址
    set_sp(&ctx, sp); // 设置栈指针
    //初始化通用寄存器为0
    for(int i = 0; i < 32; i++)
    {
        ctx.x[i] = 0;
    }
    return ctx;
}

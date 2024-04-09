// TrapContext.c
#include "stdint.h"
#include "context.h"
#include "riscv.h"
#include "trap.h"
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



void app_init_context(uint64_t entry, uint64_t sp, uint64_t kernel_satp,
                      uint64_t kernel_sp, uint64_t trap_handler,
                      struct TrapContext *c) 
{
  uint64_t sstatus = r_sstatus();
  sstatus &= ~SSTATUS_SPP;

  for (int i = 0; i < 32; i++)
    c->x[i] = 0;
  c->sstatus = sstatus;
  c->sepc = entry;
  c->kernel_satp = kernel_satp;
  c->kernel_sp = kernel_sp;
  c->trap_handler = trap_handler;
  c->x[2] = sp;
}

void task_context_goto_trap_return(struct TaskContext *cx) 
{
  cx->ra = (uint64_t)trap_return;
  for (int i = 0; i < 12; i++)
    cx->x[i] = 0;
}

#include "trap.h"
#include "stdint.h"
#include "console.h"
#include "syscall.h"
#include "debug.h"
#include "context.h"
#include "batch.h"
#include "timer.h"
#include "stack.h"
#include "task.h"
#include "riscv.h"
#include "mem.h"
#include "processor.h"
#include "plic.h"
#include "uart.h"
extern void __alltraps();
extern void __restore();

void print_sepc()
{
  print_str("sepc : ");
  print_uint64(READ_CSR(sepc));
  print_str("\n");
}

// void init_interrupt()
// {
//     uint64_t stvec_value = (uint64_t)(__alltraps);
//     asm volatile("csrw stvec, %0" :: "r"(stvec_value));
//     uint64_t mask = 0x202;
//     WRITE_CSR(sie,mask);
//     uint64_t sstatus = READ_CSR(sstatus);
//     sstatus |= SSTATUS_SIE_BIT;
//     WRITE_CSR(sstatus, sstatus);
//     uint64_t sie = READ_CSR(sie);
//     sie |= SIE_SSIE_BIT | SIE_STIE_BIT | SIE_SEIE_BIT;
//     WRITE_CSR(sie, sie);
//     WRITE_CSR(sscratch,Trap_Stack);
// }

void trap_handler()
{
  // printk("trap_handler \n");
  set_kernel_trap_entry();

  struct TrapContext *cx = processor_current_trap_cx();
  uint64_t scause = r_scause();

  if (scause & (1ULL << 63))
  {
    scause &= ~(1ULL << 63);
    switch (scause)
    {
    case SupervisorTimer:
      intr_timer_handle();
      task_exit_current_and_run_next();
      break;
    default:
      ASSERT("Unsupported interrupt 0x%llx, stval = 0x%llx\n");
      break;
    }
  }
  else
  {
    switch (scause)
    {
    case UserEnvCall:
      cx->sepc += 4;
      cx->x[10] = syscall(cx->x[17], cx->x[10], cx->x[11], cx->x[12]);
      break;
    case StoreFault:
    case StorePageFault:
    case InstructionFault:
    case InstructionPageFault:
    case LoadFault:
    case LoadPageFault:
      ASSERT("Exception %lld in application, bad addr = %llx, bad instruction = ");
      ASSERT("LoadPageFault\n");
      task_exit_current_and_run_next();
      break;
    case IllegalInstruction:
      ASSERT("IllegalInstruction in application, core dumped.\n");
      task_exit_current_and_run_next();
      break;
    default:
      ASSERT(0);
      break;
    }
  }

  trap_return();
}

void set_user_trap_entry()
{
  w_stvec((uint64_t)TRAMPOLINE);
}

uint64_t task_current_user_token()
{
  return task_manager_get_current_token();
}

void trap_return()
{
  // printk("trap_return\n");
  set_user_trap_entry();
  uint64_t trap_cx_ptr = TRAP_CONTEXT;
  uint64_t user_satp = processor_current_user_token();
  uint64_t restore_va = (uint64_t)__restore - (uint64_t)__alltraps + TRAMPOLINE;
  asm volatile("fence.i");
  asm volatile("mv x10, %1\n"
               "mv x11, %2\n"
               "jr %0\n"
               :
               : "r"(restore_va), "r"(trap_cx_ptr), "r"(user_satp)
               : "memory", "x10", "x11");
  panic("Unreachable in back_to_user!\n");
}

void init_trap()
{
  set_kernel_trap_entry();
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE);
}

void trap_from_kernel(uint64_t cause)
{
  printk("trap_from_kernel\n");
  int irq;
  if (cause > 0x8000000000000000)
    cause -= (uint64_t)0x8000000000000000;
  printk("cause: ");
  print_uint64(cause);
  printk("\n");
  print_sepc();
  switch (cause)
  {
  case SupervisorTimer:
    timer_set_next_trigger();
    break;
  case SupervisorExternal:
    irq = plic_claim();
    printk("irq : %d\n", irq);
    if (irq == VIRTIO0_IRQ)
    {
      virtio_disk_intr();
    }
    else if (irq == UART0_IRQ)
    {
      uart_irq_handler();
    }
    else if (irq)
    {
      printk("unexpected interrupt irq=%d\n", irq);
      ASSERT(0);
    }
    if (irq)
      plic_complete(irq);
    break;
  default:
    ASSERT(0);
    break;
  }
}

extern void kernelvec();
void set_kernel_trap_entry()
{
  w_stvec((uint64_t)kernelvec & ~0x3);
}
// void set_user_trap_entry() {
//     w_stvec(TRAMPOLINE);
// }
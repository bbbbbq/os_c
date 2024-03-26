#include "trap.h"
#include "stdint.h"
#include "console.h"
#include "syscall.h"
#include "debug.h"
#include "context.h"
extern void __alltraps(void);

void init_interrupt()
{
    uint64_t stvec_value = (uint64_t)(__alltraps);
    // WRITE_CSR(stvec,stvec_value);
    asm volatile("csrw stvec, %0" :: "r"(stvec_value));
    uint64_t mask = 0x202; // 定义启用S模式时钟中断和软件中断的掩码
    WRITE_CSR(sie,mask);
}

struct TrapContext* trap_handler(struct TrapContext* cx) 
{
    uint64_t scause = READ_CSR(scause); // get trap cause
    uint64_t stval = READ_CSR(stval); // get extra value
    switch (scause)
    {
        case TRAP_CAUSE_USER_ENV_CALL:
        {
            cx->sepc += 4;
            uint64_t args[3] = {cx->x[10], cx->x[11], cx->x[12]};
            cx->x[10] = syscall(cx->x[17], args);
            break;
        }
        case TRAP_CAUSE_STORE_FAULT:
        case TRAP_CAUSE_STORE_PAGE_FAULT:
            print_str("[kernel] PageFault in application, kernel killed it.\n");
            //run_next_app();
            break;
        case TRAP_CAUSE_ILLEGAL_INSTRUCTION:
            print_str("[kernel] IllegalInstruction in application, kernel killed it.\n");
            //run_next_app();
            break;
        default:
            print_str("Unsupported trap ");
            print_uint64(scause);
            print_str("\n");
            exit(1);
            ASSERT(0);
    }
    return cx;
}


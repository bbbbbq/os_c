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
extern void __alltraps(void);


void print_sepc()
{
    print_str("sepc : ");
    print_uint64(READ_CSR(sepc));
    print_str("\n");    
}

void init_interrupt()
{
    print_str("----init_interrupt----\n");
    uint64_t stvec_value = (uint64_t)(__alltraps);
    // WRITE_CSR(stvec,stvec_value);
    asm volatile("csrw stvec, %0" :: "r"(stvec_value));
    uint64_t mask = 0x202; // 定义启用S模式时钟中断和软件中断的掩码
    WRITE_CSR(sie,mask);
    uint64_t sstatus = READ_CSR(sstatus);
    sstatus |= SSTATUS_SIE_BIT;
    WRITE_CSR(sstatus, sstatus);
    uint64_t sie = READ_CSR(sie);
    sie |= SIE_SSIE_BIT | SIE_STIE_BIT | SIE_SEIE_BIT;
    WRITE_CSR(sie, sie);
    WRITE_CSR(sscratch,Trap_Stack);
}

struct TrapContext* trap_handler(struct TrapContext* cx) 
{
    //print_str("trap_handler\n");
    uint64_t scause = READ_CSR(scause);
    //uint64_t stval = READ_CSR(stval);

    switch (scause)
    {
        case 0x00: // 指令地址错位
            print_str("[kernel] Instruction Address Misaligned.\n");
            print_sepc();
            run_next_app();
            break;
        case 0x01: // 指令访问故障
            print_sepc();
            print_str("[kernel] Instruction Access Fault.\n");
            run_next_app();
            break;
        case 0x02: // 非法指令
            print_str("[kernel] Illegal Instruction.\n");
            run_next_app();
            break;
        case 0x03: // 断点
            print_str("[kernel] Breakpoint.\n");
            // 特定的调试处理或直接运行下一个应用
            cx->sepc +=2;
            //run_next_app();
            break;
        case 0x04: // 加载地址错位
            print_str("[kernel] Load Address Misaligned.\n");
            run_next_app();
            break;
        case 0x05: // 加载访问故障
            print_str("[kernel] Load Access Fault.\n");
            //run_next_app();
            break;
        case 0x06: // 存储地址错位
            print_str("[kernel] Store/AMO Address Misaligned.\n");
            run_next_app();
            break;
        case 0x07: // 存储/AMO访问故障
            print_str("[kernel] Store/AMO Access Fault.\n");
            print_sepc();
            uint64_t cnt=10000000000;
            while(cnt--){}
            //run_next_app();
            break;
        case 0x08: // 环境调用来自U模式
            cx->sepc += 4; // 跳过环境调用指令
            uint64_t args[3] = {cx->x[10], cx->x[11], cx->x[12]};
            cx->x[10] = syscall(cx->x[17], args); // 执行系统调用
            if(cx->x[17] == 124)
            {
                int64_t idx = find_next_task();
                //__restore((uint64_t)app_init_context(app_manager.app_start,get_kernel_sp(Kernelstack[idx])));
            }
            break;
        case 0x09: // 环境调用来自S模式
            print_str("[kernel] Environment Call from S-mode.\n");
            uint64_t cnt1=10000000000;
            while(cnt1--){}
            run_next_app();
            break;
        case 0x0B: // 环境调用来自M模式
            print_str("[kernel] Environment Call from M-mode.\n");
            // 处理或运行下一个应用
            run_next_app();
            break;
        case 0x0C: // 指令页面错误
            print_str("[kernel] Instruction Page Fault.\n");
            run_next_app();
            break;
        case 0x0D: // 加载页面错误
            print_str("[kernel] Load Page Fault.\n");
            run_next_app();
            break;
        case 0x0F: // 存储页面错误
            print_str("[kernel] Store/AMO Page Fault.\n");
            run_next_app();
            break;
        case 0x8000000000000005: 
            //print_str("intr_timer_handle\n");
            intr_timer_handle();
            break;
        default:
            print_str("[kernel] Unsupported trap.\n");
            print_uint64(scause);
            exit(1);
    }
    return cx;
}
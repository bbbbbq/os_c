#ifndef TRAP_H
#define TRAP_H
#include "stdint.h"

#define UserSoft 0
#define SupervisorSoft 1
#define UserTimer 4
#define SupervisorTimer 5
#define UserExternal 8
#define SupervisorExternal 9

#define InstructionMisaligned 0
#define InstructionFault 1
#define IllegalInstruction 2
#define Breakpoint 3
#define LoadMisaligned 4
#define LoadFault 5
#define StoreMisaligned 6
#define StoreFault 7
#define UserEnvCall 8
#define SupervisorEnvCall 9
#define MachineEnvCall 11
#define InstructionPageFault 12
#define LoadPageFault 13
#define StorePageFault 15
void init_trap();
void set_user_trap_entry();
void init_interrupt();
void trap_handler();
void print_sepc();
void trap_return();
void set_kernel_trap_entry();
uint64_t task_current_user_token();
#endif
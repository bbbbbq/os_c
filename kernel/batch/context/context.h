#ifndef CONTEXT_H
#define CONTEXT_H

struct TrapContext
{
    uint64_t x[32];
    uint64_t sstatus;
    uint64_t sepc;
};

struct TrapContext app_init_context(uint64_t entry, uint64_t sp);
#endif
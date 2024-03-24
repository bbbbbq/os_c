#ifndef BATCH_H
#define BATCH_H
#include "stdint.h"
#include "string.h"
#include "console.h"
#define MAX_APP_NUMS 20
#define MAX_APP_MEMORY 0x20000
#define SINGLE_APP_MEMORY(APP_START,APP_END) ((APP_END)-(APP_START))
#define APP_BASE_ADDR 0x80400000

#define KERNEL_STACK_SIZE 4096*2
#define USER_STACK_SIZE 4096*2

uint64_t current_app_num;
uint64_t app_number;
uint64_t* app_start_addr[MAX_APP_NUMS];
uint64_t* app_end_addr[MAX_APP_NUMS];
extern uint64_t app_information[];
void load_app(uint64_t app_id);
void clear_app_memory(uint64_t app_id);
void load_app_information();
void load_next_app();

#endif
#include "batch.h"
#include "debug.h"
void load_app_information() {
    app_number = app_information[0];
    uint64_t* apps_starts = &app_information[1];
    
    print_str("Loading app start addresses...\n");
    for(int i = 0; i < app_number; i++) {
        app_start_addr[i] = apps_starts[i];
        print_str("App ");
        print_uint64(i);
        print_str(" start address: ");
        print_uint64((uint64_t)app_start_addr[i]);
        print_str("\n");
    }

    uint64_t* app_ends = &app_information[app_number + 1];
    
    print_str("Loading app end addresses...\n");
    for(int i = 0; i < app_number; i++) {
        app_end_addr[i] = (uint64_t*)app_ends[i];
        print_str("App ");
        print_uint64(i);
        print_str(" end address: ");
        print_uint64((uint64_t)app_end_addr[i]);
        print_str("\n");
    }
}

void clear_app_memory(uint64_t app_id)
{
    uint64_t* app_start = app_start_addr[app_id];
    uint64_t* app_end   = app_end_addr[app_id];
    if(app_end-app_start > MAX_APP_MEMORY) 
    {
        print_str("app_id : ");
        print_uint32(app_id);
        print_str("  exceed app memory limit\n");
        ASSERT(0);
    }else
    {
        char* current = (char*)app_start;
        char* end = (char*)app_end;
        while(current < end) 
        {
            *current++ = 0;
        }
    }
}

void load_app(uint64_t app_id) 
{
    __asm__ volatile ("fence.i");
    if (app_id >= MAX_APP_NUMS)
    {
        ASSERT(0);
        return;
    }
    uint64_t* start = app_start_addr[app_id];
    uint64_t* end = app_end_addr[app_id];
    uint64_t app_size = (uint64_t)end - (uint64_t)start;
    if(app_size > MAX_APP_MEMORY)
    {
        ASSERT(0);
    }
    memcpy((void*)APP_LOAD_ADDRESS, (const void*)start, app_size);
}

void load_next_app()
{
    current_app_num++;
    if(current_app_num >= MAX_APP_NUMS )
    {
        ASSERT(0);
    }else 
    {
        clear_app_memory(current_app_num);
        load_app(current_app_num);
    }
}
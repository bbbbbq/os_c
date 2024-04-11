#ifndef LOADER_H
#define LOADER_H
#include "stdint.h"
extern      
uint64_t loader_get_num_app();
uint8_t *loader_get_app_data(uint64_t app_id);
size_t loader_get_app_size(uint64_t app_id);
void loader_init_and_list_apps();
uint8_t* get_app_data_by_name(char* name);
void list_apps();
#endif
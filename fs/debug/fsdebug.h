#ifndef FS_DEBUG_H
#define FS_DEBUG_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "fs_globle.h"
#include "driver.h"

void parse_fsinfo(const char *filename);
void parse_fat32_bpb(const char *filename);
void print_sector_data(Device *device, uint64_t sector_num);


#endif
#ifndef DIR_H
#define DIR_H
#include <stdint.h>
#include "driver.h"
typedef struct
{
    char DIR_Name[11];        /* 0  */
    uint8_t DIR_Attr;         /* 11 */
    uint8_t DIR_NTRes;        /* 12 */
    uint8_t DIR_CrtTimeTenth; /* 13 */
    uint16_t DIR_CrtTime;     /* 14 */
    uint16_t DIR_CrtDate;     /* 16 */
    uint16_t DIR_LstAccDate;  /* 18 */
    uint16_t DIR_FstClusHI;   /* 20 */
    uint16_t DIR_WrtTime;     /* 22 */
    uint16_t DIR_WrtDate;     /* 24 */
    uint16_t DIR_FstClusLO;   /* 26 */
    uint32_t DIR_FileSize;    /* 28 */
} Dirent __attribute__((__packed__));


Dirent root_dir_entry;

void creat_dir_entry(Dirent* dir, const char* name, uint8_t attr, uint16_t crt_time,
                     uint16_t crt_date, uint16_t wrt_time, uint16_t wrt_date,
                     uint16_t fst_clus_hi, uint16_t fst_clus_lo, uint32_t file_size);
void init_root_entry();
void read_and_parse_root_entry(Device *device);

uint32_t get_file_or_dir_size(const Dirent *entry);
uint64_t get_creation_time(const Dirent *entry);
uint64_t get_last_modified_time(const Dirent *entry);
uint64_t get_last_access_time(const Dirent *entry);
void set_file_or_dir_attribute(Dirent *entry, uint8_t attribute);
#endif
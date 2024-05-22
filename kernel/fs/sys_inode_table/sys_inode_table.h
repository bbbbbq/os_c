#ifndef SYS_INODE_TABLE_H
#define SYS_INODE_TABLE_H
#include "queue.h"
#include "file_desc.h"
typedef struct
{
    Queue inode_table;
} Sys_Inode_Table;

#define OWNER_READ 0x0100  // 假设为 0400 in octal
#define OWNER_WRITE 0x0080 // 假设为 0200 in octal
#define OWNER_EXEC 0x0040  // 假设为 0100 in octal

extern Sys_Inode_Table sys_inode_table;
Inode *find_index_inode(Sys_Inode_Table table, uint32_t index);
Sys_Inode_Table Sys_Inode_Table_new();
char *get_current_proc_pwd();
bool inode_table_add(Path *path);
uint32_t count_valid_components(char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH]);
uint32_t add_inode_to_Inode_table(Inode *inode);
int32_t Find_Inode_By_Dir_In_Inode_Table(Dirent dir);
void Sys_Inode_Table_set_inode_ref(uint32_t index, uint32_t ref_cnt);
uint32_t Sys_Inode_Table_get_inode_ref(uint32_t index);
void parse_mode(uint64_t mode, bool *owner_read, bool *owner_write, bool *owner_exec);

#endif
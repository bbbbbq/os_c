#ifndef SYS_INODE_TABLE_H
#define SYS_INODE_TABLE_H
#include "queue.h"
#include "file_desc.h"
typedef struct
{
    Queue inode_table;
} Sys_Inode_Table;
extern Sys_Inode_Table sys_inode_table;
Inode *find_index_inode(Sys_Inode_Table table, uint32_t index);
Sys_Inode_Table Sys_Inode_Table_new();
char *get_current_proc_pwd();
bool inode_table_add(Path *path);
uint32_t count_valid_components(char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH]);
uint32_t add_inode_to_Inode_table(Inode *inode);
int32_t Find_Inode_By_Dir_In_Inode_Table(Dirent dir);
#endif
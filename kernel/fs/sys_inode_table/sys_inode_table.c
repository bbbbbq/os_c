#include "queue.h"
#include "sys_inode_table.h"
#include "dir.h"
#include "processor.h"
#include "task.h"
#include "string.h"
Sys_Inode_Table sys_inode_table;
Sys_Inode_Table Sys_Inode_Table_new()
{
    Sys_Inode_Table new_table;
    queue_init(&new_table.inode_table);
    return new_table;
}

Inode *find_index_inode(Sys_Inode_Table table, uint32_t index)
{
    if (index > table.inode_table.size)
    {
        return NULL;
    }

    Inode *inode = queue_get_at(&table.inode_table, index - 3);
    return inode;
}

char *get_current_proc_pwd()
{
    struct TaskControlBlock *current_task = processor_current_task();
    return current_task->pwd;
}

uint32_t count_valid_components(char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH])
{
    int count = 0;
    for (int i = 0; i < MAX_PATH_COMPONENTS; i++)
    {
        if (components[i][0] != '\0')
        { // 检查每个字符串的首字符是否不是空字符
            count++;
        }
    }
    return count; // 返回有效元素的数量
}

bool inode_table_add(Path *path)
{
    char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH];
    parse_path(path->value, components);
    char full_path[MAX_PATH_LENGTH] = {0};
    if (strcmp(components[0], root_dir_entry.DIR_Name) != 0)
    {
        char *current_proc_pwd = processor_current_task()->pwd;
        strncpy(full_path, current_proc_pwd, MAX_PATH_LENGTH - 1);
        full_path[MAX_PATH_LENGTH - 1] = '\0'; // 确保字符串结束
        size_t current_length = strlen(full_path);
        if (current_length < MAX_PATH_LENGTH - 1)
        {
            full_path[current_length] = '\\';
            full_path[current_length + 1] = '\0';
        }
        strncat(full_path, path->value, MAX_PATH_LENGTH - strlen(full_path) - 1);
    }
    parse_path(full_path, components);
    uint32_t path_depth = count_valid_components(components);
    Dirent *tmp_dir = &root_dir_entry;
    for (int i = 0; i < path_depth - 1; i++)
    {
        char *parent = components[i];
        char *child = components[i + 1];
        tmp_dir = find_dir_entry(tmp_dir, child);
        if (tmp_dir == NULL)
            return false;
    }
    Inode inode;
    inode.dir = *tmp_dir;
    inode.offset = 0;
    inode.readable = 0;
    inode.writable = 0;
    inode.ref_cnt = 0;
    queue_enqueue(&sys_inode_table.inode_table, &inode);
    return true;
}

uint32_t add_inode_to_Inode_table(Inode *inode)
{
    queue_enqueue(&sys_inode_table.inode_table, inode);
    return sys_inode_table.inode_table.size - 1; // Return new inode position in the queue
}

int32_t Find_Inode_By_Dir_In_Inode_Table(Dirent dir)
{
    Node *current = sys_inode_table.inode_table.head;
    uint32_t index = 0;

    while (current != NULL)
    {
        Inode *inode = (Inode *)current->data;
        if (strcmp(inode->dir.DIR_Name, dir.DIR_Name) == 0)
        {
            return index;
        }
        current = current->next;
        index++;
    }

    return -1;
}

void Sys_Inode_Table_set_inode_ref(uint32_t index, uint32_t ref_cnt)
{
    Inode *inode = find_index_inode(sys_inode_table, index);
    inode->ref_cnt = ref_cnt;
}

uint32_t Sys_Inode_Table_get_inode_ref(uint32_t index)
{
    Inode *inode = find_index_inode(sys_inode_table, index);
    return inode->ref_cnt;
}

void parse_mode(uint64_t mode, bool *owner_read, bool *owner_write, bool *owner_exec)
{
    if (owner_read != NULL)
    {
        *owner_read = (mode & OWNER_READ) ? true : false;
    }
    if (owner_write != NULL)
    {
        *owner_write = (mode & OWNER_WRITE) ? true : false;
    }
    if (owner_exec != NULL)
    {
        *owner_exec = (mode & OWNER_EXEC) ? true : false;
    }
}

void Sys_Inode_Table_init()
{
    Inode inode1, inode2, inode3;
    inode1.type = INODE_TYPE_STDIN;
    inode2.type = INODE_TYPE_STDOUT;
    inode3.type = INODE_TYPE_STDERROR;
    queue_enqueue(&sys_inode_table.inode_table, &inode1);
    queue_enqueue(&sys_inode_table.inode_table, &inode2);
    queue_enqueue(&sys_inode_table.inode_table, &inode3);
}

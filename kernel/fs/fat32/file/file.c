#include "file.h"
#include "dir.h"
#include "buddy.h"
#include "string.h"
#include "fat_table.h"
#include "debug.h"
#include "processor.h"
#define min(a, b) ((a) < (b) ? (a) : (b))
extern Dirent root_dir_entry;
void read_file(char *name, void *buffer)
{
    // 查找指定文件的目录项
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    if (dir == NULL)
    {
        ASSERT(0);
        return;
    }
    if (is_directory(dir))
    {
        printk("is_not_file\n");
        return;
    }

    // 获取文件的起始簇号和文件大小
    uint32_t cluster_num = extract_cluster_number(dir);
    uint64_t file_size = get_file_or_dir_size(dir);
    if (file_size == 0)
    {
        printk("file without data\n");
        return;
    }
    uint32_t bytes_read = 0;
    uint8_t *current_buffer = (uint8_t *)buffer;

    // 循环读取每个簇的数据
    while (bytes_read < file_size)
    {
        uint32_t bytes_to_read = CLUSER_SIZE;
        if (file_size - bytes_read < CLUSER_SIZE)
        {
            bytes_to_read = file_size - bytes_read; // Ensure we don't read beyond the file
        }

        int result = read_by_byte_cluser(cluster_num, 0, bytes_to_read, current_buffer);
        if (result == -1)
        {
            // printk("Error: Failed to read data\n");
            return;
        }

        bytes_read += bytes_to_read;
        current_buffer += bytes_to_read;
        if (cluster_num < 2)
        {
            panic("cluster_num < 2");
        }
        cluster_num = parse_cluster_number(cluster_num - 2);
        if (cluster_num > FAT_ENTRY_NUM)
            break;
    }
}

void over_write_file(char *name, void *buffer, size_t buffer_size)
{
    // 查找指定文件的目录项
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    if (dir == NULL)
    {
        printk("File not found\n");
        return;
    }

    // 确保目标是文件而不是目录
    if (is_directory(dir))
    {
        printk("The target is a directory, not a file\n");
        return;
    }

    // 获取文件的起始簇号
    uint32_t cluster_num = extract_cluster_number(dir);
    // 获取文件大小
    uint64_t file_size = get_file_or_dir_size(dir);
    // 计算文件所占的簇数
    uint32_t cluster_count = (file_size + CLUSER_SIZE - 1) / CLUSER_SIZE;

    // 释放除了第一个簇外的其他簇
    uint32_t current_cluster = cluster_num;
    for (int i = 1; i < cluster_count; ++i)
    {
        uint32_t next_cluster = parse_cluster_number(current_cluster);
        set_cluser_free(current_cluster);
        current_cluster = next_cluster;
    }

    // 写入数据到第一个簇
    uint32_t bytes_written = 0;
    while (bytes_written < buffer_size)
    {
        uint32_t bytes_to_write = min(buffer_size - bytes_written, CLUSER_SIZE);
        if (bytes_to_write + bytes_written > buffer_size)
        {
            bytes_to_write = buffer_size - bytes_written;
        }
        int result = write_by_byte_cluser(cluster_num, 0, bytes_to_write, (char *)buffer + bytes_written);
        if (result != 0)
        {
            printk("Error: Failed to write data\n");
            return;
        }
        bytes_written += bytes_to_write;
        if (bytes_written < buffer_size)
        {
            cluster_num = find_next_free_cluster(cluster_num);
            set_cluster_number(current_cluster - 2, cluster_num);
            current_cluster = cluster_num;
        }
    }
    // 更新文件大小和结束标记
    set_file_or_dir_size(dir, buffer_size);
    update_dir(dir->DIR_Name, dir);
    set_cluser_end(cluster_num);
    update_dir(name, dir);
    printk("Data successfully overwritten to file: %s\n", name);
}

void append_to_file(char *name, void *buffer, size_t buffer_size)
{
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    if (dir == NULL)
    {
        printk("File not found\n");
        return;
    }
    if (is_directory(dir))
    {
        printk("The target is a directory, not a file\n");
        return;
    }

    // 读取当前文件的数据
    size_t file_size = get_file_or_dir_size(dir);
    void *file_data = bd_malloc(file_size);
    if (file_data == NULL)
    {
        printk("Memory allocation failed\n");
        return;
    }
    read_file(name, file_data);

    // 合并当前文件的数据和传入的数据
    void *merged_data = bd_malloc(file_size + buffer_size);
    if (merged_data == NULL)
    {
        printk("Memory allocation failed\n");
        bd_free(file_data);
        return;
    }
    memcpy(merged_data, file_data, file_size);
    memcpy(merged_data + file_size, buffer, buffer_size);

    // 调用 over_write_file 函数将合并后的数据覆盖写入文件
    over_write_file(name, merged_data, file_size + buffer_size);
    set_file_or_dir_size(dir, file_size + buffer_size);
    update_dir(name, dir);
    bd_free(file_data);
    bd_free(merged_data);
}

// 待修改
void remove_file(char *name)
{
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    Dirent *parent_dir = find_parent_directory_bfs(name, &root_dir_entry);
    uint32_t cluser_num = extract_cluster_number(parent_dir);
    uint32_t dir_chile_file_num = dir_child_dir_num(dir);
    if (dir_chile_file_num != 0)
    {
        printk("目录下还有文件\n");
        return;
    }
    else
    {
        // release_linked_clusters(cluser_num);
        uint32_t dir_cluster = extract_cluster_number(parent_dir);
        uint8_t buffer[CLUSER_SIZE];
        read_by_cluster(dir_cluster, buffer);

        for (int i = 0; i < CLUSER_SIZE / sizeof(Dirent); i++)
        {
            // 计算当前目录项在缓冲区中的偏移量
            size_t offset = i * sizeof(Dirent);
            Dirent tmp;
            tmp = parse_directory_entry(buffer + offset);
            if (compare_dir_entry_name(&tmp, name) == 1)
            {
                uint8_t data;
                data = ATTR_DELETED;
                write_by_byte_cluser(dir_cluster, offset + 11, 1, &data);
                return;
            }
        }
    }
}

void rename_file_or_dir(char *name, char *new_name)
{
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    Dirent *parent_dir = find_parent_directory_bfs(name, &root_dir_entry);
    uint32_t dir_cluster = extract_cluster_number(parent_dir);
    uint8_t buffer[CLUSER_SIZE];
    read_by_cluster(dir_cluster, buffer);

    for (int i = 0; i < CLUSER_SIZE / sizeof(Dirent); i++)
    {
        // 计算当前目录项在缓冲区中的偏移量
        size_t offset = i * sizeof(Dirent);
        Dirent tmp = parse_directory_entry(buffer + offset);
        if (compare_dir_entry_name(&tmp, name) == 1)
        {
            // 更新目录项的名称
            memset(tmp.DIR_Name, ' ', 11);                                   // 将名称字段置为空格
            memcpy(tmp.DIR_Name, new_name, strlen(new_name));                // 将新名称拷贝到名称字段中
            write_by_byte_cluser(dir_cluster, offset, sizeof(Dirent), &tmp); // 将更新后的目录项写回簇中
            return;
        }
    }
}

void read_file_by_byte(Dirent *dir, uint32_t offset, char *buffer, size_t read_size)
{
    if (dir == NULL || buffer == NULL)
        ASSERT(0);
    uint32_t cluser_num = extract_cluster_number(dir);
    uint32_t file_size = get_file_or_dir_size(dir);
    char *tmp_buffer = bd_malloc(file_size);
    read_file(dir->DIR_Name, tmp_buffer);
    memcpy(buffer, tmp_buffer + offset, read_size);
}

void write_file_by_byte(Dirent *dir, uint32_t offset, char *buffer, size_t write_size)
{
    if (dir == NULL || buffer == NULL)
        ASSERT(0);
    uint32_t cluser_num = extract_cluster_number(dir);
    uint32_t file_size = get_file_or_dir_size(dir);
}

Dirent *find_dir_by_path(char *path)
{
    char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH];
    parse_path(path, components);
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
        strncat(full_path, path, MAX_PATH_LENGTH - strlen(full_path) - 1);
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
            return NULL;
    }
    return tmp_dir;
}

Dirent *create_file_or_dir_by_path(char *path, uint32_t attr)
{
    char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH];
    parse_path(path, components);
    Dirent *dir = find_dir_by_path(path);
    if (dir != NULL)
        return dir;
    char *last_comp_name = get_last_path_component(path);
    remove_last_path_component(path);
    Dirent *parent_dir = find_dir_by_path(path);
    Dirent new_dir = add_file_or_dir_to_parent_directory(last_comp_name, (uint64_t)attr, parent_dir);
    return &new_dir;
}

bool append_to_file_by_dir(Dirent *dir, void *buffer, size_t buffer_size)
{
    // 读取当前文件的数据
    size_t file_size = get_file_or_dir_size(dir);
    void *file_data = bd_malloc(file_size);
    if (file_data == NULL)
    {
        printk("Memory allocation failed\n");
        return;
    }
    read_file(dir->DIR_Name, file_data);

    void *merged_data = bd_malloc(file_size + buffer_size);
    if (merged_data == NULL)
    {
        printk("Memory allocation failed\n");
        bd_free(file_data);
        return;
    }
    memcpy(merged_data, file_data, file_size);
    memcpy(merged_data + file_size, buffer, buffer_size);

    // 调用 over_write_file 函数将合并后的数据覆盖写入文件
    over_write_file(dir->DIR_Name, merged_data, file_size + buffer_size);
    set_file_or_dir_size(dir, file_size + buffer_size);
    update_dir(dir->DIR_Name, dir);
    bd_free(file_data);
    bd_free(merged_data);
}

void read_file_by_dirent(Dirent *dir, void *buffer)
{
    if (dir == NULL)
    {
        ASSERT(0);
        return;
    }
    if (is_directory(dir))
    {
        printk("is_not_file\n");
        return;
    }

    // 获取文件的起始簇号和文件大小
    uint32_t cluster_num = extract_cluster_number(dir);
    uint64_t file_size = get_file_or_dir_size(dir);
    if (file_size == 0)
    {
        printk("file without data\n");
        return;
    }
    uint32_t bytes_read = 0;
    uint8_t *current_buffer = (uint8_t *)buffer;

    // 循环读取每个簇的数据
    while (bytes_read < file_size)
    {
        uint32_t bytes_to_read = CLUSER_SIZE;
        if (file_size - bytes_read < CLUSER_SIZE)
        {
            bytes_to_read = file_size - bytes_read; // Ensure we don't read beyond the file
        }

        int result = read_by_byte_cluser(cluster_num, 0, bytes_to_read, current_buffer);
        if (result == -1)
        {
            // printk("Error: Failed to read data\n");
            return;
        }

        bytes_read += bytes_to_read;
        current_buffer += bytes_to_read;
        if (cluster_num < 2)
        {
            panic("cluster_num < 2");
        }
        cluster_num = parse_cluster_number(cluster_num - 2);
        if (cluster_num > FAT_ENTRY_NUM)
            break;
    }
}
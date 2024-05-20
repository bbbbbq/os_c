#include "file.h"
#include "dir.h"
#include "buddy.h"
#include "string.h"
#define min(a, b) ((a) < (b) ? (a) : (b))
void read_file(char *name, void *buffer)
{
    // 查找指定文件的目录项
    Dirent *dir = find_directory_bfs(name, root_dir_entry);
    if (is_directory(dir))
    {
        printk("is_not_file\n");
        return;
    }
    if (dir == NULL)
    {
        printk("File not found\n");
        return;
    }

    // 获取文件的起始簇号和文件大小
    uint32_t cluster_num = extract_cluster_number(dir);
    uint64_t file_size = get_file_or_dir_size(dir);
    if (file_size == 0)
    {
        printk("file without data\n");
    }
    uint32_t bytes_read = 0;
    uint8_t *current_buffer = (uint8_t *)buffer;

    // 循环读取每个簇的数据
    while (bytes_read < file_size)
    {
        uint32_t bytes_to_read = CLUSER_SIZE;
        if (file_size - bytes_read < CLUSER_SIZE)
        {
            bytes_to_read = file_size - bytes_read;
        }
        if (bytes_to_read < CLUSER_SIZE)
        {
            read_by_byte_cluser(cluster_num, 0, bytes_to_read, current_buffer);
        }
        else
        {
            int result = read_by_cluster(cluster_num, current_buffer);
            if (result != 0)
            {
                printk("Error: Failed to read data\n");
                return;
            }
        }
        bytes_read += bytes_to_read;
        current_buffer += bytes_to_read;
        cluster_num = parse_cluster_number(cluster_num);
        if (is_end_of_cluster(cluster_num))
        {
            break;
        }
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

    uint32_t cluster_num = extract_cluster_number(dir);                   // 获取文件的起始簇号
    uint64_t file_size = get_file_or_dir_size(dir);                       // 获取文件大小
    uint32_t cluster_count = (file_size + CLUSER_SIZE - 1) / CLUSER_SIZE; // 计算文件所占的簇数

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
        uint32_t bytes_to_write = min(buffer_size - bytes_written, CLUSER_SIZE); // 计算当前要写入的字节数
        int result = write_by_byte_cluser(cluster_num, bytes_written, bytes_to_write, buffer + bytes_written);
        if (result != 0)
        {
            printk("Error: Failed to write data\n");
            return;
        }
        bytes_written += bytes_to_write;
        uint32_t cluser_t = (uint32_t)find_next_free_cluster(cluster_num);
        set_cluster_number(cluster_num, cluser_t);
        cluster_num = cluser_t;
    }

    // 更新文件大小和结束标记
    set_file_or_dir_size(dir, buffer_size);
    set_cluser_end(cluster_num - 2);
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

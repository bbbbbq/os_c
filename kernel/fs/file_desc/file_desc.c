#include "file_desc.h"
#include "stdint.h"
uint32_t Inode_read_file(Inode *inode, char *buffer)
{
    uint32_t total_size = 0;
    if (buffer == NULL)
        buffer = bd_malloc(get_file_or_dir_size(&inode->dir));
    read_file(inode->dir.DIR_Name, buffer);
    total_size += get_file_or_dir_size(&inode->dir);
    inode->offset += get_file_or_dir_size(&inode->dir);
    return total_size;
}

uint32_t Inode_write_file(Inode *inode, char *buffer, size_t size)
{
    uint32_t total_size = 0;
    if (buffer == NULL)
        ASSERT(0);
    append_to_file(inode->dir.DIR_Name, buffer, size);
    total_size += size;
}

Inode Inode_new_by_file_name(char *name, bool read, bool write)
{
    Inode inode;
    inode.dir = *find_directory_bfs(name, root_dir_entry);
    inode.readable = read;
    inode.writable = write;
}
void read_write(const OpenFlags *flags, bool *readable, bool *writable)
{
    // 初始化为不可读不可写
    *readable = false;
    *writable = false;

    // 检查可读可写
    if (flags->flags & RDWR)
    {
        *readable = true;
        *writable = true;
    }
    else if (flags->flags & WRONLY)
    {
        *writable = true;
    }
    else if (flags->flags == RDONLY)
    {
        *readable = true; // 如果没有设置任何标志或特别设置了RDONLY（实际上为0，通常意味着默认行为）
    }
}

bool contains_invalid_characters(const char *path)
{
    // 假设我们只允许字母、数字、空格和常见的文件路径符号
    const char *valid_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.\\/: ";
    while (*path)
    {
        if (strchr(valid_chars, *path) == NULL)
        {
            return true; // 发现非法字符
        }
        path++;
    }
    return false;
}

bool is_valid_path(const Path *path)
{
    // 检查路径是否为空
    if (path->value[0] == '\0')
    {
        printk("路径无效：路径为空。\n");
        return false;
    }

    // 检查是否包含非法字符
    if (contains_invalid_characters(path->value))
    {
        printk("路径无效：包含非法字符。\n");
        return false;
    }

    // 这里可以添加更多的基本检查，例如路径长度、格式等

    return true; // 所有检查都通过
}

void parse_path(const char *path, char components[MAX_PATH_COMPONENTS][MAX_COMPONENT_LENGTH])
{
    int component_index = 0;
    const char *path_start = path;
    const char *path_end;

    while (*path_start != '\0' && component_index < MAX_PATH_COMPONENTS)
    {
        // 跳过路径分隔符
        if (*path_start == '/')
        {
            path_start++;
            continue;
        }

        // 查找下一个路径分隔符或字符串结尾
        path_end = path_start;
        while (*path_end != '/' && *path_end != '\0')
        {
            path_end++;
        }

        // 计算组件长度
        int length = path_end - path_start;
        if (length > MAX_COMPONENT_LENGTH - 1)
        {
            length = MAX_COMPONENT_LENGTH - 1; // 防止溢出
        }

        // 复制组件到数组
        strncpy(components[component_index], path_start, length);
        components[component_index][length] = '\0'; // 确保字符串结束

        // 更新索引
        component_index++;
        path_start = path_end;
    }
}

void remove_last_path_component(char *path)
{
    if (path == NULL || *path == '\0')
    {
        return; // 如果路径为空或字符串为空，则不进行操作
    }

    char *last_slash = NULL;
    char *current = path;

    // 查找最后一个斜杠（路径分隔符）
    while (*current)
    {
        if (*current == '/')
        {
            last_slash = current; // 更新最后找到的斜杠位置
        }
        current++;
    }

    // 如果找到斜杠，并且它不是路径的第一个字符
    if (last_slash != NULL && last_slash != path)
    {
        *last_slash = '\0'; // 在最后一个斜杠处截断字符串
    }
    else if (last_slash == path)
    {
        // 如果整个路径只有一个斜杠，比如"/bin"，则结果应为根目录"/"
        *(last_slash + 1) = '\0';
    }
}

const char *get_last_path_component(const char *path)
{
    if (path == NULL || *path == '\0')
    {
        return NULL; // 如果路径为空或字符串为空，则不进行操作
    }

    const char *last_slash = NULL;
    const char *current = path;

    // 查找最后一个斜杠（路径分隔符）
    while (*current)
    {
        if (*current == '/')
        {
            last_slash = current; // 更新最后找到的斜杠位置
        }
        current++;
    }

    // 如果找到斜杠，并且它不是字符串的最后一个字符
    if (last_slash != NULL && *(last_slash + 1) != '\0')
    {
        return last_slash + 1; // 返回斜杠之后的部分
    }

    return NULL; // 没有找到有效的最后一个组件
}
void analyze_open_flags(OpenFlags *of, bool *readable, bool *writable, bool *creat, bool *excl, bool *trunc, bool *append, bool *directory)
{
    // 验证传入的指针是否为非空
    if (!of || !readable || !writable || !creat || !excl || !trunc || !append || !directory)
    {
        ASSERT(0);
        return; // 返回，或者根据实际情况进行其他异常处理
    }

    *readable = (of->flags & O_RDONLY) || (of->flags & O_RDWR);
    *writable = (of->flags & O_WRONLY) || (of->flags & O_RDWR);
    *creat = (of->flags & O_CREAT) != 0;
    *excl = (of->flags & O_EXCL) != 0;
    *trunc = (of->flags & O_TRUNC) != 0;
    *append = (of->flags & O_APPEND) != 0;
    *directory = (of->flags & O_DIRECTORY) != 0;
}

Inode Inode_new_by_dirent(Dirent *dir, bool read, bool write, bool append)
{
    Inode inode;
    inode.dir = *dir;
    inode.offset = 0;
    inode.readable = 0;
    inode.readable = read;
    inode.writable = write;
    inode.ref_cnt = 0;
    inode.append = append;
    return inode;
}
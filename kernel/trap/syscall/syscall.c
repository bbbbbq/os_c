// syscall.c

#include "syscall.h"
#include "console.h"
#include "debug.h"
#include "task.h"
#include "sbi.h"
#include "mem.h"
#include "stdint.h"
#include "trap.h"
#include "processor.h"
#include "timer.h"
#include "sys_inode_table.h"
#include "virtio_disk.h"
#include "sys_info.h"
#include "timer.h"
#include "queue.h"
#include "string.h"
#include "console.h"
#include "string.h"
extern MemorySet KERNEL_SPACE;
extern struct utsname globle_info;

int32_t exit(int32_t value)
{
    print_str("exit : ");
    print_uint32((uint32_t)value);
    print_str("\n");
    task_manager_add_new_task();
    task_exit_current_and_run_next();
    return value;
}

void sys_exit(int32_t status)
{
    exit(status);
}

int64_t write(uint64_t fd, char *buf, size_t count)
{
    static uint8_t sys_write_buf[1024];

    switch (fd)
    {
    case 1:
        copy_byte_buffer(processor_current_user_token(), sys_write_buf, (uint8_t *)buf,
                         count, FROM_USER);
        for (uint64_t i = 0; i < count; i++)
        {
            console_putchar(sys_write_buf[i]);
        }
        return (int64_t)count;
    default:
        break;
    }
    return -1;
}

int64_t yield()
{
    print_str("\n-------yield------\n");
    task_suspend_current_and_run_next();
    return 1;
}

size_t read(int32_t fd, uint8_t *buf, size_t len)
{
    ASSERT(len == 1);
    if (fd == 1)
    {
        int32_t c;
        while (1)
        {
            c = console_getchar();
            if (c == 0)
            {
                task_suspend_current_and_run_next();
                continue;
            }
            else
            {
                break;
            }
            uint8_t ch = (uint8_t)c;
            copy_byte_buffer(processor_current_user_token(), &ch, (uint8_t *)buf, 1,
                             TO_USER);
            return 1;
        }
    }
    else
    {
        ASSERT(0);
    }
    return -1;
}

int64_t sys_waitpid(int64_t pid, int *exit_code_ptr)
{
    struct TaskControlBlock *task = processor_current_task();

    bool found = false;
    uint64_t found_idx;
    PidHandle found_pid;
    int exit_code;
    struct TaskControlBlock **x = (struct TaskControlBlock **)(task->children.buffer);
    for (int64_t i = task->children.size - 1; i >= 0; i--)
    {
        if (pid == x[i]->pid.pid || pid == -1)
        {
            found = true;
            found_idx = i;
            found_pid = x[i]->pid;
            exit_code = x[i]->exit_code;
            break;
        }
    }
    if (!found)
    {
        return -1;
    }

    struct TaskControlBlock *task_child = x[found_idx];

    if (task_child->task_status == Zombie)
    {
        task_control_block_free(task_child);
        vector_remove(&task->children, found_idx);
        copy_byte_buffer(memory_set_token(&task->memory_set), (uint8_t *)&exit_code,
                         (uint8_t *)exit_code_ptr, sizeof(int), TO_USER);
        return (int64_t)found_pid.pid;
    }
    else
    {
        return -2;
    }
}
int64_t sys_fork()
{
    // printk("[kernel] sys_fork \n\n");
    struct TaskControlBlock *current_task = processor_current_task();
    struct TaskControlBlock *new_task = task_control_block_fork(current_task);
    PidHandle new_pid = new_task->pid;
    struct TrapContext *trap_cx = task_control_block_get_trap_cx(new_task);
    trap_cx->x[10] = 0;
    task_manager_add_2(&TASK_MANAGER_2, new_task);
    return (int64_t)new_pid.pid;
}

int64_t sys_getpid()
{
    struct TaskControlBlock *task = processor_current_task();
    return (int64_t)task->pid.pid;
}

int64_t sys_exec(char *path)
{
    // for (int i = 0; i < NUM_DESCRIPTORS; i++)
    // {
    //     disk.free[i] = 1;
    // }
    // asm volatile("sfence.vma zero, zero");
    char *test_buffer = bd_malloc(512);
    memset(test_buffer, 1, 512);
    read_block_fs(6, test_buffer);
    asm volatile("sfence.vma zero, zero");
    char app_name[MAX_APP_NAME_LENGTH];
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)app_name,
                     (uint8_t *)path, MAX_APP_NAME_LENGTH, FROM_USER);
    char *name = get_last_part(app_name);
    char *heap_name = bd_malloc(11);
    memcpy(heap_name, name, 11);
    Dirent *dir = find_dir_entry(&root_dir_entry, name);
    uint8_t *data = loader_get_app_data_by_name(heap_name);
    size_t size = loader_get_app_size_by_name(heap_name);
    struct TaskControlBlock *task;

    if (data)
    {
        task = processor_current_task();
        task_control_block_exec(task, data, size);
        return 0;
    }
    else
    {
        return -1;
    }
}

int64_t sys_get_time(TimeVal *ts, int64_t tz)
{
    TimeVal sys_ts;
    int64_t time_us = timer_get_time_us();
    sys_ts.sec = time_us / USEC_PER_SEC;
    sys_ts.usec = time_us % USEC_PER_SEC;
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)&sys_ts,
                     (uint8_t *)ts, sizeof(TimeVal), TO_USER);
    return 0;
}

int64_t syscall(uint64_t syscall_id, uint64_t a0, uint64_t a1, uint64_t a2)
{
    // printk("syscall\n");
    switch (syscall_id)
    {
    // case SYS_CLONE:
    //     return sys_clone((char *)a0, (uint32_t)a1);
    case SYS_OPEN:
        return sys_open((char *)a0, (uint32_t)a1);
    case SYS_BRK:
        return SYS_brk((uint64_t)a0);
    case SYS_GETCWD:
        return SYS_getcwd((char *)a0, (size_t)a1);
    // case SYS_pipe2:
    //     return SYS_pipe2((int *)a0, (int)a1);
    case SYS_DUP:
        return SYS_dup((int)a0);
    case SYS_DUP3:
        return SYS_dup3((int)a0, (int)a1);
    case SYS_CHDIR:
        return SYS_chdir((char *)a0);
    case SYS_OPENAT:
        return sys_openat((int)a0, (char *)a1, *(OpenFlags *)a2);
    case SYS_CLOSE:
        return sys_close((uint32_t)a0);
    case SYS_READ:
        return SYS_read((int)a0, (char *)a1, (uint32_t)a2);
    case SYS_WRITE:
        return SYS_write((int)a0, (char *)a1, (uint64_t)a2);
    // case SYS_linkat:
    //     return sys_linkat((int)a0, (char *)a1, (int)a2, (char *)a3, (unsigned int)a4); // Assuming a3 and a4 are additional parameters
    // case SYS_unlinkat:
    //     return sys_unlinkat((int)a0, (char *)a1, (unsigned int)a2);
    case SYS_MKDIRAT:
        return SYS_mkdirat((char *)a1, (uint64_t)a2);
    // case SYS_mount:
    //     return sys_mount((const char *)a0, (const char *)a1, (const char *)a2, (unsigned long)a3, (const void *)a4); // Assuming a2, a3, and a4 are additional parameters
    // case SYS_umount2:
    //     return sys_umount2((const char *)a0, (int)a1);
    case SYS_FSTAT:
        return SYS_fstat((int)a0, (char *)a1);
    case SYS_GETDENTS64:
        return SYS_getdents64((int)a0, (char *)a1);
    // case SYS_CLONE:
    //     return sys_clone((unsigned long)a0, (void *)a1, (int *)a2, (void *)a3, (int *)a4); // Assuming a1, a2, a3, and a4 are additional parameters
    case SYS_EXECVE:
        return sys_exec((char *)a0); // Assuming execve is handled by sys_exec for simplification
    case SYS_EXIT:
        sys_exit((int)a0);
        return -1; // sys_exit does not return
    case SYS_SCHED_YIELD:
        return yield(); // Assuming yield is correctly named and takes no parameters
    case SYS_CLONE:
        return sys_fork();
    // case :
    //     return SYS_gettimeofday((struct timespec *)a0, (int64_t)a1);
    // case SYS_nanosleep:
    //     return sys_nanosleep((const struct timespec *)a0, (struct timespec *)a1); // Assuming a1 is an additional parameter
    default:
        printk("Unsupported syscall ID %d", syscall_id);
        ASSERT(0);
        return -1;
    }
}

int64_t sys_openat(int32_t fd, char *file_name, OpenFlags flage)
{
    bool readable = false;
    bool writable = false;
    bool creat = false;
    bool excl = false;
    bool trunc = false;
    bool append = false;
    bool directory = false;
    analyze_open_flags(&flage, &readable, &writable, &creat, &excl, &trunc, &append, &directory);
    struct TaskControlBlock *current_task = processor_current_task();
    Inode *inode = sys_inode_table_find_fs(fd);
    if (inode == NULL && !creat)
        return -1;
    Dirent dir = inode->dir;
    Dirent *tar_dir = find_directory_bfs(file_name, dir);
    if (tar_dir == NULL && creat)
    {
        create_dir(&dir, *tar_dir);
        Inode inode = Inode_new_by_dirent(tar_dir, read, write, append);
        uint32_t inode_index = add_inode_to_Inode_table(&sys_inode_table, &inode);
        uint64_t new_fd = vector_push(&current_task->inode_table_index, inode_index);
        return new_fd;
    }
    else
    {
        Inode inode = Inode_new_by_dirent(tar_dir, read, write, append);
        uint32_t inode_index = add_inode_to_Inode_table(&sys_inode_table, &inode);
        uint64_t new_fd = vector_push(&current_task->inode_table_index, inode_index);
        return new_fd;
    }
    return -1;
}

int64_t sys_open(const char *pathname, uint32_t flage_t)
{
    OpenFlags flage;
    flage.flags = flage_t;
    struct TaskControlBlock *current_task = processor_current_task();
    bool readable = false;
    bool writable = false;
    bool creat = false;
    bool excl = false;
    bool trunc = false;
    bool append = false;
    bool directory = false;
    analyze_open_flags(&flage, &readable, &writable, &creat, &excl, &trunc, &append, &directory);
    Dirent *dir = find_dir_by_path(pathname);
    if (dir == NULL)
    {
        Dirent *new_dir = create_file_or_dir_by_path(pathname, ATTR_FILE);
        Inode inode = Inode_new_by_dirent(new_dir, read, write, append);
        uint32_t inode_index = add_inode_to_Inode_table(&sys_inode_table, &inode);
        uint64_t new_fd = vector_push(&current_task->inode_table_index, inode_index);
        return new_fd;
    }
    else
    {
        Inode inode = Inode_new_by_dirent(dir, read, write, append);
        uint32_t inode_index = add_inode_to_Inode_table(&sys_inode_table, &inode);
        uint64_t new_fd = vector_push(&current_task->inode_table_index, inode_index);
        return new_fd;
    }
    return -1;
}

// buf：一个缓存区，用于保存所读取目录的信息。缓存区的结构如下：
//     struct dirent
// {
//     uint64 d_ino;            // 索引结点号
//     int64 d_off;             // 到下一个dirent的偏移
//     unsigned short d_reclen; // 当前dirent的长度
//     unsigned char d_type;    // 文件类型
//     char d_name[];           // 文件名
// };
int64_t SYS_getdents64(int64_t fd, char *buffer)
{
    struct dirent
    {
        uint64_t d_ino;                   // 索引结点号
        int64_t d_off;                    // 到下一个dirent的偏移
        unsigned short d_reclen;          // 当前dirent的长度
        unsigned char d_type;             // 文件类型
        char d_name[MAX_APP_NAME_LENGTH]; // 文件名
    };
    struct TaskControlBlock *current_task = processor_current_task();
    uint64_t *sys_inode_index = vector_get(&current_task->inode_table_index, fd);
    if (sys_inode_index == NULL)
        return -1;
    else
    {
        Inode *inode = find_index_inode(sys_inode_table, *sys_inode_index);
        struct dirent dents;
        dents.d_ino = inode->dir.DIR_FstClusHI;
        dents.d_off = inode->dir.DIR_FstClusLO;
        dents.d_reclen = inode->dir.DIR_FileSize;
        dents.d_type = inode->dir.DIR_Attr;
        memcpy(dents.d_name, inode->dir.DIR_Name, 11);
        return 0;
    }
    return 0;
}

int64_t SYS_read(int64_t fd, char *buffer, uint32_t count)
{
    struct TaskControlBlock *task = processor_current_task();
    uint64_t *sys_inode_index = vector_get(&task->inode_table_index, fd);
    Inode *inode = find_index_inode(sys_inode_table, *sys_inode_index);
    if (sys_inode_index == NULL)
        return -1;
    if (fd == 0)
    {
        return console_stdin(buffer, count);
    }
    if (fd <= 2 || fd > MAX_APP_NUM || !inode)
    {
        return -1;
    }
    if (inode == NULL)
    {
        return -1;
    }
    else
    {
        read_file_by_byte(&inode->dir, 0, buffer, count);
        return count;
    }
    return -1;
}

int64_t SYS_write(int64_t fd, char *buffer, uint64_t count)
{
    return console_stdout(buffer, count);
}

int64_t SYS_mkdirat(char *path_addr, uint64_t mode)
{
    char *path = bd_malloc(11);
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)path, (uint8_t *)path_addr,
                     11, FROM_USER);
    Dirent *dir = find_dir_by_path(path);
    if (dir == NULL)
        return -1;
    bool owner_read;
    bool owner_write;
    bool owner_exec;
    parse_mode(mode, &owner_read, &owner_write, &owner_exec);
    uint32_t attr;
    attr = ATTR_DIRECTORY;
    create_file_or_dir_by_path(path, attr);
    return 0;
}

int64_t SYS_fstat(int64_t fd, char *kst)
{
    struct kstat
    {
        uint8_t st_dev;
        uint32_t st_ino;
        uint32_t st_mode;
        uint32_t st_nlink;
        uint8_t st_uid;
        uint8_t st_gid;
        uint8_t st_rdev;
        unsigned long __pad;
        uint32_t st_size;
        uint32_t st_blksize;
        int __pad2;
        uint32_t st_blocks;
        long st_atime_sec;
        long st_atime_nsec;
        long st_mtime_sec;
        long st_mtime_nsec;
        long st_ctime_sec;
        long st_ctime_nsec;
        unsigned __unused[2];
    };
    struct TaskControlBlock *task = processor_current_task();
    uint64_t *sys_inode_index = vector_get(&task->inode_table_index, fd);
    if (!sys_inode_index)
        return -1;
    Inode *inode = find_index_inode(sys_inode_table, *sys_inode_index);
    if (!inode)
        return -1;
    struct kstat kt;
    memcpy(&kt, 0, sizeof(struct kstat));
    return 0;
}

int64_t SYS_getcwd(char *buffer, size_t size)
{
    struct TaskControlBlock *current_task = processor_current_task();
    if (buffer == NULL || size == 0)
        return -1;

    char *pwd = current_task->pwd;
    if (pwd == NULL)
        return -1;
    copy_byte_buffer(processor_current_user_token(), pwd, buffer,
                     size, TO_USER);

    return strlen(pwd);
}

int64_t SYS_chdir(char *path)
{
    if (path == NULL)
        return -1;
    char path_buf[MAX_PWD_LENTH];
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)path_buf, (uint8_t *)path,
                     MAX_PWD_LENTH, FROM_USER);
    struct TaskControlBlock *current_task = processor_current_task();
    strncpy(current_task->pwd, path_buf, MAX_PWD_LENTH - 1);
    current_task->pwd[MAX_PWD_LENTH - 1] = '\0';
    return 0;
}

int64_t SYS_dup(int64_t fd)
{
    struct TaskControlBlock *task = processor_current_task();
    uint64_t *sys_inode_index = vector_get(&task->inode_table_index, fd);
    Inode *inode = find_index_inode(sys_inode_table, sys_inode_index);
    if (sys_inode_index == NULL)
        return -1;
    else
    {
        int32_t t = fd;
        int64_t tmp = vector_push(&task->inode_table_index, &t);
        return tmp;
    }
}

int64_t SYS_dup3(int64_t old_fd, int64_t new_fd)
{
    struct TaskControlBlock *task = processor_current_task();
    uint64_t *sys_inode_index = vector_get(&task->inode_table_index, old_fd);
}

int64_t SYS_uname(char *uts)
{
    if (uts == NULL)
        return -1;
    strncpy(&globle_info, uts, sizeof(struct utsname));
    return 0;
}

struct tms
{
    uint64_t tms_utime;  // 用户 CPU 时间
    uint64_t tms_stime;  // 系统 CPU 时间
    uint64_t tms_cutime; // 已终止子进程的用户 CPU 时间
    uint64_t tms_cstime; // 已终止子进程的系统 CPU 时间
};

int64_t SYS_times(char *uts)
{
    struct TaskControlBlock *current_task = processor_current_task();
    struct tms times;
    memset(&times, 0, sizeof(struct tms));
    times.tms_utime = current_task->user_times;
    times.tms_stime = current_task->sys_times;
    uint32_t vector_cnt = vector_size(&current_task->children);
    for (int i = 0; i < vector_cnt; i++)
    {
        struct TaskControlBlock *tmp = vector_get(&current_task->children, i);
        if (tmp->task_status == Exited)
        {
            times.tms_cstime += tmp->sys_times;
            times.tms_cutime += tmp->user_times;
        }
    }
    memcmp(&times, uts, sizeof(struct tms));
    return 0;
}

int64_t SYS_brk(uint64_t address_change)
{

    struct TaskControlBlock *current_task = processor_current_task();
    if (address_change == 0)
        return current_task->base_size;
    if (current_task == NULL)
        return -1;
    uint64_t base_size = current_task->user_pace_size;
    if (address_change > 0)
    {
        current_task->user_pace_size += address_change;
        VirtAddr start_va = base_size;
        VirtAddr end_va = address_change;
        memory_set_insert_framed_area(&current_task->memory_set,
                                      start_va, end_va,
                                      PTE_W | PTE_R);
        current_task->base_size = address_change;
        return 0;
    }
    else
    {
        current_task->user_pace_size -= address_change;
        return 0;
    }
}

int64_t sys_munmap(uint64_t start, uint64_t len)
{
    struct TaskControlBlock *current_task = processor_current_task();
    MemorySet *memory_set = &current_task->memory_set;
    if (memory_set_munmap(memory_set, start, len) == len)
        return 0;
    return -1;
}

int64_t sys_getppid()
{
    struct TaskControlBlock *parent_task = processor_current_task()->parent;
    return parent_task->pid.pid;
}

int64_t SYS_gettimeofday(char *buffer, int64_t t1)
{
    struct timespec ts;
    ts.tv_sec = ticks / 100000;
    ts.tv_nsec = ticks * 2;
    strncpy(buffer, &ts, sizeof(struct timespec));
    return 0;
}
// 为实现进程共享
uint64_t sys_mmap(uint64_t addr, uint64_t len, uint64_t prot,
                  uint64_t flags, uint64_t fd, uint64_t pgoff)
{
    bool readable = false;
    bool writable = false;
    bool creat = false;
    bool excl = false;
    bool trunc = false;
    bool append = false;
    bool directory = false;
    OpenFlags flage;
    flage.flags = flags;
    analyze_open_flags(&flage, &readable, &writable, &creat, &excl, &trunc, &append, &directory);

    struct TaskControlBlock *current_task = processor_current_task();
    if (fd >= queue_size(&current_task->inode_table_index))
    {
        return -1; // 错误：文件描述符超出范围
    }

    uint32_t inode_index = queue_get_at(&current_task->inode_table_index, fd);
    Inode *inode = find_index_inode(sys_inode_table, inode_index);
    if (inode == NULL)
    {
        return -1; // 错误：无法找到索引节点
    }

    char *buffer;
    uint32_t file_size = inode->dir.DIR_FileSize;

    if (len > file_size)
    {
        return -1; // 错误：请求长度超过文件大小
    }

    buffer = bd_malloc(file_size);
    if (buffer == NULL)
    {
        return -1; // 错误：内存分配失败
    }

    if (Inode_read_file(inode, buffer) != file_size)
    {
        bd_free(buffer);
        return -1; // 错误：文件读取失败
    }

    if (pgoff > file_size)
    {
        bd_free(buffer);
        return -1; // 错误：偏移量超出文件大小
    }

    char *buffer_offset = buffer + pgoff;

    map_area_copy_data(&current_task->memory_set, &KERNEL_SPACE.page_table, buffer_offset, len);

    bd_free(buffer); // 清理临时分配的内存
    return 0;        // 成功
}

int32_t sys_close(uint32_t fd)
{
    struct TaskControlBlock *current_task = processor_current_task();

    vector_zero_at_index(&current_task->inode_table_index, fd);
    return 1;
}

int64_t sys_clone(uint64_t flags, void *stack, int64_t ptid, void *tls, int64_t ctid)
{
}
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
int32_t exit(int32_t value)
{
    print_str("exit : ");
    print_uint32((uint32_t)value);
    print_str("\n");
    return value;
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

int64_t sys_write(uint64_t fd, char *buf, size_t count)
{
    return write(fd, buf, count);
}

void sys_exit(int32_t status)
{
    exit(status);
}

int64_t sys_yield()
{
    return yield();
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
    printk("[kernel] sys_fork \n\n");
    struct TaskControlBlock *current_task = processor_current_task();
    struct TaskControlBlock *new_task = task_control_block_fork(current_task);
    PidHandle new_pid = new_task->pid;

    // modify trap context of new_task, because it returns immediately after
    // switching
    struct TrapContext *trap_cx = task_control_block_get_trap_cx(new_task);

    // we do not have to move to next instruction since we have done it before
    // for child process, fork returns 0
    trap_cx->x[10] = 0;

    // add new task to scheduler
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
    char app_name[MAX_APP_NAME_LENGTH];
    copy_byte_buffer(processor_current_user_token(), (uint8_t *)app_name,
                     (uint8_t *)path, MAX_APP_NAME_LENGTH, FROM_USER);

    uint8_t *data = loader_get_app_data_by_name(app_name);
    size_t size = loader_get_app_size_by_name(app_name);
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
    switch (syscall_id)
    {
    case SYSCALL_WAITPID:
        return sys_waitpid((int64_t)a0, (int *)a1);
    case SYSCALL_READ:
        return read(a0, (char *)a1, a2);
    case SYSCALL_WRITE:
        return sys_write(a0, (char *)a1, a2);
    case SYSCALL_EXIT:
        sys_exit((int)a0);
        return -1;
    case SYSCALL_YIELD:
        return yield();
    // case SYSCALL_SET_PRIORITY:
    //     return set_priority((int64_t)a0);
    case SYSCALL_GET_TIME:
        return sys_get_time((TimeVal *)a0, (int64_t)a1);
    case SYSCALL_GETPID:
        return sys_getpid();
    // case SYSCALL_MUNMAP:
    //     return sys_munmap(a0, a1);
    case SYSCALL_FORK:
        printk("[kernel] sys_fork \n\n");
        return sys_fork();
    case SYSCALL_EXEC:
        return sys_exec((char *)a0);
    // case SYSCALL_MMAP:
    //     return sys_mmap(a0, a1, a2);
    // case SYSCALL_WAITPID:
    //     return sys_waitpid((int64_t)a0, (int *)a1);
    // case SYSCALL_SPAWN:
    //     return sys_spawn((char *)a0);
    default:
        printk("unsopport_sys_id %d", syscall_id);
        ASSERT(0);
        break;
    }
    return -1;
}

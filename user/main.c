#include "stdint.h"
#include "stdio.h"

extern int64_t main(void);

/**
 *  @brief: user_lib总入口
 */
void lib_main(void)
{
    printf("[user_lib] init ok\n");
    printf("[user_lib] second print test.\n");
    sys_exit(main());
}

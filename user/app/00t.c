
#include "lib/stdio.h"
#include "user_lib.h"
#include "type.h"


i64 main( void )
{
    printf("00t");
    int cnt=0;
    for(int i=0;i<20;i++)
    {
        printf("cnt: %d \n",cnt++);
    }
    sys_exit(1);
    return 0;
}

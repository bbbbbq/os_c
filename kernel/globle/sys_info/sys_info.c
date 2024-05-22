#include "sys_info.h"

struct utsname globle_info;

void init_sys_info()
{
    strcpy(globle_info.sysname, "MyOS");    // 示例操作系统名
    strcpy(globle_info.nodename, "MyNode"); // 示例主机名
    strcpy(globle_info.release, "1.0");     // 示例发布级别
    strcpy(globle_info.version, "1.0.0");   // 示例版本号
    strcpy(globle_info.machine, "x86_64");  // 示例硬件架构
    strcpy(globle_info.domainname, "caigoubencai");
}
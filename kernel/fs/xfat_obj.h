/**
 * 资源作者的介绍及文件系统的基本信息 - 本代码为FAT32文件系统的基础结构定义，每个对象对应一个实时处理节点，以下是详细注释。
 * 作者：张三铜
 * 课程网址：http://01ketang.cc
 * 版权声明：本源代码为开源项目，可自由使用、学习、修改和分享。在使用前，请联系原作者。
 */

#ifndef XFAT_OBJ_H
#define XFAT_OBJ_H

#include "xtypes.h"  // 引入基本类型定义头文件

/**
 * 宏定义，将void*类型的obj强制转换为type_p类型的指针。
 */
#define to_type(obj, type_p)    ((type_p *)(obj))

/**
 * 宏定义，将void*类型的obj强制转换为xfat_obj_t类型的指针。
 */
#define to_obj(obj)             ((xfat_obj_t *)(obj))

/**
 * 定义XFAT对象类型的枚举，用于标识对象的类型。
 */
typedef enum _xfat_obj_type_t {
    XFAT_OBJ_DISK,    // 表示一个磁盘对象
    XFAT_OBJ_FAT,     // 表示一个FAT表对象
    XFAT_OBJ_FILE,    // 表示一个文件对象
} xfat_obj_type_t;;

/**
 * XFAT对象的结构体定义。
 */
typedef struct _xfat_obj_t {
    xfat_obj_type_t type;  // 对象类型
} xfat_obj_t;

/**
 * 初始化一个XFAT对象。
 * @param obj 指向要初始化的XFAT对象的指针
 * @param type 要初始化的对象的类型
 * @return 返回操作结果，如果成功则返回0，否则返回错误代码。
 */
xfat_err_t xfat_obj_init(xfat_obj_t* obj, xfat_obj_type_t type);

#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

#define TARGET_PATH "user/target/"

// 检查文件是否为ELF格式
int is_elf(const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file) {
        char header[4];
        // 读取文件头的前四个字节
        if (fread(header, 1, 4, file) == 4) {
            // 检查ELF文件的魔数
            if (header[0] == 0x7f && header[1] == 'E' && header[2] == 'L' && header[3] == 'F') {
                fclose(file);
                return 1; // 是ELF文件
            }
        }
        fclose(file);
    }
    return 0; // 不是ELF文件或读取失败
}

int main() {
    DIR *d;
    struct dirent *dir;
    d = opendir(TARGET_PATH);
    if (d) {
        FILE *f = fopen("kernel/asm/link_app.asm", "w");
        if (f == NULL) {
            printf("Failed to open file1\n");
            return EXIT_FAILURE;
        }

        fprintf(f, 
            ".align 3\n"
            ".section .data\n"
            ".global _num_app\n"
            "_num_app:\n");

        int app_count = 0;
        while ((dir = readdir(d)) != NULL) {
            if (dir->d_type == DT_REG) { // 确保是一个常规文件
                char filepath[1024];
                snprintf(filepath, sizeof(filepath), "%s%s", TARGET_PATH, dir->d_name);
                if (is_elf(filepath)) {
                    app_count++;
                }
            }
        }

        fprintf(f, "    .quad %d\n", app_count); // 写入应用数量

        // 再次遍历目录，这次写入每个应用的开始和结束
        rewinddir(d); // 重置目录流的位置
        int idx = 0;
        while ((dir = readdir(d)) != NULL) {
            if (dir->d_type == DT_REG) {
                char filepath[1024];
                snprintf(filepath, sizeof(filepath), "%s%s", TARGET_PATH, dir->d_name);
                if (is_elf(filepath)) {
                    fprintf(f, "    .quad app_%d_start\n", idx);
                    fprintf(f, "    .quad app_%d_end\n", idx);
                    idx++;
                }
            }
        }


        fprintf(f, 
            ".global _app_names\n"
            "_app_names:\n");

        // 最后，写入每个应用的名字和数据
        rewinddir(d); // 再次重置目录流的位置
        idx = 0;
        while ((dir = readdir(d)) != NULL) {
            if (dir->d_type == DT_REG) {
                char filepath[1024];
                snprintf(filepath, sizeof(filepath), "%s%s", TARGET_PATH, dir->d_name);
                if (is_elf(filepath)) {
                    // 写入应用名
                    fprintf(f, "    .string \"%s\"\n", dir->d_name);

                    // 写入应用数据
                    fprintf(f, 
                        ".section .data\n"
                        ".global app_%d_start\n"
                        ".global app_%d_end\n"
                        ".align 3\n"
                        "app_%d_start:\n"
                        "    .incbin \"%s\"\n"
                        "app_%d_end:\n", 
                        idx, idx, idx, filepath, idx);
                    idx++;
                }
            }
        }

        fclose(f);
        closedir(d);
    } else {
        printf("Failed to open directory\n");
        return EXIT_FAILURE;
    }

    return 0;
}
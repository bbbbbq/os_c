#include "console.h"
void panic(const char *file, int line) {
    print_str("Panic! File: ");
    print_str(file);
    print_str(", Line: ");
    print_uint32(line);
    print_str("\n");
    // sbi_shutdown();
    while(1);
}
#include "user_lib.h"

int main() {
    print_str("Try to execute privileged instruction in U Mode\n");
    print_str("Kernel should kill this application!\n");
    __asm__("sret");
    return 0;
}
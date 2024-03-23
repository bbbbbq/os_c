#include "user_lib.h"

int main() {
    print_str("Try to access privileged CSR in U Mode\n");
    print_str("Kernel should kill this application!\n");
    __asm__ volatile (
        "csrw sstatus, %0"
        :
        : "r" (0)
    );
    return 0;
}

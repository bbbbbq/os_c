// #include "memory.h"
// #include "stdint.h"

// // typedef struct 
// // {
// //     unsigned char a[MAX_PHYSICAL_PAGES << 1];
// //     unsigned int m, n, offset;
// // } SegmentTreeAllocator;

// void init_memory(SegmentTreeAllocator* sta, uint32_t l, uint32_t r) 
// {
    
// }
// uint32_t alloc(SegmentTreeAllocator* sta) 
// {
//     if (sta->a[1] == 1) 
//     {
//         print_str("Physical memory depleted!\n");
//         ASSERT(1==0);
//     }
//     int p = 1;
//     while (p < sta->m) 
//     {
//         if (sta->a[p << 1] == 0) { p = p << 1; } else { p = (p << 1) | 1; }
//     }
//     uint32_t result = p + sta->offset - sta->m;
//     sta->a[p] = 1;
//     while (p > 0) 
//     {
//         p >>= 1;
//         sta->a[p] = sta->a[p << 1] & sta->a[(p << 1) | 1];
//     }
//     return result;
// }

// void dealloc(SegmentTreeAllocator* sta, unsigned int n) 
// {
//     int p = n + sta->m - sta->offset;
//     ASSERT(sta->a[p] == 1);
//     sta->a[p] = 0;
//     while (p > 0) 
//     {
//         p >>= 1;
//         sta->a[p] = sta->a[p << 1] & sta->a[(p << 1) | 1];
//     }
// }
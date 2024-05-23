#include "block_cache.h"
#include "driver.h"
#include "fs_globle.h"
#include "dir.h"
#include "file.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
void print_block_data(const unsigned char *block_data, int block_size)
{
    for (int i = 0; i < block_size; ++i)
    {
        printf("%02x ", block_data[i]);
        if ((i + 1) % 16 == 0)
        {
            printf("\n");
        }
    }
}

typedef struct
{
    unsigned char e_ident[16]; // ELF Identification
    uint16_t e_type;           // Object file type
    uint16_t e_machine;        // Machine type
    uint32_t e_version;        // Object file version
    uint64_t e_entry;          // Entry point address
    uint64_t e_phoff;          // Program header offset
    uint64_t e_shoff;          // Section header offset
    uint32_t e_flags;          // Processor-specific flags
    uint16_t e_ehsize;         // ELF header size
    uint16_t e_phentsize;      // Size of program header entry
    uint16_t e_phnum;          // Number of program header entries
    uint16_t e_shentsize;      // Size of section header entry
    uint16_t e_shnum;          // Number of section header entries
    uint16_t e_shstrndx;       // Section name string table index
} Elf64_Ehdr;

Device fat_device;

int read_elf_file(char *filename, uint8_t **buffer, uint64_t *file_size)
{
    FILE *file = fopen(filename, "rb");
    if (file == NULL)
    {
        perror("Failed to open file");
        return -1;
    }

    // Determine the file size
    fseek(file, 0, SEEK_END);
    *file_size = ftell(file);
    fseek(file, 0, SEEK_SET);

    // Allocate memory for the buffer if it's not already allocated
    if (*buffer == NULL)
    {
        *buffer = malloc(*file_size);
        if (*buffer == NULL)
        {
            perror("Failed to allocate memory for the ELF file");
            fclose(file);
            return -1;
        }
    }

    // Read the entire file into the buffer
    if (fread(*buffer, 1, *file_size, file) != *file_size)
    {
        perror("Failed to read the ELF file");
        fclose(file);
        return -1;
    }
    fclose(file);
    return 0;
}

bool add_elf_to_root(char *file_name)
{
    uint8_t *buffer = NULL;
    uint64_t file_size = 0;
    if (read_elf_file(file_name, &buffer, &file_size) == -1)
    {
        free(buffer); // 确保失败时释放buffer
        return false;
    }
    add_file_or_dir_to_parent_directory(file_name, ATTR_FILE, &root_dir_entry, &fat_device);
    over_write_file(file_name, buffer, &fat_device, file_size);
    free(buffer); // 成功后也要确保释放buffer
    return true;
}

int main()
{
    const uint32_t block_size = 512;
    const uint64_t total_blocks = 4ULL * 1024 * 1024 * 1024 / block_size;
    if (initialize_device(&fat_device, "myfilesystem.img", total_blocks, block_size) != 0)
    {
        fprintf(stderr, "Failed to initialize device\n");
        return 1;
    }
    BlockCache_manager_init();
    formate_fat32(&fat_device);
    init_root_entry();
    add_elf_to_root("brk.elf");
    ls_dir(&root_dir_entry);
}

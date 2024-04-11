# Compiler and linker configurations
CC = riscv64-unknown-elf-gcc
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld

# Directories
BOOTLOADER_DIR = bootloader
KERNEL_DIR = kernel
OBJDIR = obj
ELF = $(OBJDIR)/os_kernel.elf

# Include directories
INCLUDE_DIRS = -I$(KERNEL_DIR)/sbi -I$(KERNEL_DIR)/globle \
				-I$(KERNEL_DIR)/debug -I$(KERNEL_DIR)/console \
				-I$(KERNEL_DIR)/batch -I$(KERNEL_DIR)/string  \
				-I$(KERNEL_DIR)/trap/syscall -I$(KERNEL_DIR)/trap \
				-I$(KERNEL_DIR)/batch/context  -I$(KERNEL_DIR)/batch/stack \
				-I$(KERNEL_DIR)/batch/task   -I$(KERNEL_DIR)/trap/timer \
				-I$(KERNEL_DIR)/memory/kernel_heap  -I$(KERNEL_DIR)/memory/address \
				-I$(KERNEL_DIR)/data_structure   -I$(KERNEL_DIR)/memory/address/fram_allocator \
				-I$(KERNEL_DIR)/memory/pagetable   -I$(KERNEL_DIR)/memory/pagetable/pte  \
				-I$(KERNEL_DIR)/memory/task_memory  -I$(KERNEL_DIR)/lib  \
				-I$(KERNEL_DIR)/memory  -I$(KERNEL_DIR)/memory/buddy   \
				-I$(KERNEL_DIR)/memory/kernel_address -I$(KERNEL_DIR)/elf \
				-I$(KERNEL_DIR)/memory/mem  -I$(KERNEL_DIR)/memory/buddy \
				-I$(KERNEL_DIR)/batch/loader -I$(KERNEL_DIR)/batch/pid


# Compilation and linking flags
CFLAGS = $(INCLUDE_DIRS) -march=rv64gc -mabi=lp64d -nostdlib -mcmodel=medany -g -fno-builtin -Wall
ASFLAGS = $(INCLUDE_DIRS) -march=rv64gc -mabi=lp64d -g
LDFLAGS = -T$(BOOTLOADER_DIR)/linker.ld -nostartfiles -nostdlib -g


# Find all source files
C_SOURCES = $(shell find $(KERNEL_DIR)/ -name "*.c")
ASM_SOURCES = $(shell find $(KERNEL_DIR)/asm/ -name "*.asm")
OBJECTS = $(C_SOURCES:%.c=$(OBJDIR)/%.o) $(ASM_SOURCES:%.asm=$(OBJDIR)/%.o)

# Output binary
BIN = $(OBJDIR)/os_kernel.bin

# Default make target
all: $(BIN)

# Dependency files
DEP_FILES = $(OBJECTS:.o=.d)

# Link objects into a binary
$(BIN): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

# Compile C source files
$(OBJDIR)/%.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly source files
$(OBJDIR)/%.o: %.asm
	mkdir -p $(@D)
	$(AS) $(ASFLAGS) $< -o $@

# Clean build

# Include dependencies
-include $(DEP_FILES)

# Generate dependencies for C source files
$(OBJDIR)/%.d: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -MM -MT '$(@:.d=.o)' $< -MF $@

run: $(BIN)
	qemu-system-riscv64 -machine virt -kernel $(BIN) -nographic --bios default -m 512M

qemu_debug: $(BIN)
	qemu-system-riscv64 -machine virt -kernel $(BIN) -nographic --bios default -m 512M -S -s 

elf: $(ELF)

$(ELF): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^
disassemble: $(ELF)
	riscv64-unknown-elf-objdump -d -S -l $(ELF) > os_kernel.asm

disassemble_all: $(ELF)
	riscv64-unknown-elf-objdump -D $(ELF) > os_kernel_all.asm
# Clean build, corrected to remove $(OBJDIR) only once
clean:
	rm -rf $(OBJDIR)
	rm -f os_kernel.asm



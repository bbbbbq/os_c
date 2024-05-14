CROSS_PREFIX = riscv64-unknown-elf-
CC = $(CROSS_PREFIX)gcc
OBJCOPY = $(CROSS_PREFIX)objcopy
OBJDUMP = $(CROSS_PREFIX)objdump

INC_DIR = ./include
SRC_LINKER = ./linker/linker.ld
TARGET_DIR = ./target
APP_DIR = ./app
LIB_DIR = -L/home/caigoubencai/Desktop/os_c-ch6/libc/build -lmylibc

# Include the library path and link against libc.a
LIB_FLAGS = -l$(LIB_DIR) -lc

# Auto-find C files in app directory
APP_SRCS = $(wildcard $(APP_DIR)/*.c)
# Map each C file to an ELF file in the target directory
APP_TARGETS = $(patsubst $(APP_DIR)/%.c,$(TARGET_DIR)/%.elf,$(APP_SRCS))

# Other source files
COMMON_SRCS = ./start.s ./main.c

# Ensure the target directory exists before building anything
.PHONY: all build clean dump
all: build

build: $(TARGET_DIR) $(APP_TARGETS)

$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

# Rule to create each ELF file
$(TARGET_DIR)/%.elf: $(APP_DIR)/%.c $(COMMON_SRCS)
	$(CC) $^ -o $@ -T$(SRC_LINKER) -I$(INC_DIR) -nostdinc -nostdlib -mcmodel=medany -fno-builtin $(LIB_FLAGS)
	$(OBJCOPY) --strip-all $@ -O binary $@.bin

dump:
	$(OBJDUMP) -h $(APP_TARGETS)

clean:
	rm -rf $(TARGET_DIR)/*

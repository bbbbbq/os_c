CROSS_PREFIX = riscv64-unknown-elf-
CC = $(CROSS_PREFIX)gcc

OBJCOPY = rust-objcopy
OBJDUMP = rust-objdump

INC_DIR = ./include
SRC_LINKER = ./linker/linker.ld
TARGET_DIR = ./target
APP_DIR = ./app
LIB_DIR = ./lib

# 自动寻找 app 目录下的所有 c 文件
APP_SRCS = $(wildcard $(APP_DIR)/*.c)
# 将每个 c 文件名映射到 target 目录下的 elf 文件
APP_TARGETS = $(patsubst $(APP_DIR)/%.c,$(TARGET_DIR)/%.elf,$(APP_SRCS))

# 其他源文件
COMMON_SRCS = ./start.s ./main.c ./syscall.c $(LIB_DIR)/printf.c $(LIB_DIR)/string.c

build: $(APP_TARGETS)

# 通用规则，用于生成每个应用程序的 ELF 文件
$(TARGET_DIR)/%.elf: $(APP_DIR)/%.c $(COMMON_SRCS)
	$(CC) $^ -o $@ -T$(SRC_LINKER) -I$(INC_DIR) -nostdinc -nostdlib -mcmodel=medany -fno-builtin
	$(OBJCOPY) --strip-all $@ -O binary $@.bin

dump:
	$(OBJDUMP) -h $(APP_TARGETS)

clean:
	rm -f $(TARGET_DIR)/*

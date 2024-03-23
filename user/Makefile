# Compiler and linker configurations
CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy

# Source and build directories
SRC_DIR = .
BIN_DIR = $(SRC_DIR)/bin
LIB_DIR = $(SRC_DIR)/lib

BUILD_DIR = build

# Compilation flags
CFLAGS = -I$(SRC_DIR)/lib/console -I$(SRC_DIR)/lib/debug -I$(SRC_DIR)/lib/string \
         -I$(SRC_DIR)/lib/syscall -I$(SRC_DIR)/lib -march=rv64gc -mabi=lp64d -nostdlib -mcmodel=medany -g

# Linker script
LINKER_SCRIPT = $(SRC_DIR)/linker.ld

# Find source files
APP_SOURCES = $(wildcard $(BIN_DIR)/*.c)
LIB_SOURCES = $(wildcard $(SRC_DIR)/lib/*.c) $(wildcard $(SRC_DIR)/lib/debug/*.c) \
              $(wildcard $(SRC_DIR)/lib/string/*.c) $(wildcard $(SRC_DIR)/lib/syscall/*.c) \
              $(wildcard $(SRC_DIR)/lib/console/*.c)

# Define ELF targets
APP_ELFS = $(patsubst $(BIN_DIR)/%.c, $(BUILD_DIR)/%.elf, $(APP_SOURCES))

# Default make target
all: $(APP_ELFS)

# Compile and link apps to ELF
$(BUILD_DIR)/%.elf: $(BIN_DIR)/%.c $(LIB_SOURCES)
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -T $(LINKER_SCRIPT) $< $(LIB_SOURCES) -o $@

# Build binary from ELF
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf
	$(OBJCOPY) -O binary $< $@

# Clean build files
clean:
	rm -rf $(BUILD_DIR)/*

# Define BIN targets based on APP_ELFS targets
APP_BINS = $(patsubst $(BUILD_DIR)/%.elf, $(BUILD_DIR)/%.bin, $(APP_ELFS))

# Make bin rule
bin: $(APP_BINS)

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf
	$(OBJCOPY) -O binary $< $@


.PHONY: all clean

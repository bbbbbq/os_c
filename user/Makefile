# Compiler and linker configurations
CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy

# Source and build directories
SRC_DIR = .
BIN_DIR = $(SRC_DIR)/bin
LIB_DIRS = $(SRC_DIR)/lib/console -I$(SRC_DIR)/lib/debug -I$(SRC_DIR)/lib/string \
            -I$(SRC_DIR)/lib/syscall -I$(SRC_DIR)/user_lib

BUILD_DIR = build

# Compilation flags
CFLAGS = -march=rv64gc -mabi=lp64d -nostdlib -mcmodel=medany -g -I$(LIB_DIR)

# Linker script
LINKER_SCRIPT = $(SRC_DIR)/linker.ld

# Find source files
APP_SOURCES = $(wildcard $(BIN_DIR)/*.c)
LIB_SOURCES = $(wildcard $(LIB_DIR)/*.c) $(wildcard $(LIB_DIR)/debug/*.c) $(wildcard $(LIB_DIR)/string/*.c) \
			  $(wildcard $(LIB_DIR)/syscall/*.c) $(wildcard $(LIB_DIR)/console/*.c) 
ALL_SOURCES = $(APP_SOURCES) $(LIB_SOURCES)

# Define targets
APP_TARGETS = $(patsubst $(BIN_DIR)/%.c, $(BUILD_DIR)/%, $(APP_SOURCES))
APP_BINS = $(patsubst $(BIN_DIR)/%.c, $(BUILD_DIR)/%.bin, $(APP_SOURCES))

# Default make target
all: $(APP_BINS)

# Build binary from ELF
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%
	$(OBJCOPY) -O binary $< $@

# Compile and link apps to ELF
$(BUILD_DIR)/%: $(BIN_DIR)/%.c $(LIB_SOURCES)
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -T $(LINKER_SCRIPT) $^ -o $@

# Clean build files
clean:
	rm -rf $(BUILD_DIR)/*

.PHONY: all clean

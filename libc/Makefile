CC = riscv64-unknown-elf-gcc
AR = ar
CFLAGS = -Wall -O2 -nostdlib

# Directories
SRC_DIRS = assert list stdlib string \
		   stdarg stdint stdio syscall 
BUILD_DIR = build
LIBRARY = $(BUILD_DIR)/libc.a

# Find all source files
SRCS = $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o)
DEPS = $(OBJS:.o=.d)

# Include directories
INCLUDE_DIRS = $(addprefix -I,$(SRC_DIRS))

# Compilation and linking flags
CFLAGS += $(INCLUDE_DIRS) -MMD -MP

# Default make target
all: $(LIBRARY)

# Static library creation
$(LIBRARY): $(OBJS)
	@mkdir -p $(@D)
	$(AR) rcs $@ $(OBJS)

# Compile C source files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

# Include dependencies
-include $(DEPS)

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean

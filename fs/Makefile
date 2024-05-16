# Compiler and flags
CC = gcc
CFLAGS = -Wall -g
FS_DIR = .
# Source directories

# Object directories
OBJ_DIR = build
INCLUDE_DIRS = -I$(FS_DIR)/driver -I$(FS_DIR)/fs_globle -I$(FS_DIR)

C_SOURCES = $(shell find $(FS_DIR)/ -name "*.c")
# Sources and objects
OBJECTS = $(C_SOURCES:%.c=$(OBJ_DIR)/%.o)
# Executable
EXEC = myfs

# Build rules
all: $(EXEC)

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) $^ -o $@

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(EXEC)

# Run rule dependent on the executable
run: $(EXEC)
	./$(EXEC)

# Debug rule, generating executable with debugging info
debug: $(EXEC)

.PHONY: all clean run debug
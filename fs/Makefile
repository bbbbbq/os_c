# Compiler and flags
CC = gcc
CFLAGS = -Wall -g

# Source directories
SRC_BLOCK_CACHE = block_cache
SRC_DRIVER = dirver
SRC_FS_GLOBLE = fs_globle

# Object directories
OBJ_DIR = obj

# Sources and objects
SOURCES_DRIVER = $(wildcard $(SRC_DRIVER)/*.c)
SOURCES_FS_GLOBLE = $(wildcard $(SRC_FS_GLOBLE)/*.c)
SOURCES_MAIN = main.c

OBJECTS = $(SOURCES_DRIVER:.c=.o) $(SOURCES_FS_GLOBLE:.c=.o) $(SOURCES_MAIN:.c=.o)

# Include directories
INCLUDES = -I$(SRC_DRIVER) -I$(SRC_FS_GLOBLE)

# Executable
EXEC = myfs

# Build rules
all: $(EXEC)

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(EXEC)

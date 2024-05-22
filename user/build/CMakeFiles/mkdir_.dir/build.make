# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/caigoubencai/Desktop/os_c-ch6/user

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/caigoubencai/Desktop/os_c-ch6/user/build

# Include any dependencies generated for this target.
include CMakeFiles/mkdir_.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/mkdir_.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/mkdir_.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mkdir_.dir/flags.make

CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o: CMakeFiles/mkdir_.dir/flags.make
CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o: ../src/oscomp/mkdir_.c
CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o: CMakeFiles/mkdir_.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/caigoubencai/Desktop/os_c-ch6/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o -MF CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o.d -o CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o -c /home/caigoubencai/Desktop/os_c-ch6/user/src/oscomp/mkdir_.c

CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.i"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/caigoubencai/Desktop/os_c-ch6/user/src/oscomp/mkdir_.c > CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.i

CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.s"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/caigoubencai/Desktop/os_c-ch6/user/src/oscomp/mkdir_.c -o CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.s

# Object files for target mkdir_
mkdir__OBJECTS = \
"CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o"

# External object files for target mkdir_
mkdir__EXTERNAL_OBJECTS =

riscv64/mkdir_: CMakeFiles/mkdir_.dir/src/oscomp/mkdir_.c.o
riscv64/mkdir_: CMakeFiles/mkdir_.dir/build.make
riscv64/mkdir_: libulib.a
riscv64/mkdir_: CMakeFiles/mkdir_.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/caigoubencai/Desktop/os_c-ch6/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/mkdir_"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mkdir_.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-unknown-elf-objdump -d -S /home/caigoubencai/Desktop/os_c-ch6/user/build/riscv64/mkdir_ > asm/mkdir_.asm
	mkdir -p bin
	riscv64-unknown-elf-objcopy -O binary /home/caigoubencai/Desktop/os_c-ch6/user/build/riscv64/mkdir_ bin/mkdir_.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/mkdir_.dir/build: riscv64/mkdir_
.PHONY : CMakeFiles/mkdir_.dir/build

CMakeFiles/mkdir_.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mkdir_.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mkdir_.dir/clean

CMakeFiles/mkdir_.dir/depend:
	cd /home/caigoubencai/Desktop/os_c-ch6/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/caigoubencai/Desktop/os_c-ch6/user /home/caigoubencai/Desktop/os_c-ch6/user /home/caigoubencai/Desktop/os_c-ch6/user/build /home/caigoubencai/Desktop/os_c-ch6/user/build /home/caigoubencai/Desktop/os_c-ch6/user/build/CMakeFiles/mkdir_.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/mkdir_.dir/depend


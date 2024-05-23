import os

def list_elf_files(directory, output_file):
    # Ensure the directory exists
    if not os.path.exists(directory):
        print(f"Error: The directory '{directory}' does not exist.")
        return
    
    # Ensure the path is indeed a directory
    if not os.path.isdir(directory):
        print(f"Error: The path '{directory}' is not a directory.")
        return

    # Prepare to list files
    elf_files = []

    # Only list files directly in the given directory, not subdirectories
    for filename in os.listdir(directory):
        filepath = os.path.join(directory, filename)
        if os.path.isfile(filepath):
            # Open the file to read binary data
            with open(filepath, 'rb') as file:
                # Read the first four bytes of the file
                magic = file.read(4)
                # Check if the file is an ELF file
                if magic == b'\x7fELF':
                    elf_files.append(filename)
    
    # Write identified ELF files to the output file
    if elf_files:
        with open(output_file, 'w') as file:
            for elf_file in elf_files:
                file.write(f"{elf_file}\n")
    else:
        print("No ELF files found.")

# Example usage
directory_path = '../user/riscv64'
output_file_path = 'output.txt'

# List ELF files in the directory and write to output file
list_elf_files(directory_path, output_file_path)

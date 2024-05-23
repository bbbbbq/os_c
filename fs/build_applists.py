import os
import subprocess

def list_files_without_extension(directory, output_file):
    # Ensure the directory exists
    if not os.path.exists(directory):
        print(f"Error: The directory '{directory}' does not exist.")
        return
    
    # Ensure the path is indeed a directory
    if not os.path.isdir(directory):
        print(f"Error: The path '{directory}' is not a directory.")
        return
    
    # Open the output file for writing
    with open(output_file, 'w') as file:
        # Walk through the directory
        for dirpath, dirnames, filenames in os.walk(directory):
            # Filter and write each filename that has no extension to the output file
            for filename in filenames:
                name, ext = os.path.splitext(filename)
                if ext == "":
                    file.write(f"{filename}\n")

def execute_commands_from_file(output_file_path, executable='./myfs', directory_path=''):
    try:
        # Open the output file and read lines
        with open(output_file_path, 'r') as file:
            file_names = file.readlines()
        
        # Loop through each file name and execute the corresponding command
        for file_name in file_names:
            file_name = file_name.strip()  # Remove any trailing whitespace/newlines
            full_path = os.path.join(directory_path, file_name)  # Construct full path
            # Adjust command to use full path for the first parameter and only filename for the second
            command = [executable, full_path, file_name]
            print(f"Executing command: {' '.join(command)}")
            result = subprocess.run(command, capture_output=True, text=True)
            print(f"Output:\n{result.stdout}")
            if result.stderr:
                print(f"Errors:\n{result.stderr}")
    
    except FileNotFoundError:
        print(f"Error: The file '{output_file_path}' does not exist.")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

# Example usage
directory_path = '../user/riscv64'
output_file_path = 'output.txt'
executable_path = './myfs'

# List files without extension and write to output file
list_files_without_extension(directory_path, output_file_path)

# Execute commands based on the listed file names
execute_commands_from_file(output_file_path, executable_path, directory_path)

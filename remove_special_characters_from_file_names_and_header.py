import os
import re

path = r"C:\Users\Zak..\Downloads\"
invalid_chars = r"[_\s-]"

# Get all files in the specified directory
files = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))]

# Loop through each file
for file in files:
    current_name = file
    # Replace invalid characters with an empty string
    new_name = re.sub(invalid_chars, "", current_name)
    # Rename the file if the new name is different from the current name
    if new_name != current_name:
        os.rename(os.path.join(path, current_name), os.path.join(path, new_name))
    # Read the first line of the file
    with open(os.path.join(path, new_name), 'r') as f:
        first_line = f.readline()
    # Replace invalid characters with an empty string
    new_line = re.sub(invalid_chars, "", first_line)
    # Write the new first line to the file
    with open(os.path.join(path, new_name), 'r') as f:
        lines = f.readlines()
    lines[0] = new_line
    with open(os.path.join(path, new_name), 'w') as f:
        f.writelines(lines)

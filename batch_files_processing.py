import os
import time
import pandas as pd


def read_text_file(filename,utf_type='utf-16'):
    """Reads a text file and returns its contents."""
    with open(filename, 'rb') as file:
        text = file.read().decode(utf_type, 'ignore')
        print('Reading file -', os.path.basename(filename))
    return text

def replace_occurrences(text, old_str, new_str):
    """Replaces all occurrences of old_str with new_str in the given text."""
    return text.replace(old_str, new_str)

def write_text_file(filename, text,utf_type='utf-8'):
    """Writes the given text to a file."""
    with open(filename, 'wb') as file:
        file.write(text.encode(utf_type, 'ignore'))
        time.sleep(1)

def remove_file(file_path):
    """Removes a file from the file system."""
    try:
        os.remove(file_path)
        print(f"{file_path} has been removed successfully.")
    except OSError:
        print(f"Error occurred while deleting {file_path}")

def rename_file(old_filename, new_filename):
    """
    Renames a file from old_filename to new_filename.
    """
    time.sleep(1)
    os.rename(old_filename, new_filename)
    print('done-',os.path.basename(new_filename))

def process_file(source_path, destination_path):
    """Reads a CSV file from the source path, processes it, and writes it to the destination path."""
    df = pd.read_csv(source_path, dtype=object)  
    print(f'Done - {os.path.basename(source_path)}')
    df.to_csv(destination_path, sep='|', index=False, quoting=1) 
        
    

# Entry point    

input_directory = r'C:\Users\ZakariaH\Desktop\input'
output_directory = r'C:\Users\ZakariaH\Desktop\output'  
destination_directory = r'C:\Users\ZakariaH\Desktop\Final'    
for filename in os.listdir(input_directory):
    if filename.endswith('.txt'):
        input_path = os.path.join(input_directory, filename)
        output_path = os.path.join(output_directory, filename)
        destination_path = os.path.join(destination_directory, filename)  
            
        text = read_text_file(input_path)

        # replace all occurrences of \" with '
        text = replace_occurrences(text, '\\"', "\'")

        # write the modified text back to the file
        #new_filename = input_path.split('.')[0] + '2.' +'csv'
        new_filename = output_path
        write_text_file(new_filename, text)
        
        #rename_file(new_filename, input_path)
        
        process_file(new_filename, destination_path)
        
        remove_file(new_filename)

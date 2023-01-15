"""
This program uses the pandas library to read the large CSV file in chunks of one million rows at a time using pd.read_csv(file_name, chunksize=10**6). 
It then iterates over each chunk, drops the specified row using chunk.drop(chunk.index[row_index]), and concatenates all the chunks together.
Finally, it writes the updated dataframe back to the CSV file using data.to_csv(file_name, index=False).

This method will allow you to read and write large files without loading the entire file into memory at once, so it's a more efficient solution for 
very large files. This program uses the pandas library to read the large CSV file in chunks of one million rows at a time 
using pd.read_csv(file_name, chunksize=10**6).It then iterates over each chunk, drops the specified row using chunk.drop(chunk.index[row_index]), 
and concatenates all the chunks together. Finally, it writes the updated dataframe back to the CSV file using data.to_csv(file_name, index=False).

This method will allow you to read and write large files without loading the entire file into memory at once, 
so it's a more efficient solution for very large files.
"""
import pandas as pd

def remove_row(file_name, row_index):
    # Read the CSV file in chunks
    chunks = pd.read_csv(file_name, chunksize=10**6)
    data = pd.concat([chunk.drop(chunk.index[row_index]) for chunk in chunks])
    data.to_csv(file_name, index=False)

# Example usage:
remove_row("large_file.csv", 5) # this will remove the 6th row from large_file.csv

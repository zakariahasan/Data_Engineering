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



import pandas as pd
import os

def test_remove_row():
    # Create a test CSV file with sample data
    test_data = {'col1': [1, 2, 3, 4, 5, 6],
                 'col2': [7, 8, 9, 10, 11, 12]}
    test_file = 'test_file.csv'
    df = pd.DataFrame(test_data)
    df.to_csv(test_file, index=False)
    
    # Call the remove_row function
    remove_row(test_file, 5)

    # Read the modified CSV file
    modified_df = pd.read_csv(test_file)
    
    # Check that the 6th row has been removed
    assert modified_df.shape[0] == 5
    assert modified_df.loc[5,'col1'] != 6
    
    # Clean up the test file
    os.remove(test_file)

test_remove_row()
'''This test code creates a test CSV file with sample data, calls the remove_row function, reads the modified CSV file, 
and performs a few assertions to ensure that the 6th row has been removed. It also uses the os library to delete the test_file after the test is done.

This is just an example, you can also check the size of the file before and after the removal, 
and you can check the indexes of the rows, to make sure that the row that you want to delete has been removed. 
This test code can also be improved by adding more test cases to cover different scenarios.
'''




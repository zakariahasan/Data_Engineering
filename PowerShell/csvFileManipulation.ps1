# Removing header from CSV file
Get-Content Your_File.csv | select -Skip 1 | Set-Content Your_FileBis.csv
# or
Your_Data_In_Pipe | ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Set-Content File_Without_Headers.csv

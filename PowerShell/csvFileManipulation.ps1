# Removing header from CSV file
Get-Content Your_File.csv | select -Skip 1 | Set-Content Your_FileBis.csv

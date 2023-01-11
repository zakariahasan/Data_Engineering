# A PowerShell script to find a specific file extension from subdirectories and copy the files to a different directory with an incremental number to the files
$FileExtension = "*.config" # Define the file extension to search for
$Root = "C:\root Folder" # Define the root folder to start the search from
$Destination = "C:\destination folder" # Define the destination folder

#Search for the files with the specified extension in all the subfolders of the root folder
$Files = Get-ChildItem -Path $Root -Recurse -Include $FileExtension -File
$counter = 1 # Initialize a counter for the incremental numbering

# Loop through each file and copy it to the destination folder
foreach ($File in $Files) {
    #$NewFileName = $counter + "-" + $File.Name
    $NewFileName = "{0}-{1}" -f $counter , $File.Name
    $counter++
    Copy-Item -Path $File.FullName -Destination "$Destination$NewFileName"
    }

# Display a message to confirm the completion of the copy process
Write-Host "Files have been copied successfully to the destination folder with incremental numbering."

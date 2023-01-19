$path = "C:\Users\Zak..\Downloads\"
$invalidChars = "[_\s-]"

# Get all files in the specified directory
$files = Get-ChildItem -Path $path -File

# Loop through each file
foreach($file in $files) {
    # Get the current file name
    $currentName = $file.Name
    # Replace invalid characters with an empty string
    $newName = $currentName -replace $invalidChars, ""
    # Rename the file if the new name is different from the current name
    if($newName -ne $currentName) {
        Rename-Item -Path "$path\$currentName" -NewName $newName
    }
    # Read the first line of the file
    $firstLine = (Get-Content $file.FullName)[0]
    # Replace invalid characters with an empty string
    $newLine = $firstLine -replace $invalidChars, ""
    # Write the new first line to the file
    (Get-Content $file.FullName) | Foreach-Object {
        if ($_ -eq $firstLine) {
            $newLine
        } else {
            $_
        }
    } | Set-Content $file.FullName
}

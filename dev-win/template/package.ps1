# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files and folders
Get-ChildItem -Path $PWD -Exclude 'package.ps1' | Remove-Item -Recurse -Force

# Copy template files
Copy-Item -Path '..\..\config\templates\overrides' -Destination $PWD -Recurse

# Compress template files
Compress-Archive -Path '.\overrides' -DestinationPath '.\template.zip' -Force

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

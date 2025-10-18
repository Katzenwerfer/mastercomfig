# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files and folders
Remove-Item -Path '.\overrides' -Recurse -Force -ErrorAction 'SilentlyContinue'

# Copy template files
Copy-Item -Path '..\..\config\templates\overrides' -Destination $PWD -Recurse

# Compress template files
Compress-Archive -Path '.\overrides' -DestinationPath '.\template.zip' -Force

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files and folders
Get-ChildItem -Path $PWD -Exclude 'package.ps1' | Remove-Item -Recurse -Force

# Process config addons
Get-ChildItem -Path '..\..\config\cfg\addons' -File | ForEach-Object {
    if ($PSItem.Extension -eq '.cfg') {
        New-Item -Path ".\mastercomfig-addon-$($PSItem.BaseName)\cfg" -Name 'addons' -ItemType 'Directory' -Force | Out-Null
        Copy-Item -Path $PSItem -Destination ".\mastercomfig-addon-$($PSItem.BaseName)\cfg\addons" -Force
    }
}

# Copy over custom addons
Copy-Item -Path '..\..\config\addons\*' -Destination $PWD -Force -Recurse

# Import common functions and cleanup various files in the directory
. '..\common.ps1'
cleanAndPackage

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

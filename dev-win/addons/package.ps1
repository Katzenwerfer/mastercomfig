# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files and folders
Remove-Item -Path '.\*.vpk' -Force
Get-ChildItem -Path $PWD -Directory | Remove-Item -Recurse -Force

# Process config addons
Get-ChildItem -Path '..\..\config\cfg\addons\*' -File | ForEach-Object {
    if ($PSItem.Extension.TrimStart('.') -eq 'cfg') {
        New-Item -Path ".\mastercomfig-addon-$($PSItem.BaseName)\cfg\addons" -ItemType 'Directory' -Force | Out-Null
        Copy-Item -Path $PSItem.FullName -Destination ".\mastercomfig-addon-$($PSItem.BaseName)\cfg\addons\$($PSItem.Name)" -Force
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

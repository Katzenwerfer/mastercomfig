# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old VPKs and folders
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

. '..\common.ps1'

cleanAndPackage

Write-Host

Pop-Location

$ErrorActionPreference = 'Stop'

# Run script within the directory
Push-Location -Path $PSScriptRoot

# Execute package scripts
Get-ChildItem -Path $PWD -Directory | ForEach-Object {
    if ($PSItem.Name -ne '__pycache__') {
        Write-Host -Object "Packaging $($PSItem.Name)"
        & (Join-Path -Path $PSItem.FullName -ChildPath 'package.ps1')
    }
}

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files
Get-ChildItem -Path $PWD -Exclude 'package.ps1' | Remove-Item -Force

# Copy comfig.cfg as autoexec_template.cfg
Copy-Item -Path '..\..\config\mastercomfig\cfg\comfig\comfig.cfg' -Destination '.\autoexec_template.cfg' -Force

# Remove all lines starting with 'echo'
# Remove all lines starting with 'alias'
# Remove all lines starting with 'block_game_overrides_once'
# Comment all uncommented cvars
# Remove trailing multiple newlines and output with LF line breaks
((Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    -not $PSItem.StartsWith('echo')
} | Where-Object {
    -not $PSItem.StartsWith('alias')
} | Where-Object {
    -not $PSItem.StartsWith('block_game_overrides_once')
} | ForEach-Object {
    $PSItem -replace '^(\w+.+)', '//$1'
}) -join "`n" -replace '\n\n+', "`n`n" -replace '\n\n$', "`n" | Set-Content -Path '.\autoexec_template.cfg' -NoNewline

# Copy config_template.cfg as autoexec.cfg
Copy-Item -Path '..\..\config\templates\config\config_template.cfg' -Destination '.\autoexec.cfg' -Force

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

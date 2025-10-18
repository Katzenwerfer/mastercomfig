# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files
Get-ChildItem -Path $PWD -Exclude 'package.ps1' | Remove-Item -Force

# Copy comfig.cfg as autoexec_template.cfg
Copy-Item -Path '..\..\config\mastercomfig\cfg\comfig\comfig.cfg' -Destination '.\autoexec_template.cfg' -Force

# Remove all lines starting with 'echo'
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^echo'
} | Set-Content '.\autoexec_template.cfg'

# Remove all lines starting with 'alias'
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^alias'
} | Set-Content '.\autoexec_template.cfg'

# Remove all lines starting with 'block_game_overrides_once'
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^block_game_overrides_once'
} | Set-Content -Path '.\autoexec_template.cfg'

# Comment all uncommented cvars
(Get-Content -Path '.\autoexec_template.cfg') | ForEach-Object {
    $PSItem -replace '^([^\t +/].*)', '//$1'
} | Set-Content -Path '.\autoexec_template.cfg'

# Remove trailing multiple newlines and output with LF line breaks
(Get-Content -Path '.\autoexec_template.cfg') -join "`n" -replace '\n\n+', "`n`n" | Set-Content -Path '.\autoexec_template.cfg' -NoNewline

# Copy config_template.cfg as autoexec.cfg
Copy-Item -Path '..\..\config\templates\config\config_template.cfg' -Destination '.\autoexec.cfg' -Force

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

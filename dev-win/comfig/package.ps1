# Run script within the directory
Push-Location -Path $PSScriptRoot

Remove-Item -Path '.\*.cfg' -Recurse -Force

Copy-Item -Path '..\..\config\mastercomfig\cfg\comfig\comfig.cfg' -Destination '.\autoexec_template.cfg' -Force
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^echo'
} | Set-Content '.\autoexec_template.cfg'
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^alias'
} | Set-Content '.\autoexec_template.cfg'
(Get-Content -Path '.\autoexec_template.cfg') | Where-Object {
    $PSItem -notmatch '^block_game_overrides_once'
} | Set-Content -Path '.\autoexec_template.cfg'
(Get-Content -Path '.\autoexec_template.cfg') | ForEach-Object {
    $PSItem -replace '^([^\t +/].*)', '//$1'
} | Set-Content -Path '.\autoexec_template.cfg'
(Get-Content -Path '.\autoexec_template.cfg') -join "`n" -replace '\n\n+', "`n`n" | Set-Content -Path '.\autoexec_template.cfg' -NoNewline
Copy-Item -Path '..\..\config\templates\config\config_template.cfg' -Destination '.\autoexec.cfg' -Force

Write-Host

Pop-Location

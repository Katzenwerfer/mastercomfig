# Run script within the directory
Push-Location -Path $PSScriptRoot

# Delete old files and folders
Get-ChildItem -Path $PWD -Exclude 'package.ps1', 'mastercomfig-base_backup' | Remove-Item -Recurse -Force

# Copy over preset files
New-Item -Path '.\mastercomfig-base\cfg\presets' -ItemType 'Directory' -Force | Out-Null
Get-ChildItem -Path '..\..\config\cfg\presets' | Copy-Item -Destination '.\mastercomfig-base\cfg\presets' -Force

# Generate autoexec.cfg
@(
    'exec comfig/define_presets.cfg;'
    'exec app/pre_init.cfg;exec overrides/pre_init.cfg;'
    'exec comfig/comfig.cfg;'
    'exec app/setup_hook.cfg;exec overrides/setup_hook.cfg;'
    'preset;'
    'modules_c;'
    'run_modules;'
    'exec comfig/echo.cfg;'
    'exec app/addons.cfg;'
    'exec overrides/autoexec.cfg;exec app/autoexec.cfg;'
    'exec comfig/finalize.cfg'
) | Set-Content -Path '.\mastercomfig-base\cfg\autoexec.cfg' -NoNewline

# Fill folders with common files
Get-ChildItem -Path '..\..\config\mastercomfig' | Copy-Item -Destination '.\mastercomfig-base' -Force -Recurse

# Import common functions and cleanup various files in the directory
. '..\common.ps1'
cleanAndPackage

# Write a newline to the console
Write-Host

# Exit the script directory
Pop-Location

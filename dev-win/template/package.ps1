# Run script within the directory
Push-Location -Path $PSScriptRoot

Remove-Item -Path '.\overrides' -Recurse -Force -ErrorAction 'SilentlyContinue'
Copy-Item -Path '..\..\config\templates\overrides' -Destination $PWD -Recurse

Compress-Archive -Path '.\overrides' -DestinationPath '.\template.zip' -Force

Write-Host

Pop-Location

# The code from the Bash script was unintengible, so I had to remake it from scratch from the.
# Internal behavoiour won't match one-to-one, but the results should be more or less the same.

param($inputFile)

(Get-Content -Path $inputFile) | ForEach-Object {
    $PSItem -replace '"([\w-./]+?)"', '$1'
} | Set-Content -Path $inputFile

(Get-Content -Path $inputFile) -join ' ' | Set-Content -Path $inputFile -NoNewline

(Get-Content -Path $inputFile) -replace '[\t ]+', ' ' | Set-Content -Path $inputFile -NoNewline

(Get-Content -Path $inputFile) -replace ' ?(["{}]) ?', '$1' | Set-Content -Path $inputFile -NoNewline

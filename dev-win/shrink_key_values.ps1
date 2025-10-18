# The code from the Bash script was unintengible, so I had to remake it from scratch from the.
# Internal behavoiour won't match one-to-one, but the results should be more or less the same.

param($inputFile)

# Remove quotes from VDF key values except empty quotes or spaced strings
(Get-Content -Path $inputFile) | ForEach-Object {
    $PSItem -replace '"([\w-./]+?)"', '$1'
} | Set-Content -Path $inputFile

# Normalize spacing between symbols in VDFs
(Get-Content -Path $inputFile) -join ' ' | Set-Content -Path $inputFile -NoNewline

# Remove all newlines in VDFs
(Get-Content -Path $inputFile) -replace '[\t ]+', ' ' | Set-Content -Path $inputFile -NoNewline

# Normalize spacing around double quotes and brackets in VDFs
(Get-Content -Path $inputFile) -replace ' ?(["{}]) ?', '$1' | Set-Content -Path $inputFile -NoNewline

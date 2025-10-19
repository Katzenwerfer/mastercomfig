function cleanItems {
    if ($env:zip_package -ne $true) {
        # Remove all comments
        # Trim leading whitespace
        # Remove all in-line comments
        Get-ChildItem -Path $PWD -Include '*.cfg', '*.txt', '*.res', '*.nut' -Recurse | ForEach-Object {
            (Get-Content -Path $PSItem) | Where-Object {
                -not $PSItem.TrimStart().StartsWith('//')
            } | Where-Object {
                $PSItem -match '\S'
            } | ForEach-Object {
                $PSItem -replace ' //.*', ''
            } | Set-Content -Path $PSItem
        }

        # Remove all newlines in VDFs
        Get-ChildItem -Path $PWD -Include 'mtp.cfg', 'dxsupport*.cfg', '*.txt', '*.res', '*.nut' -Exclude 'texture_preload_list.txt' -Recurse | ForEach-Object {
            (Get-Content -Path $PSItem) -join ' ' | Set-Content -Path $PSItem
        }

        # Remove quotes from VDF key values except empty quotes or spaced strings
        # Normalize spacing between symbols in VDFs
        # Normalize spacing around double quotes, semicolons, and brackets in VDFs
        Get-ChildItem -Path $PWD -Include 'mtp.cfg', 'dxsupport*.cfg', '*.txt', '*.res' -Exclude 'texture_preload_list.txt' -Recurse | ForEach-Object {
            (Get-Content -Path $PSItem) | ForEach-Object {
                $PSItem -replace '"([\w-./]+?)"', '$1' -replace '[\t ]+', ' ' -replace ' ?([";{}]) ?', '$1'
            } | Set-Content -Path $PSItem
        }

        # Convert CRLF to LF line breaks in all files
        # Remove trailing multiple final newlines in all files
        Get-ChildItem -Path $PWD -Include '*.cfg', '*.txt', '*.res', '*.nut' -Recurse | ForEach-Object {
            (Get-Content -Path $PSItem -Raw) -replace '\r', '' -replace '\n\n+$', "`n" | Set-Content -Path $PSItem -NoNewline
        }
    }
}

function packageItems {
    if ($env:zip_package -ne $true) {
        # Package into VPK
        Get-ChildItem -Path $PWD -Directory | ForEach-Object {
            & vpkeditcli.exe --single-file $PSItem | Out-Null
        }
    }
}

function cleanAndPackage {
    cleanItems
    packageItems
}

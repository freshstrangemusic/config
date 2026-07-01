# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

$ErrorActionPreference = "Stop"

$configCheckout = Get-Location | Select-Object -ExpandProperty Path
$homeDirectory = (Resolve-Path ~)

Function Install-DotFiles {
    param($layer)

    $layerPath = "$configCheckout\dotfiles\layers\$layer"
    $dotfilePaths = Get-ChildItem -File -Recurse "$layerPath"

    foreach ($linkTarget in $dotfilePaths) {
        $fileName = Split-Path -Leaf -Path $linkTarget

        if ($fileName -eq ".stow-local-ignore") {
            continue
        }

        $relativePath = Resolve-Path -Relative -RelativeBasePath $layerPath -Path $linkTarget

        if ($relativePath.StartsWith(".\")) {
            $relativePath = $relativePath.Substring(2)
        }

        $linkPath = Join-Path $homeDirectory $relativePath
        $parentPath = Split-Path -Parent -Path $linkPath

        if (Test-Path $linkPath) {
            $f = Get-ChildItem $linkPath

            if ($f.LinkType -ne "SymbolicLink") {
                Write-Host -ForegroundColor Red "$linkPath is not a link"
            } elseif ($f.LinkTarget -ne $linkTarget) {
                Write-Host -ForegroundColor Red "$linkPath points to wrong file"
            } else {
                Write-Host -ForegroundColor Gray $linkPath
            }

            continue
        } elseif (Test-Path $parentPath) {
            if (! (Test-Path -PathType Container $parentPath)) {
                Write-Host -ForegroundColor Red "$parentPath is not a directory"
                continue
            }
        } else {
            New-Item -ItemType Directory `
                     -Path $parentPath >$null
        }

        New-Item -ItemType SymbolicLink `
                 -Value $linkTarget `
                 -Path $linkPath >$null

        Write-Host -ForegroundColor Green $linkPath
    }
}

Install-DotFiles "base"
Install-DotFiles "windows"

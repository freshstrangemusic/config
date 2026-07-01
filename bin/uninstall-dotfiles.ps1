# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

$ErrorActionPreference = "Stop"

$configCheckout = Get-Location | Select-Object -ExpandProperty Path
$homeDirectory = (Resolve-Path ~)

Function Uninstall-DotFiles {
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

        if (! (Test-Path $linkPath)) {
            continue
        }

        $f = Get-ChildItem $linkPath

        if ($f.LinkType -ne "SymbolicLink") {
            Write-Host -ForegroundColor Red "$linkPath is not a link"
            continue
        }

        if ($f.LinkTarget -ne $linkTarget) {
            Write-Host -ForegroundColor Red "$linkPath points to wrong file"
            continue
        }

        Remove-Item -Path $linkPath

        Write-Host -ForegroundColor Green $linkPath
    }
}

Uninstall-Dotfiles "windows"
Uninstall-Dotfiles "base"

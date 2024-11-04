function Get-ShortCWD() {
    $pathAsString = ([string] $executionContext.SessionState.Path.CurrentLocation)

    if ($pathAsString.StartsWith($HOME)) {
        if ($pathAsString.Length -eq $HOME.Length) {
            return "~"
        }

        $components = @("~")
        $restPath = $pathAsString.Substring($HOME.Length + 1)
    } else {
        $components = @($pathASString.Substring(0, 2))
        $restPath = $pathAsString.Substring(3) # Skip the prefix AND the trailing slash
    }

    $components += $restPath.split("\")

    if ($components.Length -gt 2) {
        foreach ($i in 1..($components.Length - 2)) {
            $components[$i] = $components[$i][0]
        }
    }

    $components -join "\"
}

function prompt() {
    $lastCmdSuccess = $global:?
    $statusCode = $global:LASTEXITCODE

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    if ($principal.IsInRole($adminRole)) {
        $sigil = "#"
        $prefixColour = "red"
    } else {
        $sigil = "$"
        $prefixColour = "green"
    }

    $hostname, $username = $identity.Name.split("\")

    Write-Host -NoNewline -ForegroundColor $prefixColour $username
    Write-Host -NoNewline "@"
    Write-Host -NoNewline -ForegroundColor $prefixColour $hostname
    Write-Host -NoNewline " "
    Write-Host -NoNewline -ForegroundColor blue (Get-ShortCWD)
    Write-Host -NoNewline " "

    if (!$lastCmdSuccess) {
        if ($null -eq $statusCode) {
            $statusCode = "!"
        }

        Write-Host -NoNewline -ForegroundColor red "[$statusCode] "
    }


    Write-Host -NoNewline $sigil

    " "
}

Set-Alias -Name ls -Value lsd

Set-PSReadLineOption -EditMode Emacs -BellStyle None
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardDeleteWord
Set-PSReadlineKeyHandler -Key Alt+e `
                         -BriefDescription EditCommand `
                         -LongDescription "Edit current command in editor" `
                         -ScriptBlock {
    $line = $null
    $cursor = $null

    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref] $line, [ref] $cursor)

    $temp = New-TemporaryFile
    Write-Output $line > $temp

    Start-Process -Wait -NoNewWindow $env:EDITOR -ArgumentList $temp
    $status = $global:?

    if (($status -eq $null) -or ($status -eq 0) -or ($status -eq $true)) {
        $newLine = Get-Content $temp

        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $newLine)
    }

    Remove-Item $temp.Name
}

$env:EDITOR = "vim"

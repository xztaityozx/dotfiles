
# PowerLine setting
Import-Module ((ghq root)+"\github.com\xztaityozx\PowerShell-Dotfiles\Get-PowerLinePath.ps1")
Import-Module posh-git
Import-Module oh-my-posh

# kye-bind
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs -BellStyle None
Set-PSReadLineKeyHandler -Chord Ctrl+D -ScriptBlock { [System.Environment]::Exit(0) }

# environment
$env:NVIM_CONFIG_DIR="C:\Users\xztaityozx\.ghq\github.com\xztaityozx\dotfiles\config\nvim\"
$env:PYTHON2_HOST_PROG="C:\Python27\python.exe"

# theme
Set-Theme Craft

# sudo
function Pause {
    if ($psISE) {
        $null = Read-Host 'Press Enter Key...'
    }
    else {
        Write-Host "Press Any Key..."
        (Get-Host).UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
}

function Invoke-CommandRunAs {
    $cd=(Get-Location).Path
    $commands="Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; Pause; exit"
    $bytes=[System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand=[System.Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias sudo Invoke-CommandRunAs

function Start-RunAs {
    $cd=(Get-Location).Path
    $commands="Set-Location $cd; (Get-Host).UI.RawUI.WindowTitle+=`" [Administrator] `""
    $bytes=[System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand=[System.Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias su Start-RunAs

function hac {
    param (
        [string]$message
    )
    
    hub add -A
    hub commit -m $message
}

Set-Alias hps "hub push"
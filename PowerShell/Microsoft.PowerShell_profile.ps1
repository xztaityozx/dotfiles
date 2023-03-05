# kye-bind
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs -BellStyle None
Set-PSReadLineKeyHandler -Chord Ctrl+D -ScriptBlock { [System.Environment]::Exit(0) }
Set-PSReadLineKeyHandler -Chord Ctrl+LeftArrow BackwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+RightArrow ForwardWord
Set-PsFzfOption -TabExpansion -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Chord Tab -ScriptBlock {Invoke-FzfTabCompletion}


# environment
$env:NVIM_CONFIG_DIR="C:\Users\xztaityozx\.ghq\github.com\xztaityozx\dotfiles\config\nvim\"

function global:prompt {
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "powerline-go"
    $startInfo.Arguments = "-shell bare -modules ssh,host,docker,cwd,git,jobs,exit,newline,user,root -cwd-max-depth 3 -cwd-max-dir-size -1 -hostname-only-if-ssh"
    $startInfo.Environment["TERM"] = "xterm-256color"
    $startInfo.CreateNoWindow = $true
    $startInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
    $startInfo.RedirectStandardOutput = $true
    $startInfo.UseShellExecute = $false
    $startInfo.WorkingDirectory = $pwd
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start() | Out-Null
    $standardOut = $process.StandardOutput.ReadToEnd()
    $process.WaitForExit()
    $standardOut
}

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

Set-Alias :e nvim


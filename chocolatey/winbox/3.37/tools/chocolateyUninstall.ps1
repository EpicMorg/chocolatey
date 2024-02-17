$startFolder = 'WinBox'
$processName32 = 'winbox'
$processName64 = 'winbox64'

Function RemoveStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) `
        -ChildPath $startFolder
    Remove-Item $startMenuFolderPath -Recurse -Force -Confirm:$FALSE -ErrorAction SilentlyContinue
}

# SCRIPT STARTS HERE #

Stop-Process -Name $processName32 -ErrorAction SilentlyContinue
Stop-Process -Name $processName64 -ErrorAction SilentlyContinue

RemoveStartMenuShortcut

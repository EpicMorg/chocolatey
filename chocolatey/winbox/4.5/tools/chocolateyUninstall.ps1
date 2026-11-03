$startFolder = 'WinBox'

Function RemoveStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) -ChildPath $startFolder
    Remove-Item $startMenuFolderPath -Recurse -Force -Confirm:$FALSE -ErrorAction SilentlyContinue
}

Stop-Process -Name "WinBox" -ErrorAction SilentlyContinue
Stop-Process -Name "winbox64" -ErrorAction SilentlyContinue

RemoveStartMenuShortcut
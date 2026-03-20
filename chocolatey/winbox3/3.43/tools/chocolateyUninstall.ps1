$startFolder = 'WinBox3'

Function RemoveStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) -ChildPath $startFolder
    Remove-Item $startMenuFolderPath -Recurse -Force -Confirm:$FALSE -ErrorAction SilentlyContinue
}

Stop-Process -Name 'winbox3' -ErrorAction SilentlyContinue
Stop-Process -Name 'winbox3-64' -ErrorAction SilentlyContinue

RemoveStartMenuShortcut
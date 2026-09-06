$startFolder = 'airtest-ide'

Function RemoveStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) -ChildPath $startFolder
    Remove-Item $startMenuFolderPath -Recurse -Force -Confirm:$FALSE -ErrorAction SilentlyContinue
}

RemoveStartMenuShortcut
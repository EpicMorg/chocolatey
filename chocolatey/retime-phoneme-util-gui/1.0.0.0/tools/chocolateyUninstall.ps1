$shortcut = Join-Path ([Environment]::GetFolderPath('CommonPrograms')) 'Retime Phoneme Util GUI.lnk'
Remove-Item -LiteralPath $shortcut -Force -ErrorAction SilentlyContinue

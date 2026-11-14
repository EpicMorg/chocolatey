$shortcut = Join-Path ([Environment]::GetFolderPath('Programs')) 'Hammer-MCP.lnk'
Remove-Item -LiteralPath $shortcut -Force -ErrorAction SilentlyContinue
# Settings in %APPDATA%\EpicMorg\Hammer-MCP are left in place.

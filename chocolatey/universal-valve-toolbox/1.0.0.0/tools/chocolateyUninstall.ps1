$shortcut = Join-Path ([Environment]::GetFolderPath('CommonPrograms')) 'Universal Valve Toolbox.lnk'
Remove-Item -LiteralPath $shortcut -Force -ErrorAction SilentlyContinue
# The copy of settings and projects in %ProgramData%\EpicMorg\UniversalValveToolbox is left in place.

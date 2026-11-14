# Stop the toolbox and save its settings and projects (json\ next to the exe): an upgrade or
# uninstall removes the package folder. chocolateyInstall.ps1 restores them.
Get-Process -Name 'UniversalValveToolbox' -ErrorAction SilentlyContinue | Stop-Process -Force

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$jsonDir = Get-ChildItem -LiteralPath $toolsDir -Recurse -Filter 'UniversalValveToolbox.exe' |
  Select-Object -First 1 | ForEach-Object { Join-Path $_.DirectoryName 'json' }
$backup = Join-Path $env:ProgramData 'EpicMorg\UniversalValveToolbox'
if ($jsonDir) {
  New-Item -ItemType Directory -Path $backup -Force | Out-Null
  foreach ($item in 'settings.json', 'projects') {
    $path = Join-Path $jsonDir $item
    if (Test-Path -LiteralPath $path) { Copy-Item -LiteralPath $path -Destination $backup -Recurse -Force }
  }
}

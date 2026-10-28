$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23/flashfig.exe' # HTTPS preferred
  checksum     = '3F749C4CE2D03B73F131A94F1F6742B80B1FF88F1CD944A6622F033EE68B14BD'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

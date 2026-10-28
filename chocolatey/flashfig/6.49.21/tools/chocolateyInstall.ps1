$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.21/flashfig.exe' # HTTPS preferred
  checksum     = '5B127EA50C7CE8229102C79201A9FEC0C53C86DC65DBA6D9FEB9827B928D5B17'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

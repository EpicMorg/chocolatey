$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.7/flashfig.exe' # HTTPS preferred
  checksum     = 'E2AC8415AE42F4FA85F8C091EE309D86EA781C752BEAE3B1AF7AD0A2C407A5DA'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

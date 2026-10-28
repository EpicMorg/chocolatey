$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.4/flashfig.exe' # HTTPS preferred
  checksum     = 'F7916BAACDEFD180B50E8B6D7AD9172E5BEBD842E79339CE01F2DD26838E50B0'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.16.2/flashfig.exe' # HTTPS preferred
  checksum     = 'DA15B0F90C73F6652EB529DCDCB7C917191B97EA0C318A9FD446E3958240C28A'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

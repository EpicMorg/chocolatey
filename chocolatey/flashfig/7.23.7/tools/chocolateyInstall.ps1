$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.7/flashfig.exe' # HTTPS preferred
  checksum     = '0F90DC307713B12E27D03C167F2783D8C9577E5FF0EFB9F27FE77C8F5F50782F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

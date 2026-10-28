$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.4/flashfig.exe' # HTTPS preferred
  checksum     = '1C54D971968BD8AB48D2A898CC307322A9E999EA0914C953107A7E71BD24A22E'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

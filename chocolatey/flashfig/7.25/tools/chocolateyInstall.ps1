$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.25/flashfig.exe' # HTTPS preferred
  checksum     = 'E75A92E78B3D11A16D533FE37C83A5D4EA28D63A6C27235FABA2AC006D2708D8'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

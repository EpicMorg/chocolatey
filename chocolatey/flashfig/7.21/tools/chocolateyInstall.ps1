$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21/flashfig.exe' # HTTPS preferred
  checksum     = '8DA4F9A68CE1A5FEF3FBECE86712C339F07056F012BC1B6C3B0F957FCB81D152'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

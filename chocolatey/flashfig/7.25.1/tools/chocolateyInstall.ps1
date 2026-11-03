$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.25.1/flashfig.exe' # HTTPS preferred
  checksum     = '8A44C391AEF4D8F1DABB69F74DA95435513B0B4F7714AE61D7A89AEB96272D47'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

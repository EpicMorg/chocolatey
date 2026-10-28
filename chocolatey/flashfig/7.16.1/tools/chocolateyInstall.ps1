$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.16.1/flashfig.exe' # HTTPS preferred
  checksum     = '54950CEFFC95B61861F6513DDBC8D26E68898523C8B3BE01492B96B6842D8248'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

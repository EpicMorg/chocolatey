$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.10.2/flashfig.exe' # HTTPS preferred
  checksum     = 'F9D7EFED7246C79B3B4E1CEEB69C2B72D5CA6C53567A6623158A6F155F776062'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

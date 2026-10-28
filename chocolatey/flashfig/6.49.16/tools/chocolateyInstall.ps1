$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.16/flashfig.exe' # HTTPS preferred
  checksum     = 'F0C6042811B8CAE3BD6556B10B7DB5E85D7CA61110CB3BAF18E2F8E2A1F1E827'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

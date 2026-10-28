$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20/flashfig.exe' # HTTPS preferred
  checksum     = '719B9BB080D70977BFFC3C6BE987BD10D35538401F9F1B42F2ED9145B9822F4F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.6/flashfig.exe' # HTTPS preferred
  checksum     = '3ADCDE460CD8FD05E3985EC58AF9C43B0B56C821F5F9BAAB25D580EE05A4A810'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

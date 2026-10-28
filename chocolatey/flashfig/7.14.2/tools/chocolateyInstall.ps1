$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.14.2/flashfig.exe' # HTTPS preferred
  checksum     = '362D716F18833FD6D7FC257BED173CA18A10285DFB11DFD3FE63348DE6FF738D'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

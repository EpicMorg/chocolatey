$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.1/flashfig.exe' # HTTPS preferred
  checksum     = 'D8C7DDEC108D7791C03B9F637B65A4A49062F0A1EC07606B61390ED80D8DE183'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

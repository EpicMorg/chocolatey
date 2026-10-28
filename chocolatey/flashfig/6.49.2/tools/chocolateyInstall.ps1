$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.2/flashfig.exe' # HTTPS preferred
  checksum     = '939CC5FB59A10E920310C73E5E5A8194FA770C3BD7C0E901D8149DEFD77F0762'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21.4/flashfig.exe' # HTTPS preferred
  checksum     = '6F949A53E2433A0E6CB1CA37C2A5B873EBAB80D7FAE52690CDA2DBE5230B7E23'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

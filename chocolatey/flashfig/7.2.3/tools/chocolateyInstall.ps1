$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.2.3/flashfig.exe' # HTTPS preferred
  checksum     = 'B9B41CB8481486905427F0E1D9DD8FCA5400AA8733664409A3FB2DD011BD1B07'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.15/flashfig.exe' # HTTPS preferred
  checksum     = '47ECAF6F9F99173973E8B00500EA818E67F735EE83735603F691CBDC2530664F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

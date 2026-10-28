$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.18/flashfig.exe' # HTTPS preferred
  checksum     = '19677E1A1E65246DC98D0EE93640B5124FFC121945C9F858E2224B8D17408868'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

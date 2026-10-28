$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.3/flashfig.exe' # HTTPS preferred
  checksum     = '26B77AE83D2731AA394404E886B105EE7920EECA0E44AB75F2B8303469D0FFE4'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21.3/flashfig.exe' # HTTPS preferred
  checksum     = '057ED032E1C32094A09291BC60EDD55AA4293ED304F25C48A088AE6682D239E7'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

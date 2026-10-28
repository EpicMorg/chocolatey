$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.3/flashfig.exe' # HTTPS preferred
  checksum     = 'FE30E5CDB17F7D049E12EFBA06C3B90700E991E962453947FBEB450081D6824C'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

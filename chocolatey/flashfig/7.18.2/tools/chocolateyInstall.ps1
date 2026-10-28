$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.18.2/flashfig.exe' # HTTPS preferred
  checksum     = 'D052177E5E5158A22E745BB0C52C446285CC26ED5F17EAC32F241435161F68D9'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

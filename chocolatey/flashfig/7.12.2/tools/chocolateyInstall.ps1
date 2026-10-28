$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.12.2/flashfig.exe' # HTTPS preferred
  checksum     = '28A9FC82EAF6FAB8CFBB497074CEABD0B71BCD8B73DD67BFD6B723ADFF4CA1D0'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

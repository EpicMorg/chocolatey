$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.11.1/flashfig.exe' # HTTPS preferred
  checksum     = '1C36568865FEADE9A7F453619EA3E85EC68AEC396FFE81643A057EA21266B010'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

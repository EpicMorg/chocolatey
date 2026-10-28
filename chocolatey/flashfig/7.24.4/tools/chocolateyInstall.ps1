$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.24.4/flashfig.exe' # HTTPS preferred
  checksum     = '930AC0CC0D37989EFC30BF1B1A943BF01E8B7F3A04ACB46B4AD298F11F3CE742'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

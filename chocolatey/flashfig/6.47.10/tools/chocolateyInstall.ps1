$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.47.10/flashfig.exe' # HTTPS preferred
  checksum     = '17DB59D019F01491B487B7A7FD073B0F11E73A67E02FE8FD45F4398EBB37FD1D'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

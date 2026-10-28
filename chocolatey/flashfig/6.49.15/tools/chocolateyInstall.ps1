$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.15/flashfig.exe' # HTTPS preferred
  checksum     = '3E125F6AB085B6E43E42D197CC2880B93C301117EF6C8E4E1F10432FC163F4EF'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

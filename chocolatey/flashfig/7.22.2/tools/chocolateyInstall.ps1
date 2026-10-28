$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.22.2/flashfig.exe' # HTTPS preferred
  checksum     = '7F016F47B20DD4517D0B06092F5B1DB3C828C27F2B3226F18F7377A24D8186E8'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

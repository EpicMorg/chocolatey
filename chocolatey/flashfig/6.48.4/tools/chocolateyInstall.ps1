$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.48.4/flashfig.exe' # HTTPS preferred
  checksum     = '5A7C4CB3345E5533649997FA93FC4DEBFE64531314B7A9601C66443748C405B2'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

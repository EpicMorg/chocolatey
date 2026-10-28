$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.7/flashfig.exe' # HTTPS preferred
  checksum     = '62C17D565CDE3FC0EA715664E2C440AE326DE4AE2BD91D08A2FF1E0FF2B8C095'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

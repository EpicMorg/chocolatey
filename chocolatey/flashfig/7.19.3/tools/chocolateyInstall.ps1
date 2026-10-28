$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.3/flashfig.exe' # HTTPS preferred
  checksum     = 'FFFE539AC3F988622AA70DAA5609B3E86E2A960FAA53EA3772BBA3780A3924AB'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

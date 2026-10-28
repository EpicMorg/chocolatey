$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.6/flashfig.exe' # HTTPS preferred
  checksum     = '46AFCF65CF1042D30A8A67C04E1C73C15E022C1B2319A707D37AB44EE246E0D5'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

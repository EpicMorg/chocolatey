$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1.4/flashfig.exe' # HTTPS preferred
  checksum     = 'EDFA9C8D02E1FA6FBC685BECF321F4A142D77F485EDCFAB70CA4C2CEC301C940'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

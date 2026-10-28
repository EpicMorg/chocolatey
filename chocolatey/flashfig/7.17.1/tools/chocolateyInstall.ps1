$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.17.1/flashfig.exe' # HTTPS preferred
  checksum     = '50C0A46A32472208E54A47C157CA30EF221B493BE5E0204AD33D7B4482F20B6E'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

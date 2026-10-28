$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.15.2/flashfig.exe' # HTTPS preferred
  checksum     = 'D9BEF08C0656C0BC24A8098C0C1A38D0AF02301671473130A3BEC5AD5B701751'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

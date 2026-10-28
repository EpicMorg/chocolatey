$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.11/flashfig.exe' # HTTPS preferred
  checksum     = 'AE91D15FE4770562F08D9693A2EC8DD90549FF03B714188C2C7FEE6C873A555E'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

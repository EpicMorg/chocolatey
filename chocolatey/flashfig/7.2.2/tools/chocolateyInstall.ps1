$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.2.2/flashfig.exe' # HTTPS preferred
  checksum     = 'CF24D60F5E1C999413C7F08B5D674BD4A936604663246667009255E91CD61557'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

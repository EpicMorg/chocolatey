$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.3/flashfig.exe' # HTTPS preferred
  checksum     = '5643A73FFF433E9F63E62980F0A6AA45DA18F9089DEB02606D1C378381AD61EE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

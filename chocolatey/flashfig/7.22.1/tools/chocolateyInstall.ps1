$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.22.1/flashfig.exe' # HTTPS preferred
  checksum     = '125CDC28A877641B97C165B9068644C74242DF492B1E372B3E57F2BDA0EDABC3'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

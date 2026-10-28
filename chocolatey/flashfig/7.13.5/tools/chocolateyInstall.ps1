$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.13.5/flashfig.exe' # HTTPS preferred
  checksum     = '96CADA304AFCFDECC5A2AB037B70A7932D33A89191D8947AF9C4DDBD137355CF'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

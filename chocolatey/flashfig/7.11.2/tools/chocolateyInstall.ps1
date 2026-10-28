$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.11.2/flashfig.exe' # HTTPS preferred
  checksum     = 'C9DB364F5D65C05947CCFE60640089A98AFB73A3DE3470F35EF2434564C81A49'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.10/flashfig.exe' # HTTPS preferred
  checksum     = '6E4DC3DF7898EFA476755DF8D76CB302029C69C86DB62F23CCD64BC06D77321B'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.2.1/flashfig.exe' # HTTPS preferred
  checksum     = 'BDBEA96F75260751299AE07BD1255469BB00E970BF5ABECBD045933B039750BC'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

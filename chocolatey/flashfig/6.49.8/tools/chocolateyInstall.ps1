$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.8/flashfig.exe' # HTTPS preferred
  checksum     = 'DB01F945CD8CE01D20159AA7E8C2C969A717B96F495C96D8A14771708D3CAAE2'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

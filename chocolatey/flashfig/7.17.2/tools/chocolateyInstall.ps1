$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.17.2/flashfig.exe' # HTTPS preferred
  checksum     = 'AA1084B2668CEDD2E1523DDCF1A9C8880563EA456094FC925B065947845DEC34'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

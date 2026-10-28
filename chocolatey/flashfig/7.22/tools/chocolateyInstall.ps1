$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.22/flashfig.exe' # HTTPS preferred
  checksum     = '225E9C5BF4E9CDFB0A596E2D06DED7228B28113604C56A77E03A96FE1A3867E9'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

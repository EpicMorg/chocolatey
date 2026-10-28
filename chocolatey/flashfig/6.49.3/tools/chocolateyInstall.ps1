$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.3/flashfig.exe' # HTTPS preferred
  checksum     = '3C5D632615C037C3A4A1BD2AD94B5D91745D703C336C9DC7F36D71FF07651DE7'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

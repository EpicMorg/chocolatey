$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.5/flashfig.exe' # HTTPS preferred
  checksum     = 'CCD6948CC0057AE993750B29CD451590B5BE91A1BB4C647B9192204D4E4A93DE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

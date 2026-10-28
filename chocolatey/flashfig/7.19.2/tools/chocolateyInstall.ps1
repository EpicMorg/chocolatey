$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.2/flashfig.exe' # HTTPS preferred
  checksum     = '7F9CB16805AB8EAABCE39BC495BAA39978E6F0AAD09EF50CC95814198B579EDE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

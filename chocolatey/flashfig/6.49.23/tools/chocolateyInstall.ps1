$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.23/flashfig.exe' # HTTPS preferred
  checksum     = '573A13B690FC75C3AB72E03E09B2DE5F105BC73EBC1723C3F07504D47CC11EC9'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

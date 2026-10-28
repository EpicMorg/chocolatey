$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.12.1/flashfig.exe' # HTTPS preferred
  checksum     = '03E89F78CF221011A5B79F4DEA71116942B0B1255AFD95FF29ED2730743DD41B'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

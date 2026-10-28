$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1/flashfig.exe' # HTTPS preferred
  checksum     = '7471F76DA47D86EDD4FC6D954B8056229CBBA564411502FD46EE7EAB20C0A9EC'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

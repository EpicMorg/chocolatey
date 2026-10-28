$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.1/flashfig.exe' # HTTPS preferred
  checksum     = 'F3A6B6B66973D5DF5E6D728031FB38A523C483EFA09710D18AFABFFFF0CF1487'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

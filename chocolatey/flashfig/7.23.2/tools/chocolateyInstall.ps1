$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.2/flashfig.exe' # HTTPS preferred
  checksum     = 'DC74F29B0D03E29C30DD9C066DA815EB9D453172ED0C7D08BD14C712A8E50ECE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

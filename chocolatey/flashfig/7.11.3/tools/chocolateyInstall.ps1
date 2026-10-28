$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.11.3/flashfig.exe' # HTTPS preferred
  checksum     = '744318597FEF1D14978808FE2E4A547008A736750CB8CD4AFEAC0B4870877623'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

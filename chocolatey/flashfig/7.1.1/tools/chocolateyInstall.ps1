$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1.1/flashfig.exe' # HTTPS preferred
  checksum     = '5CB12702A08DC593F42D53D7B5167CEEC746C265758D32344338471E21859994'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.24.1/flashfig.exe' # HTTPS preferred
  checksum     = '5B17D8C241C03255330EFC5900D40D61F37BADFA64F1C97E512DDC9D4A11FD04'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

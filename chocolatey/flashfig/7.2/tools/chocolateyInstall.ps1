$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.2/flashfig.exe' # HTTPS preferred
  checksum     = '7E0D3C16ACD36BBDB6D70863BE68336FB39D42C4325E02A41A9B60AF81A060D5'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

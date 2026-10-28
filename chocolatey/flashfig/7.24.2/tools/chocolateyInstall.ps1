$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.24.2/flashfig.exe' # HTTPS preferred
  checksum     = '8CDE1383836760D61B199096675A0B01CC01F10084579094E335F408D9431B44'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

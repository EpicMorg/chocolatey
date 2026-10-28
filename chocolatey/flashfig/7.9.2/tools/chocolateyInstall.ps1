$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.9.2/flashfig.exe' # HTTPS preferred
  checksum     = '763C6C4424942762EFE2F8B5A698AD662FAF491F5B2F097D22E42B8C68C078CF'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

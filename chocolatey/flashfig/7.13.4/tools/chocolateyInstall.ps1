$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.13.4/flashfig.exe' # HTTPS preferred
  checksum     = 'B2A23EDCA1F972A5309FD75AEE869ECA964F890BB9A069A58634BDB5F8C0B0AE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

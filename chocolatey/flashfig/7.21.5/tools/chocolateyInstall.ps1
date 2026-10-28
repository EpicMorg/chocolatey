$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21.5/flashfig.exe' # HTTPS preferred
  checksum     = '43CF843CF498F0E280957BB50633607981D6FB038142A973A865EE02405C93EC'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

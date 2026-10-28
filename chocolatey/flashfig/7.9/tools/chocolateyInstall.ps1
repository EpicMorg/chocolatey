$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.9/flashfig.exe' # HTTPS preferred
  checksum     = '5A89E36184BA7893DDC39B45A4604DB234AECDD9C83B610ADE2FFDB21AE1ED87'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

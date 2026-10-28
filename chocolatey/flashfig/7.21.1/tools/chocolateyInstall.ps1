$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21.1/flashfig.exe' # HTTPS preferred
  checksum     = '5FC02E8C26415C2561ACF167164E380F2C5B6EE6D8CB1652443B95E56642217E'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

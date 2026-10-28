$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.10/flashfig.exe' # HTTPS preferred
  checksum     = '2250218411827DD22113841E32432F42394DD0ED33D0A057C897B0101FACE5CD'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

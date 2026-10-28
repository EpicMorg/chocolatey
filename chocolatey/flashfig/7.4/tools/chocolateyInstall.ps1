$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.4/flashfig.exe' # HTTPS preferred
  checksum     = 'EC7BD37986D9808E020F81694527A27EF5201BAD17A025A8DF63D2A29262B04D'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.2/flashfig.exe' # HTTPS preferred
  checksum     = '1C1231D25FF4DE2A1BE4DEC707962FD013B7BD78314F9ECD57F74093AD1B5FCB'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

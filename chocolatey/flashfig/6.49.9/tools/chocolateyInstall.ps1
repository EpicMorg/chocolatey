$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.9/flashfig.exe' # HTTPS preferred
  checksum     = 'EE23DB2FF2870E3632A43D8BA18DB87808373D9555130BF889A7F52C5D90FBD6'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

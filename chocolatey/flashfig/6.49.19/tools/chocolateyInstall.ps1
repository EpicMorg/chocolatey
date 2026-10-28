$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.19/flashfig.exe' # HTTPS preferred
  checksum     = '761639BF702D2CD71112321EC0EB84DA37013AF838FC45A211C8D090032297DD'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

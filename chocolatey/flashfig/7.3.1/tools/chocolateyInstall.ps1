$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.3.1/flashfig.exe' # HTTPS preferred
  checksum     = '0055AF7598CE894F73C732F5C58A0E305BF4AE984D96FDF7A613060C27BC9557'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

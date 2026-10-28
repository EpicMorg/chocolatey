$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.4/flashfig.exe' # HTTPS preferred
  checksum     = 'A36E49C38309B87B3892E13FD24B861F0128137C8DACFC6C7C9FDB7CE255EC79'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

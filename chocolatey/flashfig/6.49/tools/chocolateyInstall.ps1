$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49/flashfig.exe' # HTTPS preferred
  checksum     = '3280ECC51772E1AAAA8C9F1AD70D7E97514B05B8CCC722C1B71BF155A50796C4'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

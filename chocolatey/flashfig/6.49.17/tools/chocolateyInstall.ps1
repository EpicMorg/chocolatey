$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.17/flashfig.exe' # HTTPS preferred
  checksum     = '49C3FD82FBAA55D2836FBD5A29C0219BAB59FDF185624204AB92378F973C7C40'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

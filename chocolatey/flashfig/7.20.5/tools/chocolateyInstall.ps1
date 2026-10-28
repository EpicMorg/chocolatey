$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.5/flashfig.exe' # HTTPS preferred
  checksum     = 'B216D2D0AE190F5A6DCC0A512E0ADBD7DD9363AEB0DC5B43B211129097BDEBA9'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

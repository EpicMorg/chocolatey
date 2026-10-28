$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.5/flashfig.exe' # HTTPS preferred
  checksum     = '6E03A230DDAA9126C1A550594AFD54753039F5557800D7C63F2A0FFE34A1E5C7'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

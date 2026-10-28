$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.13/flashfig.exe' # HTTPS preferred
  checksum     = 'E6A1FCFC988BCB6DED8B18FC811697DF8D0F829718D07A7B986283224C8BB987'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

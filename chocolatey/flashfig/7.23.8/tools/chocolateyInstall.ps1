$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.8/flashfig.exe' # HTTPS preferred
  checksum     = '93901E983EF5C8F468436BE5C2FFE7CC023E4FB4C921D9E71DC0C9C335996CCA'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

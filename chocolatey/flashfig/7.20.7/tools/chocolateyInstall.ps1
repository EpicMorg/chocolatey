$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.7/flashfig.exe' # HTTPS preferred
  checksum     = '9EF5D6CD95B122660844878BF1EB8414F265D67FB1214F8665A9E230088FD433'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

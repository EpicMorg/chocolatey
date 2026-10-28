$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.23.6/flashfig.exe' # HTTPS preferred
  checksum     = '896127E7D3FF06E0B206371925373DC3FAEDE4E983C01B962BF7E586602B445F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.19.5/flashfig.exe' # HTTPS preferred
  checksum     = 'D021D22B361FE32CAC5260A8A3A28651CFFAF03536AC562C4D3F698B04BD93C8'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

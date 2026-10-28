$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1.5/flashfig.exe' # HTTPS preferred
  checksum     = 'C3BDAEC9DC90D068BEED1569AD07C7D56AA1A2E254E59C1EFB649ABDC72E8710'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

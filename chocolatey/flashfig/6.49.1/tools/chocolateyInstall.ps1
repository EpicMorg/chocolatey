$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.1/flashfig.exe' # HTTPS preferred
  checksum     = 'D8D29A3D0C65A5F8E3CA2EF8CE1BFB37E4B35F6B21B1344EAFD88CCF72979AA4'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

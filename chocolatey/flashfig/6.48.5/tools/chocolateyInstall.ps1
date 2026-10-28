$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.48.5/flashfig.exe' # HTTPS preferred
  checksum     = 'E66F567EFD5AE292D9B1C1811BB9076B5D93045078C76627C5C3ABCC837C0CA2'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

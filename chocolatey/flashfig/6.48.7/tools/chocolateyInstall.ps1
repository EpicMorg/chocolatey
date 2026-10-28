$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.48.7/flashfig.exe' # HTTPS preferred
  checksum     = 'A2AAD01F82614D3BA4D5D7D9F8E2183980A1A2B67F5EB1FF9E18344C695F1EB1'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.11/flashfig.exe' # HTTPS preferred
  checksum     = 'EC9C652A5A6DEFEFA64D8D0FF5553C12EC9E4B2B124E2F55AF95F71DE4E548F3'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

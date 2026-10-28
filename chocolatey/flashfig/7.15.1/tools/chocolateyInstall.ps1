$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.15.1/flashfig.exe' # HTTPS preferred
  checksum     = 'BA6A729E86C3A4EB4DDFDC83D4302DFC6F3F235263C20F0EFB2E66CF937A832C'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

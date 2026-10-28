$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.24/flashfig.exe' # HTTPS preferred
  checksum     = '2AD59EDC67526288910AA13F91E29DF986B695BDA60A45E7E990559ECA306740'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

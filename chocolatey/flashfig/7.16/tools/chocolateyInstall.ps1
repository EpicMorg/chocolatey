$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.16/flashfig.exe' # HTTPS preferred
  checksum     = 'FE962D2190222109D7FDB1CA51EA295B4A9CFC86CD7A4E62B9F29BEA6FB3EF61'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

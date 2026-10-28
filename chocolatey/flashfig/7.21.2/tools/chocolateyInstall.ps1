$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.21.2/flashfig.exe' # HTTPS preferred
  checksum     = '4023E9AFBD3C4E85514ECDB7C5EDA32D92AB92E26F83EF1382E13FE3A18ADEE3'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

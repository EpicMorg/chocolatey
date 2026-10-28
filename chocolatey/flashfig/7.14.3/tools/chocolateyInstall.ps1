$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.14.3/flashfig.exe' # HTTPS preferred
  checksum     = '532499DB490CAA04EA94A37DF6CAA5E68EA1EE3BAA4B819E8F49A345F45F7DFE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

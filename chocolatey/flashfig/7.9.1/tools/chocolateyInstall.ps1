$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.9.1/flashfig.exe' # HTTPS preferred
  checksum     = '33769169602F0D985C6DF552FD5D7380D223A47DF4A34CFBB4A0B2A6BA854C52'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

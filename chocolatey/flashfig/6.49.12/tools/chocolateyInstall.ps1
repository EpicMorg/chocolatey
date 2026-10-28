$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.12/flashfig.exe' # HTTPS preferred
  checksum     = '1E27BCE6A3B4ED2AACD0E0D9194F4409844084C6859D123A56DC47315FCA5CCE'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

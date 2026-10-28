$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.4.1/flashfig.exe' # HTTPS preferred
  checksum     = '7B3A7E6FA9C9A1F085545EF1CF53FA86AE9097B1C0CF247FEC01F1C702390FC1'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

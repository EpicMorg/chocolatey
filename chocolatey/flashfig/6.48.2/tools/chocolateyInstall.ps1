$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.48.2/flashfig.exe' # HTTPS preferred
  checksum     = 'F2A91A2C7436E0FC642D4B44E771BD4EBE9E925C0B7462B8801987CF7C10432C'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

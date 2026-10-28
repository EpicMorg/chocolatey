$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.12/flashfig.exe' # HTTPS preferred
  checksum     = 'C12CD55B738CEF0C49C08B200BE67AFC301EDD35DD6C0C665304A1EA0CC00139'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

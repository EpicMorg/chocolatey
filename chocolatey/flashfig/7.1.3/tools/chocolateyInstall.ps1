$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1.3/flashfig.exe' # HTTPS preferred
  checksum     = 'FD63221C5C56AA8C2EE119068B888CBA43A9FF6278010683D3B5F283AA89154B'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

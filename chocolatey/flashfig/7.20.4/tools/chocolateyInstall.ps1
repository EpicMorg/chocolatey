$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.20.4/flashfig.exe' # HTTPS preferred
  checksum     = '0F672CA761D82DC5657701C03CA43B51CE5615BE605B4445BBB344B36ED643D7'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

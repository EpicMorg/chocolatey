$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.17/flashfig.exe' # HTTPS preferred
  checksum     = '39C95BAABE271954EE9C0C925638C6578405A80BAD4145CB166AF2C81D4D6652'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.14/flashfig.exe' # HTTPS preferred
  checksum     = '99FAA29B826157D1C4F464EFF7757E25F81A5D52176821400F5A23A7A97762F6'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.14/flashfig.exe' # HTTPS preferred
  checksum     = 'ED2168C92A5BE95B1E5FBF1FDCE13E14961A3521D443164F24A991932626316C'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

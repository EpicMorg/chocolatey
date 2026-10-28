$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.18/flashfig.exe' # HTTPS preferred
  checksum     = 'B2EE630CBEC5B4D5DDED1CB5340435339A78F699A1C860D02EB990852EC7C93F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

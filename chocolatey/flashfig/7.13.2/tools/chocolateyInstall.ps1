$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.13.2/flashfig.exe' # HTTPS preferred
  checksum     = 'F6D6298DC10EC3943E4C22C66A7E3AF36DA80562DBB7EF5A50602D5BD46C357D'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

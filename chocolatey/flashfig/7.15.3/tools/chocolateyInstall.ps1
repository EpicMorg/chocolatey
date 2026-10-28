$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.15.3/flashfig.exe' # HTTPS preferred
  checksum     = 'C4D4B8BB4094155BE547794D545251C34868397C93D6485F76BA10897595581A'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

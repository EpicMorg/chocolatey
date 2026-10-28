$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.10.1/flashfig.exe' # HTTPS preferred
  checksum     = '8A485E46B093F068751BD783B3F40BD2CD44EB64761E74F39907D0064AB06F09'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

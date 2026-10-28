$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.22/flashfig.exe' # HTTPS preferred
  checksum     = 'D7C81AEC071E36FB68BC12472E43FEF1A1A50ABDC8920FE24810780EF363CB0F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

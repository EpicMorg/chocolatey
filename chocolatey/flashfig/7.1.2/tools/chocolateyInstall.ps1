$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.1.2/flashfig.exe' # HTTPS preferred
  checksum     = '6FF2C66F29584EE69D206011DFC7058DCA1599AF62122C7E8D420F12D1AA52E1'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

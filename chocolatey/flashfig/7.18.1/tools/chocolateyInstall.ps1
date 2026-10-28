$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.18.1/flashfig.exe' # HTTPS preferred
  checksum     = 'C0E824BC6480782DAFA6567DC95637DA10B791BF5571B36BA2919EE666D80EBB'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

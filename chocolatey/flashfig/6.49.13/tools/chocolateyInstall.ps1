$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.13/flashfig.exe' # HTTPS preferred
  checksum     = '68563A33EECE53A47A57DEC7B3C140B3C19016E97C808C92A86C467DBC637251'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

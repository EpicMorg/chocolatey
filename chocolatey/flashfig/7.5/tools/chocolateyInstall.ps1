$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.5/flashfig.exe' # HTTPS preferred
  checksum     = 'B935F355A3DA1554F9953E06EF15390B7DFDA7AB0509E7E2179940E831B2F397'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

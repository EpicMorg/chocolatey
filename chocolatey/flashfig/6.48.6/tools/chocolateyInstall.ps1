$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.48.6/flashfig.exe' # HTTPS preferred
  checksum     = 'D4B802E2F440DF44AED3364DE9554BBF120A4CD9DBAA80DC330FE5BF72D9A8F7'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

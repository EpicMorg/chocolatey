$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/7.22.3/flashfig.exe' # HTTPS preferred
  checksum     = '2FCB0BD0677CCD9D9E61D61C2FA9B5DAC525EB775BF1974AF472641876F81C4F'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.TheDude` 6.47.9 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/6.47.9/dude-install-6.47.9.exe' # HTTPS preferred
  checksum       = 'B24C0C39DF193904D5D0E07BAB4979FB080C92B6F72E7DD370B54B0CC3967309'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'The Dude*'   # matches the Add/Remove Programs DisplayName 'The Dude'
}

Install-ChocolateyPackage @packageArgs

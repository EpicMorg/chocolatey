$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.TheDude` 7.16.2 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.16.2/dude-install-7.16.2.exe' # HTTPS preferred
  checksum       = '30D5972DB46985972CB25929CAD6E51A254731722B1381F5B2D2339CBC468201'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'The Dude*'   # matches the Add/Remove Programs DisplayName 'The Dude'
}

Install-ChocolateyPackage @packageArgs

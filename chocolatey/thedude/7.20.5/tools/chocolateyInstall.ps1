$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.TheDude` 7.20.5 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.20.5/dude-install-7.20.5.exe' # HTTPS preferred
  checksum       = 'C6A2B6A61640D7C096DD7074D6C1E61739988EBDC530FC26533638F7541BDF77'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'Dude*'       # matches the Add/Remove Programs entry (ProductCode: Dude)
}

Install-ChocolateyPackage @packageArgs

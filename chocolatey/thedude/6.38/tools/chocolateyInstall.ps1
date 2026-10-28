$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.38 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/6.38/dude-install-6.38.exe' # HTTPS preferred
  checksum       = '0D81622BEABBBD21A64A3D57340AC38E4EDBE32EE85F90751E82485E5CEECEAA'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'The Dude*'   # matches the Add/Remove Programs DisplayName 'The Dude'
}

Install-ChocolateyPackage @packageArgs

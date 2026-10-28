$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.12 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.12/dude-install-7.12.exe' # HTTPS preferred
  checksum       = '8DDD1630A26D53C3CB5823ED113FE3549FBD6A3D5FF9DDB00C407CD17F83ADDC'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'Dude*'       # matches the Add/Remove Programs entry (ProductCode: Dude)
}

Install-ChocolateyPackage @packageArgs

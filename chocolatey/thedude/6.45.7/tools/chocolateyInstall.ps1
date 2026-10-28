$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.45.7 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/6.45.7/dude-install-6.45.7.exe' # HTTPS preferred
  checksum       = '5C5CF5967697943BEC5E50C6F1E579C9459DC58989584C49862157AB1355565E'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'Dude*'       # matches the Add/Remove Programs entry (ProductCode: Dude)
}

Install-ChocolateyPackage @packageArgs

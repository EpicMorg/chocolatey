$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.22.2 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.22.2/dude-install-7.22.2.exe' # HTTPS preferred
  checksum       = '4690881021340D6BA21CB58EFB34FD2931BA7EA0A35509FEEA0F9945D66DD653'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'The Dude*'   # matches the Add/Remove Programs DisplayName 'The Dude'
}

Install-ChocolateyPackage @packageArgs

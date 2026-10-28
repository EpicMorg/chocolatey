$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.14.1 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.14.1/dude-install-7.14.1.exe' # HTTPS preferred
  checksum       = '3CFA66023547926FD8056F3317F3555CFBA7FC7906E56805FA72CF62AFA6BD34'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'The Dude*'   # matches the Add/Remove Programs DisplayName 'The Dude'
}

Install-ChocolateyPackage @packageArgs

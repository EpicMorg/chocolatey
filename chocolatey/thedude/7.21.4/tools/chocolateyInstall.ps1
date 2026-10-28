$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.21.4 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/7.21.4/dude-install-7.21.4.exe' # HTTPS preferred
  checksum       = '8EE43CF1801F7325973FD6E5DE640889DA1CFE19CED6358C9E25EC6F6A8B83AA'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'Dude*'       # matches the Add/Remove Programs entry (ProductCode: Dude)
}

Install-ChocolateyPackage @packageArgs

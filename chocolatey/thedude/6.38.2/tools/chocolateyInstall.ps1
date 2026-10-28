$ErrorActionPreference = 'Stop'

$packageName = 'thedude'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.38.2 (InstallerType: nullsoft / NSIS).
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://download.mikrotik.com/routeros/6.38.2/dude-install-6.38.2.exe' # HTTPS preferred
  checksum       = 'D6D56912C56B6D355190A6E70817B19A5351F649C427FB3179520045C216273B'
  checksumType   = 'sha256'
  silentArgs     = '/S'          # NSIS (nullsoft) silent install
  validExitCodes = @(0)
  softwareName   = 'Dude*'       # matches the Add/Remove Programs entry (ProductCode: Dude)
}

Install-ChocolateyPackage @packageArgs

$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.19.0 build 210401. Supermicro ships IPMIView for Windows as a ZIP (~182 MB)
# that holds a single InstallAnywhere installer EXE with its own bundled JRE.
# The ZIP is downloaded from Supermicro's download center and checked against the
# sha256 below, then the installer is run unattended.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/332/IPMIView_2.19.0_build.210401_Windows.zip'
  checksum      = '04331564641C37E8631CC38B92CAAF1D4DD6886AA1D17FA83693897EB76B4944'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installer = Join-Path $toolsDir 'IPMIView_2.19.0_build.210401_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

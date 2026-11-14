$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.20.0 build 220309. Supermicro ships IPMIView for Windows as a ZIP (~205 MB)
# that holds a single InstallAnywhere installer EXE with its own bundled JRE.
# The ZIP is downloaded from Supermicro's download center and checked against the
# sha256 below, then the installer is run unattended.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/419/IPMIView_2.20.0_build.220309_Windows.zip'
  checksum      = '4A9AE7E84A5A77AE8F36E3A7B7457C03A95D075D85464E0AE9BD17C1251EB9C5'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installer = Join-Path $toolsDir 'IPMIView_2.20.0_build.220309_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

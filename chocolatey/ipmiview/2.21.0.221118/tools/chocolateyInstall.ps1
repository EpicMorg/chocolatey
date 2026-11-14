$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.21.0 build 221118. Supermicro ships IPMIView for Windows as a ZIP (~206 MB)
# that holds a single InstallAnywhere installer EXE with its own bundled JRE.
# The ZIP is downloaded from Supermicro's download center and checked against the
# sha256 below, then the installer is run unattended.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/512/IPMIView_2.21.0_build.221118_Windows.zip'
  checksum      = '9B58D278D0D20F5CEEE5DF31CDAD703DEE00312A88342533386C20D117D9D20A'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installer = Join-Path $toolsDir 'IPMIView_2.21.0_build.221118_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

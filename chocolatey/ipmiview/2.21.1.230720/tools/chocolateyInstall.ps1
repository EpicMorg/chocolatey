$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.21.1 build 230720. Supermicro ships IPMIView for Windows as a ZIP (~204 MB)
# that holds a single InstallAnywhere installer EXE with its own bundled JRE.
# The ZIP is downloaded from Supermicro's download center and checked against the
# sha256 below, then the installer is run unattended.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/585/IPMIView_2.21.1_build.230720_Windows.zip'
  checksum      = 'C0BAB45077CA171E4983729CF4E1F48C49D9954B6B5D8A0B429A8EA7305DFC9E'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installer = Join-Path $toolsDir 'IPMIView_2.21.1_build.230720_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

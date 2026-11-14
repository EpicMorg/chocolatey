$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.25.0 build 260812. Supermicro ships IPMIView for Windows as a ZIP (~177 MB)
# that holds a single InstallAnywhere installer EXE with its own bundled JRE.
# The ZIP is downloaded from Supermicro's download center and checked against the
# sha256 below, then the installer is run unattended.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/1173/IPMIView_2.25.0_build.260812_Windows.zip'
  checksum      = 'FD4466C605AF4156156B5B341DB843F5AAC5906E64964A57CD7C19DF14E7D247'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installer = Join-Path $toolsDir 'IPMIView_2.25.0_build.260812_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

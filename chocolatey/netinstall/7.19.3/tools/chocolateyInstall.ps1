$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.19.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.19.3/netinstall-7.19.3.zip'   # x86, HTTPS preferred
  checksum       = '5A32143A653B1CD6668C7C8C2C1CCBAF55BB344B9A0DB6547D508F378A07B3C2'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.19.3/netinstall64-7.19.3.zip' # x64
  checksum64     = 'E709B8515D3054788CF49233B08FCA132C52B502A301612F7DD548377777E1D6'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Normalise the command name to `netinstall` on both bitnesses.
# The x64 archive ships `netinstall64.exe`; rename it so the shim Chocolatey
# auto-generates after this script is always `netinstall`, matching the x86 build
# and the winget `PortableCommandAlias: netinstall`.
$exe64 = Join-Path $toolsDir 'netinstall64.exe'
$exe32 = Join-Path $toolsDir 'netinstall.exe'
if (Test-Path $exe64) {
  Move-Item -Path $exe64 -Destination $exe32 -Force
}

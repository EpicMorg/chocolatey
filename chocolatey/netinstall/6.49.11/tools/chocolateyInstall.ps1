$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.49.11 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.49.11/netinstall-6.49.11.zip'   # x86, HTTPS preferred
  checksum       = '3497320853186A8071464CFD7D64C939463FEB89024002E46B0A17A6D3FBA56E'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.49.11/netinstall64-6.49.11.zip' # x64
  checksum64     = 'DB4B1FAAC7EC551F21B7988486CF8832D1AFF730D55E3435DDD6D081AB66C264'
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

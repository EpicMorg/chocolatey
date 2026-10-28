$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.14.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.14.3/netinstall-7.14.3.zip'   # x86, HTTPS preferred
  checksum       = '170CCC7E6102F5A86C2AB52F0B7087FAB706B8C4B2154CFFD5A29B1E5C2578A0'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.14.3/netinstall64-7.14.3.zip' # x64
  checksum64     = '5D9AE89EA5E7B633D984C014AB9B67CD77A9C697FCB4F93394A5F9086D99A43C'
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

$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.48.6 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.48.6/netinstall-6.48.6.zip'   # x86, HTTPS preferred
  checksum       = 'FC7E45516FF46A5B97D9247D7E9E0D1EFC614875345A1AD7DD6AAA37BD6C6447'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.48.6/netinstall64-6.48.6.zip' # x64
  checksum64     = '20B036B063D761447BA86815902FAC55B1DC1617C58701C4AD5C26FD66339D01'
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

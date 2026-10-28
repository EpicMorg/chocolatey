$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.1.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.1.1/netinstall-7.1.1.zip'   # x86, HTTPS preferred
  checksum       = '0152E0E6A68ABD6A3837BAC543A9AEA0DD4C7B58D375DA09CD72C1EB2AC5BC24'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.1.1/netinstall64-7.1.1.zip' # x64
  checksum64     = '1657AC9307F258AF9E7AFCA35979DB3EB48654DC2657108B47039A3EDB94E1D9'
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

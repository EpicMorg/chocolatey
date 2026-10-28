$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.9.2 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.9.2/netinstall-7.9.2.zip'   # x86, HTTPS preferred
  checksum       = '1DEBABE1DB35A714A9527A4154EF7905BD8B93F03E2B197F45B0A6CFE7D54EA3'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.9.2/netinstall64-7.9.2.zip' # x64
  checksum64     = '5B16B0171ACBD992B0CB8EE8A38B5C9DDF78230C96E748D3A70AD895FBD1593B'
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

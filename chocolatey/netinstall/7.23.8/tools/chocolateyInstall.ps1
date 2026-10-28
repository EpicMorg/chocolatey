$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.23.8 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.23.8/netinstall-7.23.8.zip'   # x86, HTTPS preferred
  checksum       = '78DD8CFC2E30D74C1C8D31427A0E46BE403D353E52F62E54F2EA35B71DED5BFD'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.23.8/netinstall64-7.23.8.zip' # x64
  checksum64     = 'F8701D645BFDC09F0A2056B267B60F6D7ABA73D88E58E3C794415451B10EBBD8'
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

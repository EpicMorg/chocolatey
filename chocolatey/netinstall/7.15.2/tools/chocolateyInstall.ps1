$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.15.2 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.15.2/netinstall-7.15.2.zip'   # x86, HTTPS preferred
  checksum       = '904A73E838F2487CFCA6B5CEF7D98A0F8BA66EB1300D2FBC4268FD90F087BBE0'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.15.2/netinstall64-7.15.2.zip' # x64
  checksum64     = '9A3947EE56CF8810D5C165B875AD9C125B0A2661F131E3B4C3982B0C80E96B8D'
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

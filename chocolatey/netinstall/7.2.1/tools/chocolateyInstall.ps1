$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.2.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.2.1/netinstall-7.2.1.zip'   # x86, HTTPS preferred
  checksum       = 'D00A9519609FC6DC241DDC98CF389C0E8FCAAB22C9D0A1557B8FC080632ED1BB'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.2.1/netinstall64-7.2.1.zip' # x64
  checksum64     = '7569AEF8F8F6188A413A5E7A15E7DE3E1ACCAC6312C02EC1A4ABAB76EC1B5C1E'
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

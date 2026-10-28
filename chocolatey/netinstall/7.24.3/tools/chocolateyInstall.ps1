$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.Netinstall` 7.24.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.24.3/netinstall-7.24.3.zip'   # x86, HTTPS preferred
  checksum       = '8D7379E0E8288305A39E5D8DE981B350CF37B32041B4DAE00C54A017544F6AE7'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.24.3/netinstall64-7.24.3.zip' # x64
  checksum64     = 'A1A168A94E28CF452A361E101AD33CC18C1D3610097BC278C49B71084D6724F7'
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

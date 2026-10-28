$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.20.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.20.3/netinstall-7.20.3.zip'   # x86, HTTPS preferred
  checksum       = '7E2C25D2AA722ABAA1610851AF733ADE345ACA6CCFB3468CA9AE64FC8287B1B6'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.20.3/netinstall64-7.20.3.zip' # x64
  checksum64     = 'E5C465346AE41E6A71C77C387BB9B0C703A1912C516791B0DE326A8C8E845DFB'
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

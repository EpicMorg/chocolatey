$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.47.5 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.47.5/netinstall-6.47.5.zip'   # x86, HTTPS preferred
  checksum       = '7401BEAE13C5D63692A6AF9EEA41BB62320C4E000FD035BB2477E6E65F5F32CF'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.47.5/netinstall64-6.47.5.zip' # x64
  checksum64     = 'C59ACCF69B10D9593F8D9BE6C4EBD4F54F12C26AC46A5E4A0C63EE312F26EB9F'
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

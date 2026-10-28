$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.20.4 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.20.4/netinstall-7.20.4.zip'   # x86, HTTPS preferred
  checksum       = 'E4E7FE897623EF74C3273B5260E0315FAD3A9DE8E47D452D2841A1AC71D5B04A'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.20.4/netinstall64-7.20.4.zip' # x64
  checksum64     = 'A59D6AFFDD10ECEB666ECCFC0253A307CD46E58F222BE9AEB6129D581F554F43'
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

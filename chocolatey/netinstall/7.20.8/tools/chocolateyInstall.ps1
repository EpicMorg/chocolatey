$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.20.8 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.20.8/netinstall-7.20.8.zip'   # x86, HTTPS preferred
  checksum       = '32929BA6D7E409F2A83AD3B16A1AEC205A869AAA765091FF2934A1DE35DCDE9D'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.20.8/netinstall64-7.20.8.zip' # x64
  checksum64     = '2F2A5259563BF0A9EE5CD8C99AC020E8A8B220DF460AA7DB0AF898219E4EE2F6'
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

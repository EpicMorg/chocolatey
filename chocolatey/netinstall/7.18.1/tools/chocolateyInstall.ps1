$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.18.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.18.1/netinstall-7.18.1.zip'   # x86, HTTPS preferred
  checksum       = 'B0462181835011276D42FC1D16D675978F05EAE06151CD29A4C5108232D3D810'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.18.1/netinstall64-7.18.1.zip' # x64
  checksum64     = '6B5394FDAB16F52C57CDD4A7A4B322EC0FB43549250F802E8A769091C1647B5B'
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

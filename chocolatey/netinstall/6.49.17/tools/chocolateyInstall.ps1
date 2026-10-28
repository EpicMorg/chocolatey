$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.49.17 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.49.17/netinstall-6.49.17.zip'   # x86, HTTPS preferred
  checksum       = '6CDCBD7671C1B8C3C0E5AEC14733F91620A1F3DC2277A67CC11A485D784EF400'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.49.17/netinstall64-6.49.17.zip' # x64
  checksum64     = 'AAC6EA056CE353B07A6A6A8F915AEC8F0482981F49E156B6D2B3A93E7FC2B22F'
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

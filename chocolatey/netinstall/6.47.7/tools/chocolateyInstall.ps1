$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.47.7 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.47.7/netinstall-6.47.7.zip'   # x86, HTTPS preferred
  checksum       = 'C27212F20520CCDAE2EB8DF78B3EBE146707C9C4464D3DAACC23ABAD5F0E1699'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.47.7/netinstall64-6.47.7.zip' # x64
  checksum64     = '76331066665638FB80BFF40C95C8EE5EC106146018C1A50BB7FDA7AF4CEFD297'
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

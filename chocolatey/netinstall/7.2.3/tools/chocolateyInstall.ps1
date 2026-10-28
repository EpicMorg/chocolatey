$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.2.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.2.3/netinstall-7.2.3.zip'   # x86, HTTPS preferred
  checksum       = '0026208C73EA1AF345C1A375D14091B2A7A9332ED66E9BA1C282B54DE3BD8AD7'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.2.3/netinstall64-7.2.3.zip' # x64
  checksum64     = '7D5CCD7A00C73F3533C50E9D0EB41BE3BFCD0A066CDC92BB5F6892D99CBCE08E'
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

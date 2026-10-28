$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.1.2 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.1.2/netinstall-7.1.2.zip'   # x86, HTTPS preferred
  checksum       = '4C2253ADAF70C63B03F46E2FF63D96BB4604EB5214D4D0EAFDB1256F0EC80D64'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.1.2/netinstall64-7.1.2.zip' # x64
  checksum64     = 'CF1044AA03F43689A635634A20E840C3F743BEEB7E84A0638E78D9DEC7EA5010'
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

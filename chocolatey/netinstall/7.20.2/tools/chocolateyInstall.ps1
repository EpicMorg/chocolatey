$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.20.2 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.20.2/netinstall-7.20.2.zip'   # x86, HTTPS preferred
  checksum       = 'DDAA986CF1F14450A6D599175E3FFFF56F1AC7A04BB4D45DBD5FAE08A94D59E8'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.20.2/netinstall64-7.20.2.zip' # x64
  checksum64     = 'F0E8C9ED9612AFABC8028D30B71F11D8DAFB59CDEE3BBC4A2BC414A060B209D4'
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

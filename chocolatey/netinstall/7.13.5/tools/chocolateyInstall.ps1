$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.13.5 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.13.5/netinstall-7.13.5.zip'   # x86, HTTPS preferred
  checksum       = '7D6B190F0DA409C7F06F304444C9F677EA93FFCE24938D5D4719B3C9FA8DBEC0'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.13.5/netinstall64-7.13.5.zip' # x64
  checksum64     = '56BC62BC99F43DD9D0FEEB27C6BCB241DEA4D60A0381CECAB311FBEF66E8C971'
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

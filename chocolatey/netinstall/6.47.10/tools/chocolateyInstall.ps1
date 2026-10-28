$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.47.10 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.47.10/netinstall-6.47.10.zip'   # x86, HTTPS preferred
  checksum       = 'B54ADA121882C0942D70F456FBA954666E6EE2A2CCA77E0EA4973CBFA8660C85'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.47.10/netinstall64-6.47.10.zip' # x64
  checksum64     = '7AF60AB36FF49FC4AD5A417E507D048CEB3343BDD84A13BCFBCBEAAD9D6950BD'
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

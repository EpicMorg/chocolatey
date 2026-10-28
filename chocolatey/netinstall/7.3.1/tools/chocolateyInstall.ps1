$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.3.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.3.1/netinstall-7.3.1.zip'   # x86, HTTPS preferred
  checksum       = 'CA729B4AC93E98D75C72B766399117D6FCC37EF5A7256755E1EE2D09C14A871F'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.3.1/netinstall64-7.3.1.zip' # x64
  checksum64     = 'C5FD62159A02CDA7889F5D5D2DBFDEBBF8C388DB2BD55FFB94AE061412C831D6'
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

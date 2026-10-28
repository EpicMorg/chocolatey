$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.48.7 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.48.7/netinstall-6.48.7.zip'   # x86, HTTPS preferred
  checksum       = '1F03495EA7A1EB9CB2D46EE7BC3E63DBEBD89299F3FA47DA9B53F1D7A6156B28'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.48.7/netinstall64-6.48.7.zip' # x64
  checksum64     = '9F19B5527EDBED6D39478919BC927E7CBD1EC8720085702D84F835725F7FAAD4'
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

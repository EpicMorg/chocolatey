$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.48.4 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.48.4/netinstall-6.48.4.zip'   # x86, HTTPS preferred
  checksum       = '8C0FA6F9377C01181270B694FBF2208F1F146A8468ADE093027E69F894A5505F'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.48.4/netinstall64-6.48.4.zip' # x64
  checksum64     = 'F7B0AD8DF58CFAE80533615340085E0732201D46F0596DD7CC49272D3057DFC8'
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

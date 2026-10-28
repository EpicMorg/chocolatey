$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.11.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.11.1/netinstall-7.11.1.zip'   # x86, HTTPS preferred
  checksum       = '3AD65C31736C9F313EE080577E54B0BE22B9220AB5CB21F2177AD02F38ECC1C2'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.11.1/netinstall64-7.11.1.zip' # x64
  checksum64     = 'D814B734D59BCCDDE5B11D56E381AF948A8479A65677DF6443C858F9C2289137'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.12 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.12/netinstall-7.12.zip'   # x86, HTTPS preferred
  checksum       = '5F0FBA757665EDE66643312E919D30884DEB27941FBE520F6BD68E536722442D'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.12/netinstall64-7.12.zip' # x64
  checksum64     = '24359CA27652B9DD323BBE76B65F9783915202D41E4F92C0CB4CB013CCD44374'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

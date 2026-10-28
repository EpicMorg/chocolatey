$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.11.3 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.11.3/netinstall-7.11.3.zip'   # x86, HTTPS preferred
  checksum       = 'EF843DB5DD6B31F19BD0BBF63678D44A4C21B5E857F382134B3424E101513FE2'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.11.3/netinstall64-7.11.3.zip' # x64
  checksum64     = '4697512B00A4DC643F3858F8CFCFC504428D66A6EA900C5113E4DED4AD4A3FE6'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

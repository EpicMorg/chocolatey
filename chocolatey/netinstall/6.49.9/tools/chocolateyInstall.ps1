$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 6.49.9 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/6.49.9/netinstall-6.49.9.zip'   # x86, HTTPS preferred
  checksum       = '9D1A968513F846631962809E3852C8C8BCF3A5D7FED086A882469438C32F24F7'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/6.49.9/netinstall64-6.49.9.zip' # x64
  checksum64     = 'B08D02C0FAEDE6B258C07B13A4AA56CC66D5BA5047F65F308D0EA1967B3F7CD8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.10.1 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.10.1/netinstall-7.10.1.zip'   # x86, HTTPS preferred
  checksum       = 'D1CAD645E63C65353A8B36C51CF7962057A657348AC0255B70F2E0A4EB5C8693'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.10.1/netinstall64-7.10.1.zip' # x64
  checksum64     = 'BA63232360E2C8C301F95718FE015377B7E1237E81EE126DAF62937B244FB392'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

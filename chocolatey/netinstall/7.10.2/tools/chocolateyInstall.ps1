$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# From download.mikrotik.com, RouterOS 7.10.2 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.10.2/netinstall-7.10.2.zip'   # x86, HTTPS preferred
  checksum       = '6A9FE9E6E1E1FE07266682F6DE964EBA7C87DF6021EB2795A9F68AF63121BFE1'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.10.2/netinstall64-7.10.2.zip' # x64
  checksum64     = '9F5E35630647202FD92FBF4049D6B0E214B89D66ED55EC5E4D05AA77B1623380'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# This version's archives keep the exe in a netinstall(64)-<ver>\ subfolder, so
# search for it. Rename netinstall64.exe so the shim Chocolatey auto-generates
# after this script is always `netinstall`, matching the x86 build.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'netinstall64.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'netinstall.exe') -Force
}

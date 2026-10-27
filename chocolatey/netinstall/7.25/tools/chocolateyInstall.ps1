$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.Netinstall` 7.25 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.25/netinstall-7.25.zip'   # x86, HTTPS preferred
  checksum       = '7550E19D9B5C478C0CE4290851DE0CE5BD6E1CDF8DFD151465252A3526CA92F4'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.25/netinstall64-7.25.zip' # x64
  checksum64     = '2387C321381116702D85A7876C82277752E933A6231EA7B443B339A87B0EA2E3'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

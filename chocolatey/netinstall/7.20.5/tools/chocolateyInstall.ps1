$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.Netinstall` 7.20.5 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.20.5/netinstall-7.20.5.zip'   # x86, HTTPS preferred
  checksum       = '03E1B573790C8DC341A34C0AF434FF48FCE9AAE6436DD77B61221FA8DA73AF6B'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.20.5/netinstall64-7.20.5.zip' # x64
  checksum64     = '185A39109B4CC01DB014D7AB0E4D38A452A3B6960F034BB34322D94BF3112998'
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

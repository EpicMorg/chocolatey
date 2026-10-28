$ErrorActionPreference = 'Stop'

$packageName = 'netinstall'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Backported from winget `Mikrotik.Netinstall` 7.24.4 (InstallerType: zip, nested portable exe).
# x86 zip holds netinstall.exe, x64 zip holds netinstall64.exe — Choco auto-shims the .exe(s)
# found under the package tools dir after extraction.
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://download.mikrotik.com/routeros/7.24.4/netinstall-7.24.4.zip'   # x86, HTTPS preferred
  checksum       = 'A178FB8046F244EE02ACCBA5FBE102677139748CB3B49CA47A632FBF24CD4427'
  checksumType   = 'sha256'
  url64bit       = 'https://download.mikrotik.com/routeros/7.24.4/netinstall64-7.24.4.zip' # x64
  checksum64     = '669E605308143E09BCEE842D731FC5438FA07CCB96D70327C7BDEDE6B0DCD46C'
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

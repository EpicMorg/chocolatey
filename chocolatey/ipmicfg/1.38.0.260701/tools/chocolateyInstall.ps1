$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMICFG 1.38.0 build 260701.
# Downloaded over HTTPS from Supermicro's official server and checked against the
# pinned sha256.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/Bios/sw_download/1159/IPMICFG_1.38.0_build.260701.zip'
  unzipLocation  = $toolsDir
  checksum       = '2397E90779749FA62531DC1CCB3A77180FB64483F21649001AACFF5EC8D519B7'
  checksumType   = 'sha256'
  specificFolder = "IPMICFG_1.38.0_build.260701\Windows\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

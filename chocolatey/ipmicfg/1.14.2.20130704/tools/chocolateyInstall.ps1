$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Historical IPMICFG 1.14.2 build 20130704, downloaded over HTTPS from Supermicro's
# official mirror and verified against the sha256 in Supermicro's CheckSum.txt.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/wdl/utility/IPMICFG/Previous%20Releases/ipmicfg_1.14.2_20130704.zip'
  unzipLocation  = $toolsDir
  checksum       = 'FED36D52342517D19AA0342A41F83D67CBA469F02C4E08507B866F723B97BC51'
  checksumType   = 'sha256'
  specificFolder = "ipmicfg_1.14.2_20130704\win\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

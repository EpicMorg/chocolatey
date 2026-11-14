$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Historical IPMICFG 1.24.0 build 20160105, downloaded over HTTPS from Supermicro's
# official mirror and verified against the sha256 in Supermicro's CheckSum.txt.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/wdl/utility/IPMICFG/Previous%20Releases/IPMICFG_1.24.0_general_20160105.zip'
  unzipLocation  = $toolsDir
  checksum       = '6DDD1B6C9FA66CFC51CA806956F04C0C941581FF3FA86E691B3B277D582CDBBF'
  checksumType   = 'sha256'
  specificFolder = "IPMICFG_1.24.0_general_20160105\win\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

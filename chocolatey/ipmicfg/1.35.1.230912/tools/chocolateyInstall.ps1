$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Fixed up from the old package: FTP is gone, so download over HTTPS from the
# official Supermicro mirror and verify against the sha256 Supermicro publishes
# in its own CheckSum.txt. Only the matching-bitness Windows folder is extracted;
# Chocolatey auto-shims IPMICFG-Win.exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/wdl/utility/IPMICFG/IPMICFG_1.35.1_build.230912.zip'
  unzipLocation  = $toolsDir
  checksum       = '06A6FA433413EA778FA47DA7A68F14FC4BCD8050955B4D34D5159DDE2843FCDB'
  checksumType   = 'sha256'
  specificFolder = "IPMICFG_1.35.1_build.230912\Windows\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

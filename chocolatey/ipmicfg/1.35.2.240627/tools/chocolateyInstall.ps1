$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMICFG 1.35.2 build 240627.
# Downloaded over HTTPS from Supermicro's official server and checked against the
# pinned sha256.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/Bios/sw_download/760/IPMICFG_1.35.2_build.240627.zip'
  unzipLocation  = $toolsDir
  checksum       = '5CB3DAD030680772AC6160F9826F3BAABA10ABA2072CB9D5EC8E4A4DB94E81DA'
  checksumType   = 'sha256'
  specificFolder = "IPMICFG_1.35.2_build.240627\Windows\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMICFG 1.37.0 build 250723.
# Downloaded over HTTPS from Supermicro's official server and checked against the
# pinned sha256.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/Bios/sw_download/965/IPMICFG_1.37.0_build.250723.zip'
  unzipLocation  = $toolsDir
  checksum       = 'CC3D15F77C8F56C18B99AA1C5289058F7591DAF30C57578E1073805B29E51945'
  checksumType   = 'sha256'
  specificFolder = "IPMICFG_1.37.0_build.250723\Windows\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

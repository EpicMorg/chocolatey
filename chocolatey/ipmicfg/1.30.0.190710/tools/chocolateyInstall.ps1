$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Historical IPMICFG 1.30.0 build 190710, downloaded over HTTPS from Supermicro's
# official mirror and verified against the sha256 in Supermicro's CheckSum.txt.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  url            = 'https://www.supermicro.com/wdl/utility/IPMICFG/Previous%20Releases/IPMICFG_1.30.0_build.190710.zip'
  unzipLocation  = $toolsDir
  checksum       = '43066F6682F13586A25D6020D0D6EC5252D7B83983380A580E95CA59B010DB7C'
  checksumType   = 'sha256'
  options        = @{ Headers = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36'; 'Referer' = 'https://www.supermicro.com/' } }
  specificFolder = "IPMICFG_1.30.0_build.190710\Windows\${bitness}bit"
}

Install-ChocolateyZipPackage @packageArgs

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

$ErrorActionPreference = 'Stop'

$bitness  = Get-ProcessorBits
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMICFG 1.14.2 build 20130704. The official, unmodified Supermicro archive is
# embedded in this package (redistributed with Supermicro's permission), so the
# install does not depend on Supermicro's download server. See legal\VERIFICATION.txt.
# Only the matching-bitness Windows folder is extracted; Choco auto-shims the exe.
$packageArgs = @{
  packageName    = "$env:chocolateyPackageName"
  fileFullPath   = Join-Path $toolsDir 'ipmicfg_1.14.2_20130704.zip'
  destination    = $toolsDir
  specificFolder = "ipmicfg_1.14.2_20130704\win\${bitness}bit"
}

Get-ChocolateyUnzip @packageArgs

# The archive is no longer needed once extracted.
Remove-Item -LiteralPath $packageArgs.fileFullPath -Force -ErrorAction SilentlyContinue

# Expose one stable command across every version: the shipped binary is named
# IPMICFG-Win.exe (older builds: ipmicfg-win.exe), so Chocolatey would otherwise
# shim it under that varying name. Rename it to ipmicfg.exe → the auto-generated
# shim is always `ipmicfg`.
Get-ChildItem -Path $toolsDir -Recurse -Filter 'ipmicfg-win.exe' | ForEach-Object {
  Move-Item -LiteralPath $_.FullName -Destination (Join-Path $_.Directory.FullName 'ipmicfg.exe') -Force
}

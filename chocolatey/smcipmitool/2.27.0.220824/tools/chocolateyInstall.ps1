$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.27.0 build 220824. Supermicro ships it as a portable ZIP (~115 MB) with its
# own Java runtime. The ZIP is downloaded from Supermicro's download center, checked
# against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/472/SMCIPMITool_2.27.0_build.220824_bundleJRE_Windows.zip'
  checksum      = 'DD6E019AFE5DE9FCF7A0459D0FF512D17A255879FCBC324E29D7419539F9B549'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

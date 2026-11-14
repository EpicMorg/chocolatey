$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.29.0 build 250214. Supermicro ships it as a portable ZIP (~115 MB) with its
# own Java runtime. The ZIP is downloaded from Supermicro's download center, checked
# against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/887/SMCIPMITool_2.29.0_build.250214_bundleJRE_Windows.zip'
  checksum      = '7F13960E7D4F493CBA435C953F7B5698432B5290D4C6679EAAD2F406AF8163E8'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

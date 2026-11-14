$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.27.3 build 230921. Supermicro ships it as a portable ZIP (~115 MB) with its
# own Java runtime. The ZIP is downloaded from Supermicro's download center, checked
# against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/648/SMCIPMITool_2.27.3_build.230921_bundleJRE_Windows.zip'
  checksum      = '324751FFF72A83545062D260026232BC2EC4E2E8AACD89886B5F22B312E68AFA'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

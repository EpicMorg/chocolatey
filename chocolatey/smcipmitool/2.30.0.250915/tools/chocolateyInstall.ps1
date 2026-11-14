$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.30.0 build 250915. Supermicro ships it as a portable ZIP (~99 MB) with its
# own Java runtime. The ZIP is downloaded from Supermicro's download center, checked
# against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/993/SMCIPMITool_2.30.0_build.250915_bundleJRE_Windows.zip'
  checksum      = 'FE3D2B9AA4A8B070529D92DE4DB4D0B56E0978A66C66EB405F19B6E1F43F3A74'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

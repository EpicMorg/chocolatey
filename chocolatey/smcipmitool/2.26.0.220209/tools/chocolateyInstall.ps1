$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.26.0 build 220209. Supermicro ships it as a portable ZIP (~116 MB) with its
# own Java runtime. The ZIP is downloaded from Supermicro's download center, checked
# against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://www.supermicro.com/Bios/sw_download/401/SMCIPMITool_2.26.0_build.220209_bundleJRE_Windows.zip'
  checksum      = '6374082E8E331614F588D75A5092CDABB14802E2FBF3B80FDAD54D947665E82D'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

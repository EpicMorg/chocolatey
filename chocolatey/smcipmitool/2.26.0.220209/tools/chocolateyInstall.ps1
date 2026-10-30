$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# SMCIPMITool 2.26.0 build 220209. The official, unmodified Supermicro archive (portable,
# with its own Java runtime) is embedded in this package (redistributed with
# Supermicro's permission), so the install does not depend on Supermicro's download
# server. See legal\VERIFICATION.txt.
$zip = Join-Path $toolsDir 'SMCIPMITool_2.26.0_build.220209_bundleJRE_Windows.zip'

Get-ChocolateyUnzip -FileFullPath $zip -Destination $toolsDir -PackageName "$env:ChocolateyPackageName"

# The archive is no longer needed once extracted.
Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue

# Chocolatey shims every .exe in the package. Only SMCIPMITool.exe should be on the
# PATH: the bundled JRE (java.exe, keytool.exe, ...) and stunnel.exe must not shadow
# the user's own tools, so they get .ignore files.
Get-ChildItem -Path $toolsDir -Recurse -Filter '*.exe' |
  Where-Object { $_.Name -ne 'SMCIPMITool.exe' } |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

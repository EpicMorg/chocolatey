$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# IPMIView 2.21.1 build 230720. The official, unmodified Supermicro archive is embedded in
# this package (redistributed with Supermicro's permission), so the install does not
# depend on Supermicro's download server. See legal\VERIFICATION.txt.
# The ZIP holds a single InstallAnywhere installer EXE with its own bundled JRE.
$zip = Join-Path $toolsDir 'IPMIView_2.21.1_build.230720_Windows.zip'

Get-ChocolateyUnzip -FileFullPath $zip -Destination $toolsDir -PackageName "$env:ChocolateyPackageName"

# The archive is no longer needed once extracted.
Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue

$installer = Join-Path $toolsDir 'IPMIView_2.21.1_build.230720_Windows.exe'

Install-ChocolateyInstallPackage -PackageName "$env:ChocolateyPackageName" `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

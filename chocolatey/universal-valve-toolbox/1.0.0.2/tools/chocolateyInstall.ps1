$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Universal Valve Toolbox 1.0.0.2: the official release zip from GitHub (.NET Framework 4.8, WinForms),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName"
  unzipLocation = $toolsDir
  url           = 'https://github.com/EpicMorg/UniversalValveToolbox/releases/download/1.0.0.2/EpicMorg-UniversalValveToolbox-1.0.0.2-Release.zip'
  checksum      = '493FF864A09BCB6F95D4E6FAE456DE23651B8445B8631D84BF969289CE489D13'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$appDir = Join-Path $toolsDir 'EpicMorg-UniversalValveToolbox-1.0.0.2-Release'
New-Item -ItemType File -Path (Join-Path $appDir 'UniversalValveToolbox.exe.gui') -Force | Out-Null

# The toolbox writes settings.json and projects into json\ next to the exe: let users write there
# and bring back what chocolateyBeforeModify.ps1 saved from the previous version.
$jsonDir = Join-Path $appDir 'json'
$backup = Join-Path $env:ProgramData 'EpicMorg\UniversalValveToolbox'
foreach ($item in 'settings.json', 'projects') {
  $saved = Join-Path $backup $item
  if (Test-Path -LiteralPath $saved) { Copy-Item -LiteralPath $saved -Destination $jsonDir -Recurse -Force }
}
& icacls.exe $jsonDir /grant '*S-1-5-32-545:(OI)(CI)M' /T /Q | Out-Null

$programs = [Environment]::GetFolderPath('CommonPrograms')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Universal Valve Toolbox.lnk') `
  -TargetPath (Join-Path $appDir 'UniversalValveToolbox.exe') -WorkingDirectory $appDir

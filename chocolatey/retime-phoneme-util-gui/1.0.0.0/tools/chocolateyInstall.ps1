$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Retime Phoneme Util GUI 1.0.0.0: the official win10 release zips from GitHub (self-contained .NET 7),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/AntinomyCollective/Retime-Phoneme-Util-GUI/releases/download/1.0.0.0/1.0.0.0.win10-x86.zip'
  checksum       = 'CD0BC1F3A9460B6B3EC654F249EC424F7183CE7FA8D850CDF053412B2C94B8CD'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AntinomyCollective/Retime-Phoneme-Util-GUI/releases/download/1.0.0.0/1.0.0.0.win10-x64.zip'
  checksum64     = '95D408EE6290FD7ADDBD1FD259015416ABA0BDA6D23A9298112B46C83BDB0B13'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# kru.gui.exe is the GUI (shim without console); the bundled console tool is run by it, not shimmed.
New-Item -ItemType File -Path (Join-Path $toolsDir 'kru.gui.exe.gui') -Force | Out-Null
Get-ChildItem -LiteralPath (Join-Path $toolsDir 'Tools') -Recurse -Filter '*.exe' |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

$programs = [Environment]::GetFolderPath('CommonPrograms')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Retime Phoneme Util GUI.lnk') `
  -TargetPath (Join-Path $toolsDir 'kru.gui.exe') -WorkingDirectory $toolsDir

$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Retime Phoneme Util GUI 1.1.0.0: the official win10 release zips from GitHub (self-contained .NET 7),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/AntinomyCollective/Retime-Phoneme-Util-GUI/releases/download/1.1.0.0/1.1.0.0.win10-x86.zip'
  checksum       = '52B8D710585A180FD358AA31938E9B2EAA656703DA12E3FFF7BB1D9DDC7763E2'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AntinomyCollective/Retime-Phoneme-Util-GUI/releases/download/1.1.0.0/1.1.0.0.win10-x64.zip'
  checksum64     = 'D7F68EC90754773833A9406116C355F45FAB434376683F8684E792C119B24627'
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

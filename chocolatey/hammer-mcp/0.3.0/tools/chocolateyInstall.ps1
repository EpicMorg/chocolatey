$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.3.0: the official release zips from GitHub (self-contained .NET 10, Windows 10/11 x86 / x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.3.0/hammer-mcp-v0.3.0-win-x86.zip'
  checksum       = '1786B0347A05BCD9C9E8F1190C87F4DEB0539030C920A794C76F6FE0C4FF80FB'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.3.0/hammer-mcp-v0.3.0-win-x64.zip'
  checksum64     = '7448B5E6514E2DC822541EAC3CF84F1305F5391D255BEA5602F38D5BA768DC09'
  checksumType64 = 'sha256'
}

# The 32-bit build also works with a 64-bit Hammer.
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console).
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

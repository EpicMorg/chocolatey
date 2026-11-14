$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.1.0-alpha: the official release zips from GitHub (self-contained .NET 10, Windows 10/11 x86 / x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.1.0-alpha/hammer-mcp-v0.1.0-alpha-win-x86.zip'
  checksum       = 'FC877B22FC756A49F8647BA20EAB812C7665BCEF84F3142597C544807C0F2D9E'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.1.0-alpha/hammer-mcp-v0.1.0-alpha-win-x64.zip'
  checksum64     = 'F202498017014BF946A980D4E5594F70FF5B7278C1A497B88670955EA90BB724'
  checksumType64 = 'sha256'
}

# The 32-bit build also works with a 64-bit Hammer.
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console).
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.2.0: the official release zip from GitHub (self-contained .NET 10, Windows 10/11 x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.2.0/hammer-mcp-v0.2.0-win-x64.zip'
  checksum64     = '7150041FA8F8F73344096896C8EF81CA3F497D69D11F2AFADE643409DB34493A'
  checksumType64 = 'sha256'
}

if ((Get-OSArchitectureWidth) -ne 64) { throw 'Hammer-MCP needs 64-bit Windows 10/11.' }
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console).
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

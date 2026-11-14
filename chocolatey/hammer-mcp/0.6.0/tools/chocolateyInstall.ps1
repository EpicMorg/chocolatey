$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.6.0: the official release zip from GitHub (self-contained .NET 10, Windows 10/11 x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.6.0/hammer-mcp-v0.6.0-win-x64.zip'
  checksum64     = 'A5682A80C5175E128FCE37362B262FC5A01D6BA3D47F298629FD70DC43B8ABB4'
  checksumType64 = 'sha256'
}

if ((Get-OSArchitectureWidth) -ne 64) { throw 'Hammer-MCP needs 64-bit Windows 10/11.' }
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console); hammer-mcp-cli.exe is the console server.
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

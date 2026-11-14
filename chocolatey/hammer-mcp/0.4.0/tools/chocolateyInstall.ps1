$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.4.0: the official release zips from GitHub (self-contained .NET 10, Windows 10/11 x86 / x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.4.0/hammer-mcp-v0.4.0-win-x86.zip'
  checksum       = 'C9515C3A44CA9A0CE12C5F7234DBD78E41269EB69F83D1B96772DA48E69CE43B'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.4.0/hammer-mcp-v0.4.0-win-x64.zip'
  checksum64     = '8BDB28D6AE9ACBDE3A6C2603EEDC3F78251867EB4B0E5BDEA1BDCFA14D654B77'
  checksumType64 = 'sha256'
}

# The 32-bit build also works with a 64-bit Hammer.
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console).
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

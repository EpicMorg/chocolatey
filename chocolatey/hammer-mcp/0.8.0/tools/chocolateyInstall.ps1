$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.8.0: the official release zips from GitHub (self-contained .NET 10, Windows 10/11 x86 / x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.8.0/hammer-mcp-v0.8.0-win-x86.zip'
  checksum       = '36AAB76126F2710A775744F0BAE8FA8DD3766B0749C9F87B7AA520B35A56D13C'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.8.0/hammer-mcp-v0.8.0-win-x64.zip'
  checksum64     = '939D7287C989084A9F3F00EC32DB899CDE5D86DAA8B821DC6A2FB4593A45B643'
  checksumType64 = 'sha256'
}

# The 32-bit build also works with a 64-bit Hammer.
Install-ChocolateyZipPackage @packageArgs

# hammer-mcp.exe is the tray app (GUI shim, no console); hammer-mcp-cli.exe is the console server.
New-Item -ItemType File -Path (Join-Path $toolsDir 'hammer-mcp.exe.gui') -Force | Out-Null
# native\ (adapter DLLs, hmcp-injector32/64.exe) must stay next to the exe; the injectors are run by the app only.
Get-ChildItem -LiteralPath (Join-Path $toolsDir 'native') -Filter '*.exe' |
  ForEach-Object { New-Item -ItemType File -Path "$($_.FullName).ignore" -Force | Out-Null }

$programs = [Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'Hammer-MCP.lnk') `
  -TargetPath (Join-Path $toolsDir 'hammer-mcp.exe') -WorkingDirectory $toolsDir

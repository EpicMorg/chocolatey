$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Hammer-MCP 0.7.0: the official release zips from GitHub (self-contained .NET 10, Windows 10/11 x86 / x64),
# checked against the sha256 below and extracted into the package folder.
$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  unzipLocation  = $toolsDir
  url            = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.7.0/hammer-mcp-v0.7.0-win-x86.zip'
  checksum       = '8E7C12A8E26D020B2E88902D2F20B43F264F898D9D14B960DA4928CAAE11241F'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/EpicMorg/Hammer-MCP/releases/download/v0.7.0/hammer-mcp-v0.7.0-win-x64.zip'
  checksum64     = '66B2436365755EB515D031A5D349D13842EF075FEF42AACBBC5C6BB765C287F7'
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

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'atlassian-downloader'
$folderName =  Join-Path $toolsDir 'Atlassian Downloader'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.9/atlassian-downloader-dotnet10.0-win-x86.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.9/atlassian-downloader-dotnet10.0-win-x64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '03FE25ECEE20A454EDE42780196261635F39B49341F8F271E0ED565A5B225A10'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '39D06E09CFEE7A9C68B5515B97E6B2ADB5917A19502FE4CF9229803A369DA39B'
  checksumType64= 'sha256'
}

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

################################################################################
# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
################################################################################
Install-ChocolateyZipPackage @packageArgs 

################################################################################
# Install  shortcuts
################################################################################
$atlDwnldrShimm = Join-Path $chocoRootBin 'atlassian-downloader.exe'
Write-Host "atlDwnldrShimm: $atlDwnldrShimm"

$ProgramsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

$shortcutFilePathProgramsPath = Join-Path $ProgramsPath "Atlassian Downloader.lnk"
$shortcutFilePathDesktopPath = Join-Path $DesktopPath "Atlassian Downloader.lnk"

Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathProgramsPath -targetPath $atlDwnldrShimm
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathDesktopPath -targetPath $atlDwnldrShimm
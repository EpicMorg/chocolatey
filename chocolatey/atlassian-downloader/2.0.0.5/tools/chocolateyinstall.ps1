$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'atlassian-downloader'
$folderName =  Join-Path $toolsDir 'Atlassian Downloader'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.5/atlassian-downloader-net9.0-win-x86.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.5/atlassian-downloader-net9.0-win-x64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'cb0440ba31795368be9040c6fc7dfbca60544e86a513a41b5275e2d905a4171f'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '960b746948137571c09958e7ec3dc3914efa33d6f52ec0a8530a3bb086553bd0'
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
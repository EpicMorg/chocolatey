$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'atlassian-downloader'
$folderName =  Join-Path $toolsDir 'Atlassian Downloader'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/1.0.0.9/atlassian-downloader-net6.0-win7-x86.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/1.0.0.9/atlassian-downloader-net6.0-win7-x64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '6913B1F472023D15978E33302CC5879A86844EA620FAA14CD9DC97C9EF377295'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '1F248739F6FC10A83F33C30DA6F2FE413E0156C126AF488D1B7595B160989A3B'
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
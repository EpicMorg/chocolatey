$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'atlassian-downloader'
$folderName =  Join-Path $toolsDir 'Atlassian Downloader'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.1/atlassian-downloader-net8.0-win-x86.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/atlassian-downloader/releases/download/2.0.0.1/atlassian-downloader-net8.0-win-x64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '20F4BB24FCDD6DBF0B9B8D330F44721C17B990910FA2F319512E4B41493A1CEE'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = 'D37602FD1D0E737C6A225BD11138C4F81E8F77215AF35758155F4C43D1D7A9F0'
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
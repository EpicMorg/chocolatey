$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://airtestproject.s3.netease.com/downloads/AirtestIDE/win32/AirtestIDE-win-1.2.13.zip' # download url, HTTPS preferred
  url64bit      = 'https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.13.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'A607F4C5A3B757551D79A1C06912373145C259C2F2E1527F132B21700086D63C'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = 'BD9C054AD282D9662EE995440B8E29E316EBBA50770DB695908B4D79A7EC2CC0'
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
$airtestShimm = Join-Path $chocoRootBin 'AirtestIDE.exe'
Write-Host "airtestShimm: $airtestShimm"

$ProgramsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

$shortcutFilePathProgramsPath = Join-Path $ProgramsPath "AirtestIDE.lnk"
$shortcutFilePathDesktopPath = Join-Path $DesktopPath "AirtestIDE.lnk"

Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathProgramsPath -targetPath $airtestShimm
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathDesktopPath -targetPath $airtestShimm
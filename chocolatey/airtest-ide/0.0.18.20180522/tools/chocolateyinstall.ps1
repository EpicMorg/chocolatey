$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://top.gdl.netease.com/AirtestIDE_2018-05-22_18.zip' # download url, HTTPS preferred
  url64bit      = 'https://top.gdl.netease.com/AirtestIDE_2018-05-22_18.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '2CF4C8DA42D3D49AB3CE2616A255F95168065F820AFF850AA77B177E1C86680F'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '2CF4C8DA42D3D49AB3CE2616A255F95168065F820AFF850AA77B177E1C86680F'
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
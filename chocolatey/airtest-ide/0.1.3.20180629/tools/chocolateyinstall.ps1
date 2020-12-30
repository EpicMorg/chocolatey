$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://top.gdl.netease.com/AirtestIDE_2018-06-29_py3_win32.zip' # download url, HTTPS preferred
  url64bit      = 'https://top.gdl.netease.com/AirtestIDE_2018-06-29_py3_win64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '20503A34AD05426F59D4F034FB7069A7EE168F3D19B9328B82C7D75D136FCF69'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '8CBD85AA9043C4BEE081D20D1BBE7ADD663CC513BE18E2637F785FB7AF7D06BC'
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
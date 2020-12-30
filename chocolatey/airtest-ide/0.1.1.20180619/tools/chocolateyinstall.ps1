$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://top.gdl.netease.com/AirtestIDE_2018-06-19_py3_win32.zip' # download url, HTTPS preferred
  url64bit      = 'https://top.gdl.netease.com/AirtestIDE_2018-06-19_py3_win64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'E979F831B8BE5FAE5811B7B5B20C9C42DF7F663A8D1354DFF146EF4965AD4250'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = 'F1F6FF9E9B68B4AC9EC5D33223057AF36C6F0697B5932C5A515FCC69F98832CE'
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
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://airtestproject.s3.netease.com/downloads/AirtestIDE/win32/AirtestIDE-win-1.2.12.zip' # download url, HTTPS preferred
  url64bit      = 'https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.12.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'A988E1BBDDC2E4F2B47C5BC1F4DB9D3A7502B7EAE312F32D29332D489FEA0E80'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '8AD52B7B0518ADA37153C95DEDE64B35BACBBBE4466890C7E6F1A007C0EF5637'
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
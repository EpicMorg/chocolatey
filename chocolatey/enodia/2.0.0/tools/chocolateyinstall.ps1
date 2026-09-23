$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'enodia'
$folderName =  Join-Path $toolsDir 'Enodia'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/enodia/releases/download/2.0.0%2B0/enodia_windows_386.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/enodia/releases/download/2.0.0%2B0/enodia_windows_amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '93b7e4bc0f721ef244ded733ef7a0b86081c4513e33283a58593f05bcb315531'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '2de269391eb0ba4ed381060e78bb461bde2540d605078ac82747ce0a0f623f3d'
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
$enodiaDwnldrShimm = Join-Path $chocoRootBin 'enodia.exe'
Write-Host "enodiaDwnldrShimm: $enodiaDwnldrShimm"

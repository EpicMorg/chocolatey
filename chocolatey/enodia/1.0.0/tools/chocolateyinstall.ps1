$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'enodia'
$folderName =  Join-Path $toolsDir 'Enodia'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/enodia/releases/download/1.0.0%2B0/enodia_windows_386.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/enodia/releases/download/1.0.0%2B0/enodia_windows_amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '3d60eaa44ecb9791cc5bff9e06a91f91870260beed74ba9d017440bc010fa412'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = 'b6b07f0a5b5eb61822511828f7e128868848a9ed65577bd6ae522ae62d02da87'
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

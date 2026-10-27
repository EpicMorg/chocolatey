$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'enodia'
$folderName =  Join-Path $toolsDir 'Enodia'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/enodia/releases/download/2.2.0%2B0/enodia_windows_386.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/enodia/releases/download/2.2.0%2B0/enodia_windows_amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'f00e5dbb52146a9c1c850a6727fbcb9e102f1317c3aa29c4810c86599dd32a7f'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '580189f72a6606d865dd3d6e35b5ff7047c88480d582686b49587ff950ddf0e5'
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

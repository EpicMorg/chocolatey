$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'enodia'
$folderName =  Join-Path $toolsDir 'Enodia'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/enodia/releases/download/2.2.1%2B0/enodia_windows_386.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/enodia/releases/download/2.2.1%2B0/enodia_windows_amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = 'da295586b0a0e6e6866475834205bca7d166256502cb2af2999b728bb8be7cca'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = 'e51032a21bacb032a3f583ba40c516fcc106cf0ecf3de3bf2ca03178c9cb25ea'
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

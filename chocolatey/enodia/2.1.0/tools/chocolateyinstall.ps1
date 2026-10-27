$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';

$packageName= 'enodia'
$folderName =  Join-Path $toolsDir 'Enodia'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $folderName
  url           = 'https://github.com/EpicMorg/enodia/releases/download/2.1.0%2B0/enodia_windows_386.zip' # download url, HTTPS preferred
  url64bit      = 'https://github.com/EpicMorg/enodia/releases/download/2.1.0%2B0/enodia_windows_amd64.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  #destination   = Join-Path $toolsDir $folderName

  checksum      = '2f7dcc1dacc6fb44895bee732d059bc2280e5a11b5200e92eafe54752378429d'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512

  checksum64    = '350ba92ccb267b70cb4eaf3364132d37e9d2b38802c7e7f357124c5e325cbaf9'
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

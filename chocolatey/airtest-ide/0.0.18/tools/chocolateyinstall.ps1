$ErrorActionPreference = 'Stop';

[[AutomaticPackageNotesInstaller]]
$packageName= 'airtest-ide'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$fileLocation = Join-Path $toolsDir 'AirtestIDE_2018-05-22_18.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'http://top.gdl.netease.com/AirtestIDE_2018-05-22_18.zip' # download url, HTTPS preferred
  url64bit      = 'http://top.gdl.netease.com/AirtestIDE_2018-05-22_18.zip' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation
  #fileFullPath = $fileLocation
  destination   = $toolsDir

  checksum      = '09459651f7da58cd4e7d902ee79757f6506d70390aac0004158642dd3909499a'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '09459651f7da58cd4e7d902ee79757f6506d70390aac0004158642dd3909499a'
  checksumType64= 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
#Get-ChocolateyUnzip @packageArgs
$ErrorActionPreference = 'Stop'

$packageName  = 'flashfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = Join-Path $toolsDir 'flashfig.exe'

# Flashfig ships as a single portable x86 executable (no installer, no x64 build).
# Download it into the package tools dir; Chocolatey auto-shims it as `flashfig`.
$packageArgs = @{
  packageName  = $packageName
  fileFullPath = $fileFullPath
  url          = 'https://download.mikrotik.com/routeros/6.49.6/flashfig.exe' # HTTPS preferred
  checksum     = 'EFA28D09D5BBCDFF728D5D238E44406CB2384240BA4374297A50C4DCC4B21466'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

################################################################################
# Content paths
################################################################################
$toolsDir = '$(Split-Path -parent $MyInvocation.MyCommand.Definition)'
$chocoRootBin = Join-Path $($env:ChocolateyInstall) 'bin'
$ErrorActionPreference = 'Stop';
$packageName= 'airtest-ide'
$folderName =  Join-Path $toolsDir 'AirtestIDE'
$zippedfolderName = 'AirtestIDE_2018-05-22_18'
$airtestFolder = Join-Path $folderName $zippedfolderName

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

$testPath = Test-Path -Path $airtestFolder
Write-Host "AirtestIDE folder exists:" $testPath

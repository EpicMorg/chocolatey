# This runs in 0.9.10+ before upgrade and uninstall.
# Use this file to do things like stop services prior to upgrade or uninstall.
# NOTE: It is an anti-pattern to call chocolateyUninstall.ps1 from here. If you
#  need to uninstall an MSI prior to upgrade, put the functionality in this
#  file without calling the uninstall script. Make it idempotent in the
#  uninstall script so that it doesn't fail when it is already uninstalled.
# NOTE: For upgrades - like the uninstall script, this script always runs from 
#  the currently installed version, not from the new upgraded package version.

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
$ProgramsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

$airtestShimm = Join-Path $chocoRootBin 'AirtestIDE.exe'
$airtestBin = Join-Path $airtestFolder 'AirtestIDE.exe'
$adbAirtestBin Join-Path $airtestFolder 'airtest\core\android\static\adb\windows\adb.exe'
$chromedriverAirtestBin Join-Path $airtestFolder 'chromedriver.exe'
$qtWebEngineProcessAirtestBin Join-Path $airtestFolder 'QtWebEngineProcess.exe'


################################################################################
# Trying to terminate process
################################################################################
try {
 Get-Process | Where-Object {$_.Path -like $airtestShimm} | Stop-Process -WhatIf
 Write-Host 'Process $airtestShimm stopped'
}
catch {
Write-Host 'Process $airtestShimm not found. Skipping.'
}


try {
 Get-Process | Where-Object {$_.Path -like $airtestBin} | Stop-Process -WhatIf
 Write-Host 'Process $airtestBin stopped'
}
catch {
Write-Host 'Process $airtestBin not found. Skipping.'
}

try {
 Get-Process | Where-Object {$_.Path -like $adbAirtestBin} | Stop-Process -WhatIf
 Write-Host 'Process $adbAirtestBin stopped'
}
catch {
Write-Host 'Process adbAirtestBin not found. Skipping.'
}

try {
 Get-Process | Where-Object {$_.Path -like $chromedriverAirtestBin} | Stop-Process -WhatIf
 Write-Host 'Process $chromedriverAirtestBin stopped'
}
catch {
Write-Host 'Process chromedriverAirtestBin not found. Skipping.'
}

try {
 Get-Process | Where-Object {$_.Path -like $qtWebEngineProcessAirtestBin} | Stop-Process -WhatIf
 Write-Host 'Process $qtWebEngineProcessAirtestBin stopped'
}
catch {
Write-Host 'Process qtWebEngineProcessAirtestBin not found. Skipping.'
}

################################################################################
# Trying to remove shortcuts
################################################################################
# From Programs menu
try {
 $shortcutFilePathProgramsPath = Join-Path $ProgramsPath 'AirtestIDE.lnk'
 Remove-Item -Path $shortcutFilePathProgramsPath -Force
 Write-Host 'Shortcut $shortcutFilePathProgramsPath removed.'
}
catch {
Write-Host 'Shortcut $shortcutFilePathProgramsPath not found. Skipping.'
}

# From Desktop
try {
 $shortcutFilePathDesktopPath = Join-Path $DesktopPath 'AirtestIDE.lnk'
 Remove-Item -Path $shortcutFilePathDesktopPath -Force
 Write-Host 'Shortcut $shortcutFilePathDesktopPath removed.'
}
catch {
Write-Host 'Shortcut $shortcutFilePathDesktopPath not found. Skipping.'
}

################################################################################
# Deleting directory
################################################################################
try {
 Remove-Item -Path $airtestFolder -Force
 Write-Host 'Folder $airtestFolder removed.'
}
catch {
Write-Host 'Folder $airtestFolder not found. Skipping.'
}

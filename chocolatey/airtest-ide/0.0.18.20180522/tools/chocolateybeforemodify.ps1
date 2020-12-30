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
$adbAirtestFolder = Join-Path -Path  '$airtestFolder' -ChildPath 'airtest\core\android\static\adb\windows'
$adbAirtestBin = Join-Path '$adbAirtestFolder' 'adb.exe'
$chromedriverAirtestBin = Join-Path $airtestFolder 'chromedriver.exe'
$qtWebEngineProcessAirtestBin = Join-Path $airtestFolder 'QtWebEngineProcess.exe'


################################################################################
# Trying to remove shortcuts
################################################################################
# From Programs menu
# try {
#     $shortcutFilePathProgramsPath = Join-Path $ProgramsPath 'AirtestIDE.lnk'
#     Remove-Item -Path $shortcutFilePathProgramsPath -Force
#     Write-Host 'Shortcut AirtestIDE.lnk removed.'
# }
# catch {
#     Write-Host 'Shortcut AirtestIDE.lnk not found. Skipping.'
# }
# 
# # From Desktop
# try {
#     $shortcutFilePathDesktopPath = Join-Path $DesktopPath 'AirtestIDE.lnk'
#     Remove-Item -Path $shortcutFilePathDesktopPath -Force
#     Write-Host 'Shortcut AirtestIDE.lnk removed.'
# }
# catch {
#     Write-Host 'Shortcut AirtestIDE.lnk not found. Skipping.'
# }
# 
# ################################################################################
# # Trying to terminate process
# ################################################################################
# try {
#     Get-Process | Where-Object {$_.Path -like $airtestShimm} | Stop-Process -Force
#     Write-Host 'Process AirtestIDE.exe (shimm) stopped'
# }
# catch {
#     Write-Host 'Process AirtestIDE.exe (shimm) not found. Skipping.'
# }
# 
# 
# try {
#     Get-Process | Where-Object {$_.Path -like $airtestBin} | Stop-Process -Force 
#     Write-Host 'Process AirtestIDE.exe stopped'
# }
# catch {
#     Write-Host 'Process AirtestIDE.exe not found. Skipping.'
# }
# 
# try {
#     Start-Process -FilePath $adbAirtestBin -WorkingDirectory $adbAirtestFolder  -ArgumentList "kill-sever"
#     Stop-Process -Force -Name "adb"
#     Write-Host 'Process adb.exe stopped'
# }
# catch {
#     Write-Host 'Process adb.exe not found. Skipping.'
# }
# 
# try {
#     Get-Process | Where-Object {$_.Path -like $chromedriverAirtestBin} | Stop-Process -Force
#     Write-Host 'Process chromedriver.exe stopped'
# }
# catch {
#     Write-Host 'Process chromedriver.exe not found. Skipping.'
# }
# 
# try {
#     Get-Process | Where-Object {$_.Path -like $qtWebEngineProcessAirtestBin} | Stop-Process -Force
#     Write-Host 'Process QtWebEngineProcess.exe stopped'
# }
# catch {
#     Write-Host 'Process QtWebEngineProcess.exe not found. Skipping.'
# }


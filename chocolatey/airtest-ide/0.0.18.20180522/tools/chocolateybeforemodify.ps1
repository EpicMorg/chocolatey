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

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

################################################################################
# Trying to remove shortcuts
################################################################################
# From Programs menu
try {
    $shortcutFilePathProgramsPath = Join-Path $ProgramsPath 'AirtestIDE.lnk'
    Remove-Item -Path $shortcutFilePathProgramsPath -Force
    Write-Host 'Shortcut AirtestIDE.lnk successfully removed from Start Menu.'
}
catch {
    Write-Host 'Shortcut AirtestIDE.lnk not found in Start Menu. Nothing to remove. Skipping.'
}

# From Desktop
try {
    $shortcutFilePathDesktopPath = Join-Path $DesktopPath 'AirtestIDE.lnk'
    Remove-Item -Path $shortcutFilePathDesktopPath -Force
    Write-Host 'Shortcut AirtestIDE.lnk successfully removed from Desktop.'
}
catch {
    Write-Host 'Shortcut AirtestIDE.lnk not found in Desktop. Nothing to remove. Skipping.'
}

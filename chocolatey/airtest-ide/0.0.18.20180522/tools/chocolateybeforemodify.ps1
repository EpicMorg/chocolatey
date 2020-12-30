################################################################################
# Content paths
################################################################################
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ErrorActionPreference = 'Stop';
$packageName= 'airtest-ide'
 
$folderName =  Join-Path $toolsDir 'AirtestIDE'

$ProgramsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

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

# AirtestIDE folder
try {
    remove-item -path $folderName\* -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host 'AirtestIDE folder successfully cleared.'
}
catch {
    Write-Host 'AirtestIDE folder not cleared. Something went wrong. Skipping.'
}


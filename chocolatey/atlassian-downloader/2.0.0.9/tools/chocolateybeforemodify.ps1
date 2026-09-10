################################################################################
# Content paths
################################################################################
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ErrorActionPreference = 'Stop';
$packageName= 'atlassian-downloader'
 
$folderName =  Join-Path $toolsDir 'Atlassian Downloader'

$ProgramsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

################################################################################
# Trying to remove shortcuts
################################################################################
# From Programs menu
try {
    $shortcutFilePathProgramsPath = Join-Path $ProgramsPath 'Atlassian Downloader.lnk'
    Remove-Item -Path $shortcutFilePathProgramsPath -Force
    Write-Host 'Shortcut Atlassian Downloader.lnk successfully removed from Start Menu.'
}
catch {
    Write-Host 'Shortcut Atlassian Downloader.lnk not found in Start Menu. Nothing to remove. Skipping.'
}

# From Desktop
try {
    $shortcutFilePathDesktopPath = Join-Path $DesktopPath 'Atlassian Downloader.lnk'
    Remove-Item -Path $shortcutFilePathDesktopPath -Force
    Write-Host 'Shortcut Atlassian Downloader.lnk successfully removed from Desktop.'
}
catch {
    Write-Host 'Shortcut Atlassian Downloader.lnk not found in Desktop. Nothing to remove. Skipping.'
}

# Atlassian Downloader folder
try {
    remove-item -path $folderName\* -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host 'Atlassian Downloader folder successfully cleared.'
}
catch {
    Write-Host 'Atlassian Downloader folder not cleared. Something went wrong. Skipping.'
}


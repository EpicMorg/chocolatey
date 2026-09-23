################################################################################
# Content paths
################################################################################
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ErrorActionPreference = 'Stop';
$packageName= 'enodia'
 
$folderName =  Join-Path $toolsDir 'Enodia'

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

################################################################################
# Trying to remove shortcuts
################################################################################

# Enodia folder
try {
    remove-item -path $folderName\* -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host 'Enodia folder successfully cleared.'
}
catch {
    Write-Host 'Enodia folder not cleared. Something went wrong. Skipping.'
}


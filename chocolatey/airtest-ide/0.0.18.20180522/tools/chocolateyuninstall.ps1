################################################################################
# Content paths
################################################################################
$ErrorActionPreference = 'Stop';
$packageName= 'airtest-ide'

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

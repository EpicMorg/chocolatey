################################################################################
# Content paths
################################################################################
$ErrorActionPreference = 'Stop';
$packageName= 'enodia'

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

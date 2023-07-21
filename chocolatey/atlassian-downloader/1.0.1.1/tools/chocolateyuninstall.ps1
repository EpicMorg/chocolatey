################################################################################
# Content paths
################################################################################
$ErrorActionPreference = 'Stop';
$packageName= 'atlassian-downloader'

$testProcessAdminRights = Test-ProcessAdminRights
Write-Host "ProcessAdminRights:" $testProcessAdminRights

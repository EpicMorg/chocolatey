$ErrorActionPreference = 'Stop'

$packageName = 'ipmiview'

# IPMIView registers an Add/Remove Programs entry (InstallAnywhere). Find it and
# run its uninstaller silently.
# TODO(verify on Windows): confirm the DisplayName pattern and the uninstaller's
# silent switch ('-i silent' for InstallAnywhere) on a real Windows box.
[array]$key = Get-UninstallRegistryKey -SoftwareName 'IPMIView*'

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    Uninstall-ChocolateyPackage -PackageName $packageName `
      -FileType 'exe' `
      -SilentArgs '-i silent' `
      -File "$($_.UninstallString)" `
      -ValidExitCodes @(0)
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled."
} else {
  Write-Warning "$($key.Count) matches found for '$packageName'. Please uninstall manually."
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

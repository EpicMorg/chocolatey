$ErrorActionPreference = 'Stop'

$packageName = 'thedude'

[array]$key = Get-UninstallRegistryKey -SoftwareName 'Dude*'

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    Uninstall-ChocolateyPackage -PackageName $packageName `
      -FileType 'exe' `
      -SilentArgs '/S' `         # NSIS (nullsoft) silent uninstall
      -File "$($_.UninstallString)" `
      -ValidExitCodes @(0)
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled."
} else {
  Write-Warning "$($key.Count) matches found for '$packageName'. Please uninstall manually."
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

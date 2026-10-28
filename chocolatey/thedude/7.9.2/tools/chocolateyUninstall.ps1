$ErrorActionPreference = 'Stop'

$packageName = 'thedude'

[array]$key = Get-UninstallRegistryKey -SoftwareName 'The Dude*'

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    # NSIS (nullsoft) uninstaller; UninstallString may be quoted.
    $packageArgs = @{
      packageName    = $packageName
      fileType       = 'exe'
      silentArgs     = '/S'
      file           = $_.UninstallString.Trim('"')
      validExitCodes = @(0)
    }
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled."
} else {
  Write-Warning "$($key.Count) matches found for '$packageName'. Please uninstall manually."
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

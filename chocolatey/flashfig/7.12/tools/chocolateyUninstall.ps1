$ErrorActionPreference = 'Stop'

# Portable executable package: Chocolatey removes the downloaded file and the
# auto-generated shim on uninstall. Just make sure the tool is not running.
Stop-Process -Name 'flashfig' -ErrorAction SilentlyContinue

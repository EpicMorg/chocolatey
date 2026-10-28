$ErrorActionPreference = 'Stop'

# Portable zip package: Chocolatey removes the extracted files and the auto-generated
# shims on uninstall. Just make sure the tool is not running so removal does not fail.
Stop-Process -Name 'netinstall'   -ErrorAction SilentlyContinue
Stop-Process -Name 'netinstall64' -ErrorAction SilentlyContinue

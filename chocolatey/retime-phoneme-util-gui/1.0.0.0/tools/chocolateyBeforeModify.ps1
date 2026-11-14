# The running GUI keeps its exe locked: stop it before an upgrade or uninstall.
Get-Process -Name 'kru.gui' -ErrorAction SilentlyContinue | Stop-Process -Force

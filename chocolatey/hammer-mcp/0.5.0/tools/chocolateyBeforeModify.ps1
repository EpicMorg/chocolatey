# The tray app keeps its exe locked: stop it before an upgrade or uninstall.
Get-Process -Name 'hammer-mcp', 'hammer-mcp-cli' -ErrorAction SilentlyContinue | Stop-Process -Force

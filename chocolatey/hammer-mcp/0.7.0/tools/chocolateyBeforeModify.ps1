# The tray app keeps its exe locked: stop it before an upgrade or uninstall.
Get-Process -Name 'hammer-mcp', 'hammer-mcp-cli', 'hmcp-injector32', 'hmcp-injector64' -ErrorAction SilentlyContinue | Stop-Process -Force

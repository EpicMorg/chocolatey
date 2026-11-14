## [0.6.0] - 2026-11-14

The MCP server without the tray app (`hammer-mcp-cli`, stdio / HTTP) and a container image for MCP catalogs.

### Added
- **`hammer-mcp-cli`**: the MCP server without the tray app - stdio (default) or HTTP, Hammer picked with `--auto` / `--pid`, `--mode`; shipped in the release zip. A `Dockerfile` runs it in a container (it starts and lists its tools without a Hammer - what MCP catalogs such as Glama check).

### Changed
- Public repository: status **beta**, `SECURITY.md` (private vulnerability reports), `CONTRIBUTING.md` (how to report an unknown Hammer build), issue templates, demo GIF / video and screenshots in the README, articles on the Valve Developer Community ([EN](https://developer.valvesoftware.com/wiki/Hammer_MCP_Server), [RU](https://developer.valvesoftware.com/wiki/Ru/Hammer_MCP_Server)).
- About: fixed the link to epicm.org.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

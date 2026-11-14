## [0.1.0-alpha] - 2026-11-12

First public pre-release.

### Added
- MCP server over Streamable HTTP (`/mcp`, default port 47800, Bearer token; required when not bound to localhost).
- Tray app (WinForms): pick and attach a running Hammer, start / stop the server, modes (Auto / Basic / Shell / Advanced), bind address, port, token, logs, About.
- Live editing through Hammer's shell channel (`Worldcraft_ShellMessageWnd`): `create_entity`, `set_keyvalue`, `rotate_entity`, `delete_entity` (refused when the address is ambiguous), `undo`, `redo`, `save_map`, `open_run_map_dialog`, `open_check_for_problems`.
- Reading the saved map: `hammer_status`, `map_summary`, `list_entities`.
- Embedded build registry (`registry/hammers.json`, overridable by a file next to the exe).

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

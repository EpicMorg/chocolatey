## [0.4.0] - 2026-11-13

Source 2: unsaved Hammer state through the developer console, prefabs expanded; Strata game config and autosaves.

### Added
- **Strata (Portal: Revolution)**: game config from `hammer/cfg/gameconfig.txt` (paths with `..\..` as shipped are normalised), autosave folder from `hammer/cfg/HammerConfig.vdf` (KV3) for `fromAutosave`; `revolution.fgd` reads cleanly (563 classes).
- **Source 2 developer console** (`source2_console`): allowlisted commands over VConsole2 (TCP 127.0.0.1:29000, the channel `vconsole2.exe` uses) - `hammer_map_files`, `hammer_force_autosave`, `hammer_prefab_tree`, `find`, `help`, `status`, …; nothing is injected. Verified live on CS2 (no `-vconsole` needed).
- **vmap prefabs and instances are expanded**: `CMapPrefab` (another `.vmap`, resolved in the map's mod / addon folder, then the stock mod) and `CMapInstance` with their transforms, nested up to 6 levels; their entities get ids from 1000000 and `prefab` / `prefab_node` keyvalues. Dota's `dota.vmap`: 69 entities of its own, 1734 with 67 prefabs.
- **Unsaved Source 2 state**: read tools with `fromAutosave=true` run `hammer_force_autosave` in the developer console and read the newest autosave from `content\_toolsautosave\hammer\<map folder>` (prefabs still resolved in the real content folder). The open map comes from `hammer_map_files` when the window title has none. Verified: the console works without `-vconsole` in Workshop Tools.
- Developer console output is clean: PRNT messages have a 28-byte header (channel, flags, colour, time) before the text, verified on CS2.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

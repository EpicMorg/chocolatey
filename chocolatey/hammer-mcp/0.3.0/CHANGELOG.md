## [0.3.0] - 2026-11-13

Source 2 maps and game data (read-only), verified live on CS2 Workshop Tools; stock Hammer verified live on TF2; safety rules around game processes.

### Added
- **Source 2 maps**: `.vmap` (DMX, read with KeyValues2 / Datamodel.NET) - entities in world space with keyvalues and outputs, hidden nodes, summary. `map_summary`, `list_entities`, `get_entity`, `find_io`, `validate_map` work on Source 2 maps; the world is an I/O target (prefab relays). Prefabs and instances are not expanded yet.
- **Source 2 FGD**: class metadata blocks (`{ entity_tool_name = ... }`, shown by `fgd_class`), per-member `[ ]` / `{ }` metadata, `@OverrideClass`, escaped quotes, includes from `game/core/`; model / VData / helpinfo definitions are skipped. CS2 `csgo.fgd`: 469 classes, Dota 2 `dota.fgd`: 427, no warnings.
- **Source 2 game data** without a GameConfig.txt: one config per mod with `game/<mod>/<mod>.fgd`, picked by the open map's `content/<mod>` folder (`csgo_addons` → `csgo`).
- **Source 2 Workshop Tools processes** (`cs2`, `dota2`, `hlvr`, … with `tools/hammer.dll`) are listed for Attach. The map name Hammer shows in its title is looked up in `content/<mod>/maps` and `content/<mod>_addons/<addon>/maps`.
- `hammer_status`: window title, process command line (`insecure` flag) and, for unknown builds, the editor DLL's sha256 for the registry.
- **Inject policy** for the future Advanced mode (`InjectPolicy`): only standalone Hammer executables of a known build with an adapter; never game processes (VAC / anti-cheat), never Source 2, never unknown builds.
- README: **Safety and VAC** section (EN / RU).
- Registry: the CS2 `hammer.dll` of 2026-11-13.

### Changed
- A map outside every MapDir uses the game config of the Hammer's own install (the only config whose game folder is inside it and has a gameinfo.txt, e.g. `tf` for the TF2 Hammer) instead of asking for `configName`.
- Source 2 UI and agent texts: own attach status ("read-only from map and game files"), mode help, menu tools refuse politely, agent instructions.
- Tool descriptions after the live test of stock Hammer (TF2): `set_keyvalue` is not in Hammer's undo history; `rotate_entity` only turns entities with a model - set the `angles` keyvalue for the others.
- FGD types are printed without spaces (`resource:vjs`); Source 2 editor keys (`local.origin`, `useLocalOffset`, …) are not reported as unknown keyvalues.

### Verified live
- **CS2 Workshop Tools**: attach to `cs2.exe`, a 69 MB `.vmap` (format 40) from an addon read and validated. Workshop Tools behave like an insecure client (VAC servers refused).
- **Stock Hammer TF2 x86**: create / keyvalue / delete / save over the shell channel, outputs as keyvalues, `validate_map`, `check_assets` (gameinfo + VPK), `compile_sequences` from the binary `CmdSeq.wc`.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

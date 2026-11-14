## [0.5.0] - 2026-11-14

Brush entities, outputs written as keyvalues, Source 2 prefab variables; Strata and stock TF2 Hammer verified live.

### Added
- **Brush entities** (`trigger_*`, `func_*`) are addressed by the centre of their brushes: Hammer++ and stock Hammer write it as their `origin`; for .vmf files without it the centre is computed from the brush planes (`center` in `list_entities` / `get_entity`). Verified live on Hammer++ and stock TF2 Hammer: `set_keyvalue`, outputs, and `delete_entity`, which removes the entity together with its brushes.
- **Outputs written as keyvalues**: `validate_map` lists them (`outputsAsKeyValues`) and checks their targets and inputs; `get_entity` / `find_io` show them as outputs.
- **vmap prefab variables**: keyvalues bound to prefab variables get the placed prefab's values - defaults, choice groups (e.g. `TowerLocation = middle_tier_3` sets the tower's name and unit) and overrides; a named prefab is an I/O target of the outer map. Dota towers now get their real names. `fixupEntityNames` is not applied (the renaming rule is not confirmed by the data).
- App: right-click menu on the Meta info grid - Copy (cell), Copy row, Copy all.
- `hammer_status` lists all window titles of the process when no open map is found.

### Changed
- Strata (Portal: Revolution x64) verified live: build, game config, FGD, `validate_map`, `check_assets`, Run Map sequences. `$postcompiler_exe` and `$bsp` are expanded; `|all_source_engine_paths|` points to the game root when the game exe lives in `bin\win64`.
- Strata ships `"Autosave Dir" = "\\autosave\\"`, which Hammer rejects (not an absolute path, autosaves disabled); `fromAutosave` now says so instead of looking in a guessed folder.
- A bare map file name in the Hammer title (seen on Strata) is looked up in the MapDir of the Hammer's game configs.
- Source 2 maps are cached by path + write time + size: a big `.vmap` with prefabs is not re-read on every call.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

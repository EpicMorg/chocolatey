## [0.2.0] - 2026-11-13

Reading maps, game data and the compile pipeline; first live edits of logic; a much larger build registry.

### Added
- **Map knowledge**: `get_entity`, `find_io` (logic graph: who fires what at whom), `validate_map` (unknown classes, keyvalues and outputs not in the FGD, outputs to missing targets, inputs the target does not have, values with double quotes inside).
- **Game data**: `game_configs` (Hammer / Hammer++ game configurations), `fgd_class`, `fgd_search`. Tolerant FGD parser: Hammer++ `@version` / `@ExtendClass`, Garry's Mod `*studio` types, fgdlib-like class redefinition and parse-time inheritance.
- **Formats**: VMF / VMX / VMM / `vmf_autosave` with outputs (`,` or ESC separators) and hidden entities; RMF / MAP / JMF via Sledge.Formats; VMT materials and Hammer game configs via ValveKeyValue.
- **Assets**: `check_assets` - materials, models, sprites, decals, skybox of the saved map checked against `gameinfo.txt` search paths (`|gameinfo_path|`, `|all_source_engine_paths|`, `|appid_N|` via Steam libraries), folders and VPK directories.
- **Compile**: `compile_sequences` (Run Map sequences from `CmdSeq.wc`, Hammer++ and Strata files, variables expanded), `compile_log` (stages, leaks, missing materials, model errors, limits), `leak_trace` (`.lin` leak path), `run_compile` (edit modes only; skips launching the game and the log viewer), `bsp_entities` (entity lump of the compiled `.bsp`, outputs included).
- **Autosaves**: read tools take `fromAutosave` to use the newest autosave when it is newer than the saved map (Hammer++ `AutosaveDir`, stock Hammer `Autosave Dir` from the registry).
- **Build registry**: 179 known editor builds - every Hammer++ release 8846-8873 (all branches), stock Source 1 Hammer of Valve games and SDKs (x86 and x64), mods (Portal Stories: Mel, Aperture Tag, Portal Reloaded, Black Mesa, ...), Slammin' Hammer, Strata (Portal: Revolution), Source 2 (`tools/hammer.dll` of CS2 and Dota 2) and GoldSrc (Worldcraft 1.1-3.3, Hammer 3.4 / 3.5, Neon / Neo / CSM Hammer 3.5). Source 2 and GoldSrc builds are recognised (GoldSrc by the editor exe itself); live editing still needs the shell channel.

### Changed
- The main window title shows the app version; About and the title take it from the exe's version resource (About showed 0.1.0-alpha in local builds).
- `run_compile` / `compile_sequences` quote expanded arguments that contain spaces, like Hammer does (`-game "...\Bestiarium Project\bst"`), and `run_compile` ignores a compile log left over from an earlier run.
- `validate_map` resolves output targets by targetname, then by classname (as the engine does), and accepts classes that exist only at runtime (`player`, ...).
- Outputs are formatted with the invariant culture (`delay 0.5`, not `0,5`).
- A missing `custom/*` search path is no longer reported as a problem.

### Notes
- Outputs set with `set_keyvalue` (`OnTrigger` = `target,Input,param,delay,times`) are stored by Hammer as plain keyvalues: they are not shown on the Outputs tab, but vbsp writes them into the `.bsp` as real outputs and they fire in game (verified with `bsp_entities`).
- Hammer cuts a value with double quotes inside (e.g. `echo "text"`) on load, and a later save keeps the damage; `validate_map` now warns about such lines.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

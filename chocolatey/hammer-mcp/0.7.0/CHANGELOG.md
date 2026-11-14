## [0.7.0] - 2026-11-15

### Added
- **The adapter**. Nothing is injected unless you press **Connect adapter**. The app's **Connect adapter** button (MCP Mode Auto or Advanced; known standalone Hammer builds) injects a small native adapter into the attached Hammer - one DLL per bitness (`hmcp-adapter-x86/x64.dll`) that finds its build itself; the server sends it the build profile from its registry. It adds an **MCP** menu (with icons) to Hammer's main menu bar: pause / resume the agent (every edit is refused while paused - shell channel and menu commands too), **Chat with the agent...** (a chat window: your lines reach the agent in `hammer_status.userRequests` / `user_requests`, once; the agent answers with the new `say_to_user` tool), **Activity log...** (a live window), **Pending changes** (a list with check boxes), status, disconnect, about. Auto never injects by itself: it uses the adapter when you connected it, and after Attach connects to an adapter that is already loaded (e.g. the app was restarted). **Advanced** is now strict (for debugging): everything that changes Hammer goes through the adapter only, which cannot edit yet - so edits, menu commands and compiles are refused there. Basic and Shell do not use the adapter. Never injected into a game process (VAC / anti-cheat), Source 2, or an unknown build; the native injector re-checks the policy before it opens the process. `hammer_status` reports `adapter` and `agentPaused`; `user_requests` also returns `recentChat` (the last 10 chat lines from both sides). The chat is a side channel (it says so on top): the agent reads it between its steps, and the new `wait_for_user` tool lets it wait there for your answer (up to 10 minutes) - nothing in MCP can wake an idle agent, so otherwise write to it in its own window. The release zip has a `native` folder next to `hammer-mcp.exe` (both injectors and adapters) - keep it there.

- **x86 build**: every release now also has `hammer-mcp-v<version>-win-x86.zip` (same layout as win-x64) for 32-bit Windows; x86 zips were added to the earlier releases too. The 32-bit app works with 64-bit Hammer as well.

- **`find_assets`**: find content by name in the game of the attached Hammer - loose files and VPKs from the search paths (Source 1: `gameinfo.txt`; Source 2: `game/<mod>`, `content/<mod>`, `core`, compiled `*_c` reported as Hammer writes them): models, materials, textures, sounds, sprites, particles. A part of the path or a wildcard (`props_2fort/*locker*`, `ambient/wind*`); each hit has `keyValue` (what to write in the entity: material `tools/toolsnodraw`, sound `ambient/wind1.wav`) and the source it comes from (the first one wins). GoldSrc (WADs, its game config) comes later.

- App: **Settings > Logs** - save the log to daily files (`hammer-mcp-yyyy-MM-dd.log`, on by default, folder `%APPDATA%\EpicMorg\Hammer-MCP\logs` or your own), Browse... and Open folder. The window is a bit taller.

- **Approval mode** (app: **Ask me before agent edits**): the agent's edits - create / set_keyvalue / rotate / delete, save_map, undo, redo, run_compile - wait until you apply or reject them: in the **Pending changes** window that pops up (Apply selected / Apply all / Reject all) or in Hammer's **MCP > Pending changes (N)** (with the adapter). The tool call waits up to 2 minutes; a rejected change tells the agent not to repeat it; a late decision is reported by the new `pending_changes` tool. Applied changes run one at a time in the order the agent asked for them; an entity's address is checked again when the change is applied (the map may have changed meanwhile). Pausing the agent rejects everything waiting or queued. At most 20 changes wait at once. `hammer_status` shows `approval` and `pendingChanges`.

- App: tray **Copy client config** has ready-to-paste settings for Claude Code, Codex, OpenCode, Gemini CLI, Cursor, VS Code / Copilot and Claude Desktop (via mcp-remote), with the token if one is set.

- App: **Ask me before agent edits** is remembered between runs (saved as soon as it is toggled).

### Changed
- **Advanced** mode is strict (adapter only, for debugging): edits, menu commands and compiles are refused until the adapter can do them - use **Auto** for work. The **Connect adapter** button works in Auto and Advanced.

### Fixed
- The editor DLL is matched to the exe: in a folder with both Slammin's `hammer.exe` and Hammer++ (Bestiarium), `hammer.exe` was identified as Hammer++.

Full changelog: https://github.com/EpicMorg/Hammer-MCP/blob/master/CHANGELOG.md

# Enodia - Changelog

## [1.0.0+0] — 2026-09-09

Initial release. `collect → inventory.jsonl → evaluate → assessment → render`,
end to end, verified against real production infrastructure:

- **87 probes**, one file each, compiled in and explicitly registered — most
  speaking HTTP, some (Redis, PostgreSQL, MySQL, MongoDB) their own wire
  protocol directly, and a growing set (every mainstream Linux distro, the
  BSDs, macOS, OPNsense, Proxmox VE, TrueNAS, Synology DSM, network
  appliances) reached over SSH or a vendor HTTP API instead of assuming a
  version endpoint exists at all.
- `product: generic` — a config-only probe (`json`/`xml`/`header`/
  `plaintext`/`regex` plus `clean_regex`) for anything in-house, with a
  deliberately frozen vocabulary (no conditionals, loops, or templating).
- Lifecycle resolution against **endoflife.date** and **GitHub Releases**,
  cached on disk, evaluated on three independent axes (patch drift,
  lifecycle phase, newer branch) rather than one collapsed verdict.
- Four report views (`compact`, `lifecycle`, `drift`, `fleet`) across table,
  HTML (offline-first, optional CDN mode), JSON, and Prometheus output.
- `enodia serve` — a snapshot-only HTTP server; a background ticker collects,
  handlers only ever read the last snapshot.
- Config schema with `${VAR}`/`${VAR:-default}` interpolation, a dedicated
  credential store (`token-header`, `bearer`, `basic`, `ssh-key`, `password`),
  and TLS pinning/insecure-opt-in per target.
- Packaging: `.deb`, `.rpm`, `.apk`, and Arch's `.pkg.tar.zst`, a dedicated
  unprivileged `enodia` system user, man pages for every command, raw
  archives for Linux/Windows/macOS/Android (Termux), and a container image.
  Checksums signed with cosign keyless (OIDC, no key to manage or leak).

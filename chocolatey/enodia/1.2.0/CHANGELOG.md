# Enodia - Changelog

## [1.2.0+0] — 2026-09-10

### Added

- `p4d` and `p4p` probes for Perforce Helix Core Server and Perforce Proxy.
  Perforce's own RPC wire protocol was fully reverse-engineered live and a
  hand-built client reproduced its handshake correctly against a real proxy,
  but that exact, byte-verified-correct handshake is silently dropped by
  real direct p4d servers for reasons not visible from the client side
  (mandatory TLS and rate limiting both ruled out live). Both probes shell
  out to the operator's own `p4` CLI instead (`p4 -Ztag -p <address> info`)
  — the first probe in this project to run an external process rather than
  speak a wire protocol directly. The binary path is configurable per
  target via `options.binary` (falling back to `p4` on `$PATH`); this
  works identically on Windows, pointed at `p4.exe`. A proxy's reply is
  told apart from a direct server's by the presence of its own
  `proxyVersion` field — each probe rejects the other's shape (D28).

### Fixed

- The `p4 -Ztag` output parser didn't strip Windows line endings: a real
  `p4.exe` writes `\r\n`, leaving a trailing `\r` inside field values like
  `ServerID`.
- `probe.Observation.Resolver` (added in 1.1.0+0 for sonarqube) was a plain
  `ResolverRef`, not a pointer — `encoding/json`'s `omitempty` has no
  concept of "empty" for a struct value, so every single observation was
  serialising a spurious `"resolver":{}`, not just sonarqube's. Changed to
  `*ResolverRef`, the same reason `TLSVerified` is already `*bool`.
# Enodia - Changelog

## [1.2.1+0] — 2026-09-10

### Fixed

- `p4d`/`p4p` didn't apply `t.Timeout` to the `p4` CLI subprocess they shell
  out to — every other probe in this tree clamps its network transport to
  `t.Timeout` before touching the network, and this one didn't. A `p4`
  process stuck dialing an unreachable direct server (no response, no RST —
  the exact network behavior D28 already documents) hung indefinitely,
  stalling an entire collection run. Reported directly from a real hang in
  production.
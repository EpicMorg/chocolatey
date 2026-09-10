# Enodia - Changelog

## [1.1.1+0] — 2026-09-10

### Fixed

- `debian` was reporting a bare major version (`13`) instead of the actual
  point release (`13.6`) — confirmed live that Debian's `/etc/os-release`
  `VERSION_ID` never carries one, even on a fully patched install; the point
  release lives only in `/etc/debian_version`. `debian` moved off the shared
  `osReleaseFamilyProbe` into its own `debianProbe`, which reads both files
  and only trusts `debian_version` after confirming `ID=debian` and that its
  content is a plain dotted number — a real Ubuntu image was confirmed live
  to ship the identical file with meaningless inherited content (D26).
- `ubuntu` had the same gap: `VERSION_ID` never changes after a release
  ships (confirmed live, `14.04` through `24.10`), so a fully patched `22.04`
  host reported bare `22.04`, not `22.04.5`. `ubuntu` moved off
  `osReleaseFamilyProbe` into its own `ubuntuProbe`, preferring the point
  release from `os-release`'s own `VERSION` field when it's strictly more
  precise than `VERSION_ID`. Every other `osReleaseFamilyProbe` product was
  audited the same way; none of the rest have this gap (D27).
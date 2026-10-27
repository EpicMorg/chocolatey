# Enodia - Changelog

## [2.2.1+0] — 2026-10-27

A maintenance release: probes stop tripping over their own version checks
(MySQL/MariaDB host blocks, PostgreSQL login-only roles), `${VAR}` config
values are taken verbatim, and two `cve update` edge cases are fixed. One
behaviour change to know about: the `postgresql` probe now connects to the
`postgres` database by default instead of one named after the login user
(`options.database` overrides it) — set it if a target has no `postgres`
database. Inventories are unchanged.

### Added

- `postgresql` targets take an `options.database` setting. The probe now
  asks for the `postgres` database by default instead of one named after
  the login user, so a login-only role reveals the version without a
  database of its own; set `options: {database: ...}` for a server that
  has no `postgres` database.

### Fixed

- `mysql` and `mariadb` probes no longer risk getting enodia's own host
  blocked (ERR 1129). They used to read the version from the greeting and
  hang up, which the server counts as an aborted pre-auth connection;
  enough of those trip `max_connect_errors`. The probes now answer the
  greeting with a throwaway login and read the (rejected) result, so the
  connection counts as a failed authentication, which does not block the
  host. The version still comes from the greeting; no credential is used.
- `${VAR}` in a config or `credentials_file` is now expanded on the parsed
  YAML tree (scalars only) instead of the raw file text, so a variable's
  value is taken verbatim: a password with a backslash, `#`, `: ` or a
  leading `*`/`&`/`[` no longer breaks the scalar it lands in or
  `config validate`.
- `cve update` with `cve.oval.path` or `cve.alpine.path` set but no
  release or branch to fetch (none on disk, in `--from` or the flags)
  succeeded quietly, leaving a directory `check` then refused; it now says
  so and exits 1 (D73).
- `kafka` started `kafka-topics --version` (a JVM, a few seconds) on every
  run when it was on PATH, even with the broker's jar found; it now runs
  only when no jar is (D63).

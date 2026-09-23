# Enodia - Changelog

## [2.0.0+0] — 2026-09-23

A major version for a major feature, not for a break: CVE correlation is
the first evaluation axis that isn't about lifecycle. Existing
`enodia.yaml`, `settings.yaml` and inventory files work unchanged — the
new `cve:` block is optional, and a config without it behaves exactly as
1.2 did.

### Added

- **CVE correlation** against two local databases, BDU ФСТЭК and NIST NVD
  (D30, D31). enodia never downloads them: the operator fetches BDU's
  `vulxml.zip` and NVD's yearly `nvdcve-2.0-<year>.json.gz` files and
  points `cve.bdu.path` / `cve.nvd.path` in `enodia.yaml` at them (a file,
  or for NVD a directory of files). Either source works alone. Both are
  stream-parsed and cached in the OS cache directory: the first run after
  a database changes takes about a minute for all of NVD plus BDU, every
  later run under a second.
- **53 products matched**, every probe with usable data in either source,
  each vendor/product pair verified verbatim against the full real exports
  (D33). Deliberately not matched, each for a stated reason:
  general-purpose Linux distributions (their CVEs are package-level), the
  BSDs and Solaris, ESXi/vCenter and Synology DSM (patch levels and build
  suffixes the matcher doesn't read yet).
- **Edition-aware matching** for GitLab, Vault, Nextcloud and MongoDB: a
  Community Edition instance no longer sees Enterprise-only findings (on
  real data, GitLab 19.2.2 CE sees 4 of NVD's 9, Nextcloud 27.1.3 CE 11 of
  23). The `gitlab`, `vault`, `nextcloud` and `mongodb` probes report
  their server's own edition in `Extra["enterprise"]`; an unknown edition
  keeps every finding (D33, D34).
- `ssh` targets are matched as OpenSSH or Dropbear by their banner, and
  any other SSH stack gets no CVE lookup rather than OpenSSH's (D33).
- A **CVES column** in `check`'s compact and drift views, counting
  distinct CVEs.
- A **per-CVE modal** in `export --format html`, pure CSS with no
  JavaScript, so the inline report stays a zero-`<script>` offline file
  (D32): one line per CVE with links to NVD, cve.org and bdu.fstec.ru,
  BDU's Russian text when BDU has the CVE, a colored
  `CRITICAL · CVSS 3.1 9.8` rating, most severe first (D35).
- `export --format json` carries every per-source finding under each
  assessment's `cves`, including a structured CVSS rating parsed from both
  sources.
- `fortios` probe for Fortinet FortiGate, via its REST API with a REST API
  Admin token (D29).
- CDN-mode HTML reports remember a dismissed "needs internet access"
  warning per viewer.

### Notes

- The `cve:` block is read from whichever config the run actually uses —
  `--config`, `$ENODIA_CONFIG`, or the default search paths.
- Windows paths work unquoted, in single quotes, with forward slashes or
  as UNC paths. In YAML double quotes `\t` and `\n` become a tab and a
  newline, so such a path is rejected at load with a hint.
- `cisco-ios-xe` is off the roadmap for good (D34).
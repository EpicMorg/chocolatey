# Enodia - Changelog

## [2.1.1+0] — 2026-10-08

### Fixed

- MariaDB 11.0+ no longer masks its version behind `5.5.5-` (`11.4.9-MariaDB-…`),
  so `mysql` recorded such servers as MySQL and `mariadb` refused them. Both
  probes now recognise MariaDB by either shape (D47).

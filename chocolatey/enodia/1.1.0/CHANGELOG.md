# Enodia - Changelog

## [1.1.0+0] — 2026-09-10

### Added

- `resolver.githubTagsSource` (`Type: "github-tags"`): a lifecycle source for
  products that publish no GitHub Releases at all, only tags in a non-dotted
  shape. Used to give `pgadmin` its first working resolver
  (`pgadmin-org/pgadmin4`'s tags are `REL-9_17`, converted to `9.17`; the
  highest-parsing tag is picked, not the first one, since the tags endpoint
  documents no ordering guarantee) (D24).
- `GITHUB_TOKEN` environment variable: authenticates every GitHub lifecycle
  lookup (both `github` and `github-tags`), raising GitHub's unauthenticated
  cap from 60 requests/hour per source IP to 5000/hour (D24).
- `probe.Observation.Resolver`: lets a probe pick which lifecycle calendar
  applies per observation, overriding its product's static
  `Meta().DefaultResolver`, for the rare case where the right calendar can
  only be told apart *after* seeing the vendor's own version reply. First
  used to split `sonarqube` between SonarQube Server and SonarQube Community
  Build — two separate products since SonarSource's late-2024 split, tracked
  as two different `endoflife.date` pages with different cycle data (D25).

### Fixed

- Resolver failures used to show only `resolver_error` in the report, with no
  way to tell a GitHub rate limit from a DNS failure from a reshaped API.
  `enodia check`/`export` now print the real underlying error to stderr when
  this happens (D24).
- `sonarqube` was always compared against the `sonarqube-community` lifecycle
  calendar, even for a SonarQube Server instance — collecting its version
  worked, but the report showed an unmatched cycle regardless. Now resolved
  per instance from the version string itself (D25).

### Changed

- Container image publishing (`ghcr.io/epicmorg/enodia`, also mirrored to
  Docker Hub and Quay) moved out of this repository's own release pipeline
  entirely, into the `EpicMorg/docker` monorepo
  (`linux/ecosystem/apps/enodia`), on that repo's own build schedule. The
  published image address and tags (`latest`, `1`, the exact version) are
  unchanged; `.goreleaser.yaml` and `release.yml` no longer build or publish
  any container at all (D17).
# Atlassian Downloader - Changelog

## Library `EpicMorg.Atlassian.Downloader`

Versioned on its own since `2.0.0.5`, when the core logic was split out of the console app. The
`1.x` section further down is the old history of the app itself, not of this package.

* `1.0.0.4` - fixes:
    * a feed that cannot be reached or parsed is now logged and skipped instead of ending the run. Previously the first bad feed aborted everything after it, so which products got mirrored depended on their position in the list.
    * restored `raw.githubusercontent.com` alongside `raw.githack.com` for the `SourceTree` mirrors. `SourceTree` is the one product with no official feed, and the two hosts have been seen serving different content for days at a time.
    * code signing is skipped off Windows instead of failing the build. `signtool.exe` ships with the Windows SDK, so a `Release` build on Linux or macOS died with exit code 127 after everything had already compiled.
    * `--random-user-agent` works. The flag and the pool behind it both existed since `2.0.0.7`, but the value never left `Program.Main` and nothing ever read the pool.
    * the user agent header no longer accumulates. `ParseAdd` appends, and every entry point set it on the same `HttpClient`, so more than one call left several user agents in a single header.

## 2.x

* `2.0.0.9` - fixes:
    * `--random-user-agent` does something now. It was accepted, listed in `--help` and announced in `2.0.0.7`, but the value never left `Program.Main`.
    * `--help` describes the options again. `DragonFruit` builds it from the XML doc comments on `Main`, and with no documentation file generated every option was labelled with its own parameter name, like `outputDir []`.
    * a feed that cannot be reached or parsed no longer ends the run.
    * `Release` builds work off Windows: code signing is skipped there instead of failing.
    * requires library `1.0.0.4`.

**Full Changelog**: https://github.com/EpicMorg/atlassian-downloader/compare/2.0.0.8...2.0.0.9
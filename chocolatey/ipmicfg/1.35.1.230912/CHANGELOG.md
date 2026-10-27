## IPMICFG 1.35.1 (build 230912)

Fixed and adopted by the new maintainer (EpicMorg).

- Previous package fetched 1.27.1 from `ftp://ftp.supermicro.com/...`, which no longer
  resolves — Chocolatey verification failed.
- Embeds the official 1.35.1 build 230912 archive from
  `https://www.supermicro.com/wdl/utility/IPMICFG/IPMICFG_1.35.1_build.230912.zip`
  (redistributed with Supermicro's permission) — nothing is downloaded at install time;
  see `legal\VERIFICATION.txt`.
- sha256 `06A6FA43…` matches Supermicro's own CheckSum.txt.
- Extracts only the matching-bitness `Windows\<32|64>bit` folder (IPMICFG-Win.exe + pmdll.dll).

Newer builds (1.36.0, 1.37.0) exist but are served only through Supermicro's gated
download center, with no stable direct URL to verify against; 1.35.1 is the latest
version on the public, checksummed mirror.

## Changelog
* `oct 2026`
  * `winbox`: added the missing stable `3.8`, `3.13`, `3.15`, `3.25`, `3.26`, `3.33` and all pre-releases `3.0beta1`–`3.0rc17`, `4.0beta1`–`4.0rc3` (versioned `x.y.z.<date>-<betaN|rcN>`, install with `--pre`).
  * fixed `winbox 3.4` package (it downloaded the `3.3` binary).
  * added new `netinstall` package (`7.25`) and backfilled the full RouterOS history `3.30`–`7.25` (stable + long-term; x86-only before `6.47`). `5.8`–`5.20` are skipped: MikroTik serves a broken (AccessDenied stub) archive for them.
  * added new `thedude` package (`7.20.5`) and backfilled the full RouterOS history `6.33.5`–`7.25` (stable + long-term).
  * added new `flashfig` package (`7.25`) and backfilled the full RouterOS history `6.47.10`–`7.25` (stable + long-term).
  * adopted and fixed `ipmicfg` (dead `ftp://` download) and backfilled its full version history `1.14.2`–`1.35.1`.
  * `ipmicfg`: every version now embeds the official Supermicro zip (redistributed with Supermicro's permission, sha256 = Supermicro's CheckSum.txt, see `legal\VERIFICATION.txt`) — Supermicro's download server rejects Chocolatey's verifier with 403, so nothing is downloaded at install time anymore.
  * added new `enodia` packages `2.1.0`, `2.1.1`, `2.2.0`, `2.2.1`.
* `2025-2026`
  * added new `winbox`-es packages.
  * added new `airtest-ide`-es packages.
  * added new `atlassian-downloader`-es packages.
* `aug 2024`
  * added new `winbox 3.41` package.
  * added new `atlassian-downloader 2.0.0.2` package.
  * updated `changelog.md` :D
* `jun 2024`
  * fixes links of `winbox` packages.
* `feb 2024`
  * added support of `winbox` packages. special thanks to [@qzo](https://github.com/qzo) with [original package](https://github.com/qzo/chocolatey-packages)!
* `oct 2023`
    * added `1.1.0.0` version of `atlassian-downloader`
	* fixed `1.2.4.20200716` version of `airtest-ide`
	* added `1.2.11.20210819` version of `airtest-ide`
	* added `1.2.13.20211230` version of `airtest-ide`
	* added `1.2.14.20220520` version of `airtest-ide`

* `may 2023`
    * added `1.0.1.0` version of `atlassian-downloader`
	* fixed `1.2.15.20230404` version of `airtest-ide`
	* added `1.2.8.20210223` version of `airtest-ide`
	* added `1.2.9.20210427` version of `airtest-ide`
	* added `1.2.10.20210621` version of `airtest-ide`

* `april 2023`
	* added `0.0.18.20180522` version of `airtest-ide`
	* added `0.1.0.20180615` version of `airtest-ide`
	* added `0.1.1.20180619` version of `airtest-ide`
	* added `0.1.2.20180626` version of `airtest-ide`
	* added `0.1.3.20180629` version of `airtest-ide`
	* added `0.1.4.20180710` version of `airtest-ide`
	* added `0.1.5.20180720` version of `airtest-ide`
	* added `0.1.6.20180807` version of `airtest-ide`
	* added `1.0.0.20180905-pre` version of `airtest-ide`
	* added `1.0.0.20180918` version of `airtest-ide`
	* added `1.0.1.20181011` version of `airtest-ide`
	* added `1.1.0.20181106` version of `airtest-ide`
	* added `1.2.0.20190115` version of `airtest-ide`
	* added `1.2.1.20190416` version of `airtest-ide`
	* added `1.2.2.20190910` version of `airtest-ide`
	* added `1.2.3.20200120-pre` version of `airtest-ide`
	* added `1.2.3.20200121` version of `airtest-ide`
	* added `1.2.4.20200716` version of `airtest-ide`
	* added `1.2.5.20200716` version of `airtest-ide`
	* added `1.2.6.20201013` version of `airtest-ide`
	* added `1.2.7.20210207` version of `airtest-ide`
	* added `1.2.15.20230404` version of `airtest-ide`
    * added `1.0.0.9` version of `atlassian-downloader`

* `december 2020`
	* added `0.0.18.20180522` version of `airtest-ide`
	* added `0.1.0.20180615` version of `airtest-ide`
	* added `0.1.1.20180619` version of `airtest-ide`
	* added `0.1.2.20180626` version of `airtest-ide`
	* added `0.1.3.20180629` version of `airtest-ide`
    
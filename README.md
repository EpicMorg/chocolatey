# [![Activity](https://img.shields.io/github/commit-activity/m/EpicMorg/chocolatey?label=commits&style=flat-square)](https://github.com/EpicMorg/chocolatey/commits) [![GitHub issues](https://img.shields.io/github/issues/EpicMorg/chocolatey.svg?style=popout-square)](https://github.com/EpicMorg/chocolatey/issues) [![GitHub forks](https://img.shields.io/github/forks/EpicMorg/chocolatey.svg?style=popout-square)](https://github.com/EpicMorg/chocolatey/network) [![GitHub stars](https://img.shields.io/github/stars/EpicMorg/chocolatey.svg?style=popout-square)](https://github.com/EpicMorg/chocolatey/stargazers)  [![Size](https://img.shields.io/github/repo-size/EpicMorg/chocolatey?label=size&style=flat-square)](https://github.com/EpicMorg/chocolatey/archive/master.zip) [![Release](https://img.shields.io/github/v/release/EpicMorg/chocolatey?style=flat-square)](https://github.com/EpicMorg/chocolatey/releases)  [![GitHub license](https://img.shields.io/github/license/EpicMorg/chocolatey.svg?style=popout-square)](LICENSE.md) [![Changelog](https://img.shields.io/badge/Changelog-yellow.svg?style=popout-square)](CHANGELOG.md)

![](https://rawcdn.githack.com/EpicMorg/chocolatey/f417f8672891b4ea65928fac2be14a51b55957d3/.github/logo.png)

# :pushpin: Some released stuff  [![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B81CUI4)

 Product | Version   | Downloads
| ------  | ------ | ------ 
| :open_file_folder: [airtest-ide](./chocolatey/airtest-ide) |  [![Version](https://img.shields.io/chocolatey/v/airtest-ide?label=version&style=for-the-badge)](https://chocolatey.org/packages/airtest-ide/) | [![Version](https://img.shields.io/chocolatey/dt/airtest-ide?style=for-the-badge)](https://chocolatey.org/packages/airtest-ide/) 
| :open_file_folder: [atlassian-downloader](./chocolatey/atlassian-downloader) |  [![Version](https://img.shields.io/chocolatey/v/atlassian-downloader?label=version&style=for-the-badge)](https://chocolatey.org/packages/atlassian-downloader/) | [![Version](https://img.shields.io/chocolatey/dt/atlassian-downloader?style=for-the-badge)](https://chocolatey.org/packages/atlassian-downloader/) 
| :open_file_folder: [enodia](./chocolatey/enodia) |  [![Version](https://img.shields.io/chocolatey/v/enodia?label=version&style=for-the-badge)](https://chocolatey.org/packages/enodia/) | [![Version](https://img.shields.io/chocolatey/dt/enodia?style=for-the-badge)](https://chocolatey.org/packages/enodia/) 
| :open_file_folder: [flashfig](./chocolatey/flashfig) |  [![Version](https://img.shields.io/chocolatey/v/flashfig?label=version&style=for-the-badge)](https://chocolatey.org/packages/flashfig/) | [![Version](https://img.shields.io/chocolatey/dt/flashfig?style=for-the-badge)](https://chocolatey.org/packages/flashfig/) 
| :open_file_folder: [ipmicfg](./chocolatey/ipmicfg) |  [![Version](https://img.shields.io/chocolatey/v/ipmicfg?label=version&style=for-the-badge)](https://chocolatey.org/packages/ipmicfg/) | [![Version](https://img.shields.io/chocolatey/dt/ipmicfg?style=for-the-badge)](https://chocolatey.org/packages/ipmicfg/) 
| :open_file_folder: [netinstall](./chocolatey/netinstall) |  [![Version](https://img.shields.io/chocolatey/v/netinstall?label=version&style=for-the-badge)](https://chocolatey.org/packages/netinstall/) | [![Version](https://img.shields.io/chocolatey/dt/netinstall?style=for-the-badge)](https://chocolatey.org/packages/netinstall/) 
| :open_file_folder: [thedude](./chocolatey/thedude) |  [![Version](https://img.shields.io/chocolatey/v/thedude?label=version&style=for-the-badge)](https://chocolatey.org/packages/thedude/) | [![Version](https://img.shields.io/chocolatey/dt/thedude?style=for-the-badge)](https://chocolatey.org/packages/thedude/) 
| :open_file_folder: [winbox](./chocolatey/winbox) |  [![Version](https://img.shields.io/chocolatey/v/winbox?label=version&style=for-the-badge)](https://chocolatey.org/packages/winbox/) | [![Version](https://img.shields.io/chocolatey/dt/winbox?style=for-the-badge)](https://chocolatey.org/packages/winbox/) 


## :hammer_and_wrench: Batch pack / push / test

`tools/choco-batch.ps1` finds every `*.nuspec` under a folder (recursively) and runs
`choco pack` / `push` / `install` / `uninstall` for each version, sorted by version.
Nuspecs are only read. A version whose `.nupkg` already exists is not repacked without `-Force`.
The push API key comes from choco's config (`choco apikey`).

```powershell
# show the commands only
.\tools\choco-batch.ps1 chocolatey\thedude pack,push -WhatIf

# pack + push a version range to community (stops at the first failed push, e.g. queue limit)
.\tools\choco-batch.ps1 chocolatey\thedude pack,push -From 7.21 -To 7.25

# local install + uninstall test (pre-releases get --pre automatically)
.\tools\choco-batch.ps1 chocolatey\winbox install,uninstall -Version 4.0beta*
```

Options: `-Version` (names/versions, wildcards), `-From` / `-To` (inclusive range),
`-Force` (repack over an existing nupkg; `--force` for install), `-Delay <sec>` between pushes,
`-ContinueOnError`, `-Source <feed>`, `-WhatIf`. Full help: `Get-Help .\tools\choco-batch.ps1 -Full`.

## :smile: Thanks
* [@qzo](https://github.com/qzo), for [original package of winbox](https://github.com/qzo/chocolatey-packages)
* ` vacancy is open` :)

# V1.2.7.20210207
## Release Date: 2021-02-07

## New Features
- Fully iterated the iOS module, currently supports the use of Appium/WebDriverAgent to connect to iOS phones, and supports new versions of xcode and iOS versions
- Support iOS pop-up window click, some new interfaces have been added, please check the documentation for interface updates: Airtest#1.1.8
- If you want to connect to an iOS phone in a local python environment, please use pip install -U airtest and pip install -U pocoui to update the local version
	- Please be careful not to use Python2, the new version is for all changes in iOS and only supports Python3 users
- Comprehensively improve the stability of iOS connection, it is not easy to disconnect or terminate abnormally when operating and running scripts
- Fixed the problem that when connecting to iPad in AirtestIDE, if it is not in a vertical screen, there may be a wrong click position and wrong Poco control box selection
- Fixed the issue that iOS-Poco may not find the node when some devices are not in portrait mode
- If you see this, welcome to click star for us on github :) `Airtest` and `Poco`

## Bug Fixes
- Fixed some problems of the device connection module, we apologize for the inconvenience caused by the previous version

## Download
- Windows64: [AirtestIDE-win-1.2.7.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.7.zip)
- Windows32: [AirtestIDE-win-1.2.7.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win32/AirtestIDE-win-1.2.7.zip)
- Mac: [AirtestIDE-mac-1.2.7.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/mac/AirtestIDE-mac-1.2.7.dmg)
- Ubuntu: [AirtestIDE_2020-01-21_py3_ubuntu16-04.deb](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_ubuntu16-04.deb)
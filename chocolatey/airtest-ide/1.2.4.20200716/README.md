# V1.2.4.20200716
## Release Date: 2020-07-16

## New Features
- Airtest has been updated to version 1.1.4, and the calling method of interface swipe_along/pinch/two_finger_swipe has been modified. Xcode support has been updated to version 11.5 and iOS version has been supported to 13.5.
- Added automatic update function of AirtestIDE.
- Optimized the search function of the script editing window.
- Slightly optimized log level filtering function.
- Right-click to run the selected code function, if there is a poco statement, it will try to initialize a poco object according to the current poco mode, which is more convenient to run.
- AirtestIDE does not provide an Ubuntu version for this update. You can write scripts on other platforms, and then deploy a Python environment to run on Ubuntu.

## Bug Fixes
- Fixed a bug where some phones might fail to tap the screen in ADB TOUCH mode.
- Fixed a bug that might be triggered when the script is saved as.
- Fixed the horizontal screen abnormality of some iOS models and increase the speed of starting applications.
- After Android Poco chooses Stop, it will no longer be forced to continuously restart the poco-service process.
- Fixed a bug where the custom launcher.py path cannot be too long.
- Fixed an issue where the state of the auto-record button was incorrect when disconnected and connected to the phone, and a function to automatically record and insert a set_current statement when switching phones was added.
- When using custom python.exe, the log of the print statement can be printed correctly in order.
- Fixed the problem that setting the Chinese log path under the mac will cause an error in report generation.

## Download
- Windows64: [AirtestIDE-win-1.24.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.24.zip)
- Windows32: [AirtestIDE-win-1.24.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win32/AirtestIDE-win-1.24.zip)
- Mac: [AirtestIDE-mac-1.24.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/mac/AirtestIDE-mac-1.2.7.dmg)

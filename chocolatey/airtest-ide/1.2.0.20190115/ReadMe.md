# V1.2.0.20190115
## Release Date: 2019-01-15

## New Features
- Added Android Assistant function, provided shortcut operation function of some ADB commands of Android mobile phone, and applications management function, and mobile phone shell debugging window. More
- Added code auto-completion function, enable this function and set the local Python.exe path to get better auto-completion effect. If auto-completion is not enabled, a simple version of the completion function will be used. It works better than the previous completion function.More
- Airtest adds the swipe_along interface and adds the search parameter to the text interface.
- AirtestIDE right-click menu adds image mode and py code mode switching.
- Iterate the ImageEditor, add image renaming, step by step to view the recognition function. More
- Set the window to increase the real-time display of the mouse in the device screen coordinate function. More
- Add the about page of AirtestIDE.
- Instructions for adding future overseas equipment provider Headspin.

## Bug Fixes
- Fixed a bug in device button rendering exception when multiple devices were connected.
- Fixed a runtime ResourceWarning issue.
- Fixed the get_top_activity result error of the device above Android8.0.
- Fixed the data type error when the Airtest.windows interface is initialized.
- On some win7 systems and low version android devices, there may be a problem with the mobile screen when using version 1.1.0. That is because the previous version we updated the ADB version to 1.40. We judged in version 1.2.0, if it is win7 system will replace the ADB in the IDE directory with the old ADB1.39 version. If the local environment running script conflicts due to different versions, it is recommended to manually change the ADB version to the unified version (win7 system is recommended to use 1.39, which can be obtained in the tools/adb39 under the IDE directory. Win10 system users recommend to continue to use the latest version of the code).

## Download
- Windows64: [AirtestIDE_2019-01-15_py3_win64.zip](https://top.gdl.netease.com/AirtestIDE_2019-01-15_py3_win64.zip)
- Windows32: [AirtestIDE_2019-01-15_py3_win32.zip](https://top.gdl.netease.com/AirtestIDE_2019-01-15_py3_win32.zip)
- Mac: [AirtestIDE_2019-01-15_py3_Mac10-12.dmg](https://top.gdl.netease.com/AirtestIDE_2019-01-15_py3_Mac10-12.dmg)
- Ubuntu: [AirtestIDE_2019-01-15_py3_ubuntu16-04.deb](https://top.gdl.netease.com/AirtestIDE_2019-01-15_py3_ubuntu16-04.deb)

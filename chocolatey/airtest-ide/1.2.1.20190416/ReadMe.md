# V1.2.1.20190416
## Release Date: 2019-04-16

## New Features
- Airtest and IDE have added another way to create new scripts, support for creating and running pure python scripts. 
- Added automatic backup script and recovery script function to avoid losing script content when crashing.
- When choose to connect the device in ADB Touch mode, actually use the ADB command to control the mobile phone now (the Minitouch control is used in the past, which causes some non-mobile devices to operate the screen), but the delay is slightly higher.
- Replace some of the icons, and may continue to modify them later.
- Several new image recognition algorithms have been added. Please refer to the documentation for comparison and selection of operational efficiency.

## Bug Fixes
- Fixed a crash caused by displaying the auto-complete menu under mac.
- Fix bug in horizontal and vertical orientation when right-running script.
- Fixed the problem that the mac packaged version could not print Chinese.
- Fixed a bug where the IDE could not exit normally after connecting ios multiple times.
- When generating poco code automatically, ignore array and UI number of the same name.
- When you double-click the poco node to generate the code, it will not automatically wrap, and the focus will automatically return to the editing window for subsequent editing.
- Cancel the automatic completion pull-down menu to monitor the HOME and END buttons.
- Fixed an issue where the directory folder structure in the script was lost when the script was packaged.
- Airtest fixes the problem that the yosemite input method cannot be enabled correctly when remotely connecting the mobile phone. Some Samsung mobile phone sliding operation is abnormal. In the low version pip, the installation may fail.
- Fix double screen misplacement on windows.

## Download
- Windows64: [AirtestIDE_2019-04-16_py3_win64.zip](https://top.gdl.netease.com/AirtestIDE_2019-04-16_py3_win64.zip)
- Windows32: [AirtestIDE_2019-04-16_py3_win32.zip](https://top.gdl.netease.com/AirtestIDE_2019-04-16_py3_win32.zip)
- Mac: [AirtestIDE_2019-04-16_py3_Mac10-12.dmg](https://top.gdl.netease.com/AirtestIDE_2019-04-16_py3_Mac10-12.dmg)
- Ubuntu: [AirtestIDE_2019-04-16_py3_ubuntu16-04.deb](https://top.gdl.netease.com/AirtestIDE_2019-04-16_py3_ubuntu16-04.deb)

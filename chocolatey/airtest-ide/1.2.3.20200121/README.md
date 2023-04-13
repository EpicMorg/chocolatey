# V1.2.2.20190910
## Release Date: 2020-01-21

## New Features
- With better support and compatibility for Android10, Android10 phones can be directly connected and used. However, if the Xiaomi mobile phone is updated to MIUI11, you need to select the 'use Javacap' + 'use ADB orientation' options before you connect it.
- If you use the local python environment to run the script, and you are using an Android 10 phone, please make sure that the airtest of the local python environment has been updated to the latest version v1.1.3.(pip install -U airtest)
- Added a compatibility mode setting item. If you need to use the compatibility mode at startup to view the editing window and log window normally, you can choose a compatibility mode in the IDE settings and restart the IDE. This will default to the compatibility mode in the future. Launch the IDE, see here.
- For some TV apps, a new TV button shortcut window has been added. You can use the mouse to send ADB messages of up, down, left, right, and confirm buttons. For details, see here.
- Yosemite.apk has an updated version. Please reinstall the new version of the application to get better results and compatibility with Android10.
- Airtest has updated the version. There are some changes to the log() and the LogToHtml() . A configuration item for script image precision compression has been added. For details, please see the Airtest update announcement
- Poco-SDK has added support for cocos-creator and UE4 engines. For details, please refer to the documentation.
- Better support for full-screen devices, airtestIDE can adapt to most of the problems of full-screen incompatibility. But for the problem of the inaccurate Poco position of the remaining full-screen devices, the IDE also supports users to set the screen rendering resolution. For details, see here.

## Bug Fixes
- Fixed an issue where the remote device cocosjs failed to connect.
- Fixed screen capture failure when recording .py scripts.
- Fixed ADB touch mode click coordinates error in landscape orientation.
- Fixed a bug that could occur on some computers that could not flash the mobile device.

## Download
- Windows64: [AirtestIDE_2020-01-21_py3_win64.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_win64.zip)
- Windows32: [AirtestIDE_2020-01-21_py3_win32.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_win32.zip)
- Mac: [AirtestIDE_2020-01-21_py3_Mac10-12.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_Mac10-12.dmg)
- Ubuntu: [AirtestIDE_2020-01-21_py3_ubuntu16-04.deb](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_ubuntu16-04.deb)

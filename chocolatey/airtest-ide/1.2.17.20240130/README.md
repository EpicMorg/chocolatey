# V1.2.17.20240130
## Release Date: 2024-01-30

## New Features
- AirtestIDE supports selenium4.0 or above. If airtest-selenium is used in the local python environment, please update: pip install airtest-selenium
- Airtest is updated to v1.3.3, and the updates are as follows::
    - Airtest 1.3.2
        - [Important] ADB has been upgraded to version 41, which is incompatible with previous ADB versions. Please ensure that all ADB versions in the system environment are consistent, otherwise the device may not be connected.
        - The iOS module adds a new Error type, LocalDeviceError. Some interfaces can only be used by local USB-connected iOS devices, and the remote device will throw this exception.
        - Added iOS tidevice related interfaces
        - Updated yosemite.apk to have better compatibility with some devices
        - Fixed some other issues
    - Airtest 1.3.3
        - touch, swipe interfaces add support for relative coordinates
			- For example, click the center point touch((0.5, 0.5))
			- For example, swipe from right to left swipe((0.7, 0.5), (0.2, 0.5))
			- Currently supported by android/ios/win
        - Windows has added some new clipboard-related interfaces
			- get_clipboard gets the clipboard content, set_clipboard sets the clipboard content, paste pastes
			- The three clipboard interfaces are currently supported by win/ios/android.
        - Android supports manually specifying touch_method to force specifying ADBTOUCH, or MINITOUCH, MAXTOUCH
			- dev.touch_method = "ADBTOUCH"
        - Fixed some other issues
- Poco updated to v1.0.94, and the updates are as follows:
    - Update pocoservice.apk to fix the problem of longer node access time
    - Unity-SDK added the poco.sendMessage() and poco.invoke() interfaces for sending messages to the in-game SDK or handling functions with custom parameter calls. For more details, please refer to code diff #607 and the documentation.
    - When android poco actively calls stop_running, release the applied port number
    - PocoService.apk has been updated to have better compatibility with some models

## Bug Fixes
- 

## Download
- Windows64: [AirtestIDE-win-1.2.17.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.17.zip)
- Mac: [AirtestIDE-mac-1.2.17.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/mac/AirtestIDE-mac-1.2.17.dmg)
 
# V1.2.16.20231106
## Release Date: 2023-11-06

- Added iOS automatic connection function. When iOS has deployed an available wda, it will be able to connect to the device with one click without manually starting the wda.Learn more (Please note: iOS17 is not currently supported.)
- Airtest is updated to v1.3.1, and the updates are as follows::
    - Airtest 1.3.0
        - python2 is no longer supported
        - Added iOS device interface: install, uninstall, list_app, get_clipboard, set_clipboard, paste
        - Added iOS tidevice related interfaces
        - New error type NoDeviceError
        - Other bug fixes and optimizations
    - Airtest 1.3.1
        - The connect_device interface will now be shown in Airtest reports
        - When connecting, iOS and Android devices support passing in the name parameter to specify its udid (ios) or serial number (android)
        - ADB will use the current ADB process first
        - Added Android clipboard interface set_clipboard, get_clipboard, paste
- Poco updated to v1.0.92, and the updates are as follows:
    - Added poco.dump() interface, which has the same effect as the previous poco.agent.hierarchy.dump() interface, making the call easier.
    - Added poco.double_click() double-click interface
    - When android poco actively calls stop_running, release the applied port number
    - PocoService.apk has been updated to have better compatibility with some models

## Bug Fixes
- 

## Download
- Windows64: [AirtestIDE-win-1.2.16.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.16.zip)
- Mac: [AirtestIDE-mac-1.2.16.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/mac/AirtestIDE-mac-1.2.16.dmg)
 
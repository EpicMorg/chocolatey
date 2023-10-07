# V1.2.10.20210621
## Release Date: 2021-06-21

## New Features
- Added image recognition algorithm mstpl. If you use the local python environment, please run pip install -U airtest to update to the latest version. This algorithm improves the accuracy of image recognition
- Some changes have been made to the image editor
- We will provide methods on how to adjust related parameters in subsequent documents to better improve the image recognition effect
- After updating to the latest version of AirtestIDE and the latest version of Airtest, you can no longer need to check the device connection option
- For example, when the simulator is connected, you need to check the use Javacap option, now you only need to connect directly
- Please try not to check the option in the drop-down menu before AirtestIDE connects to the phone
- The parameter cap_method=MINICAP_STREAM is deleted, please do not pass in MINICAP_STREAM when the script is running
- The current support of Android12 is relatively poor, and the image display speed is very slow, please be patient and wait for the update
- Airtest is updated to version 1.2.0, please check the document for specific changes:Airtest#1.2.0
- If you see this, welcome to click star for us on github :)  

## Bug Fixes
- Fixed the problem that the memory would continue to increase after plugging and unplugging the phone in version 1.2.9
- Fixed the problem that the screen image is displayed incorrectly when some models are in landscape mode

## Download
- Windows64: [AirtestIDE-win-1.2.10.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.10.zip)
- Windows32: [AirtestIDE-win-1.2.10.zip](https://airtestproject.s3.netease.com/downloads/AirtestIDE/win32/AirtestIDE-win-1.2.10.zip)
- Mac: [AirtestIDE-mac-1.2.10.dmg](https://airtestproject.s3.netease.com/downloads/AirtestIDE/mac/AirtestIDE-mac-1.2.10.dmg)
- Ubuntu: [AirtestIDE_2020-01-21_py3_ubuntu16-04.deb](https://airtestproject.s3.netease.com/downloads/AirtestIDE/AirtestIDE_2020-01-21_py3_ubuntu16-04.deb)
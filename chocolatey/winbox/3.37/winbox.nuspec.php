<?php require 'vars.inc'; ?>
<?xml version="1.0" encoding="utf-8"?>
<!-- Do not remove this test for UTF-8: if “Ω” doesn’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one. -->
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
  <metadata>
    <!-- Read this before publishing packages to chocolatey.org: https://github.com/chocolatey/chocolatey/wiki/CreatePackages -->
    <id>winbox</id>
    <title>WinBox</title>
    <version><?php echo VERSION; ?></version>
    <authors>MikroTik</authors>
    <owners>qzo</owners>
    <summary>WinBox is a small utility that allows administration of Mikrotik RouterOS using a fast and simple GUI.</summary>
    <description>WinBox is a small utility that allows administration of Mikrotik RouterOS using a fast and simple GUI. It is a native Win32 binary, but can be run on Linux and Mac OSX using Wine.

All WinBox interface functions are as close as possible to Console functions. Some of advanced and system critical configurations are not possible from WinBox, like MAC address change on an interface.

Note: WinBox is obviously freeware, but no details about the license are available either on the application website or in the application itself.</description>
    <projectUrl>http://www.mikrotik.com/download</projectUrl>
    <tags>winbox mikrotik network router routeros administration management</tags>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <iconUrl>https://cdn.rawgit.com/qzo/chocolatey-packages/6f15cdf317a74ec143a2d6400ad4790b23d54fd8/icons/winbox.png</iconUrl>
    <releaseNotes>[Winbox changelog](<?php echo RELEASE_NOTES; ?>)</releaseNotes>
    <packageSourceUrl>https://github.com/qzo/chocolatey-packages/tree/master/packages/manual/winbox</packageSourceUrl>
    <docsUrl>http://wiki.mikrotik.com/wiki/Manual:Winbox</docsUrl>
  </metadata>
  <files>
    <file src="tools\*.*" target="tools" exclude="**\*.swp;**\*~;**\*.php" />
  </files>
</package>

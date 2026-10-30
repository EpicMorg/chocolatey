## SMCIPMITool 2.26.0 (build 220209)

Released 2022-02-09 (build date).
- Embeds the official archive from Supermicro's download center
  (`https://www.supermicro.com/Bios/sw_download/401/SMCIPMITool_2.26.0_build.220209_bundleJRE_Windows.zip`), redistributed with Supermicro's permission — nothing is downloaded at install time;
  see legal\VERIFICATION.txt.
- sha256 `6374082E8E331614F588D75A5092CDABB14802E2FBF3B80FDAD54D947665E82D`.
- Portable: extracted into the package folder; the command is `smcipmitool`.
- The bundled JRE is used, so no Java installation is needed; its executables are not shimmed.

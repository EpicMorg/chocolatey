## SMCIPMITool 2.27.1 (build 221101)

Released 2022-11-01 (build date).
- Embeds the official archive from Supermicro's download center
  (`https://www.supermicro.com/Bios/sw_download/509/SMCIPMITool_2.27.1_build.221101_bundleJRE_Windows.zip`), redistributed with Supermicro's permission — nothing is downloaded at install time;
  see legal\VERIFICATION.txt.
- sha256 `B2385FDC11A2BE79E6FC342AB3216C2992B9BB3ED1FE4B8C9CC628965E12F3B9`.
- Portable: extracted into the package folder; the command is `smcipmitool`.
- The bundled JRE is used, so no Java installation is needed; its executables are not shimmed.

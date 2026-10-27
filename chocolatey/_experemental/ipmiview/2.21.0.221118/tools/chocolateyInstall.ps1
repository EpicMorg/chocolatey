$ErrorActionPreference = 'Stop'

$packageName = 'ipmiview'
$toolsDir    = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Supermicro ships IPMIView for Windows as a ZIP that contains a single
# InstallAnywhere installer EXE (~207 MB, bundles its own JRE). Download + verify
# the ZIP, unpack the installer, then run it.
$url      = 'https://www.supermicro.com/wdl/utility/IPMIView/Windows/IPMIView_2.21.0_build.221118_Windows.zip'
$checksum = '9B58D278D0D20F5CEEE5DF31CDAD703DEE00312A88342533386C20D117D9D20A'
$zip      = Join-Path $toolsDir 'IPMIView.zip'

# Supermicro's server returns 403 to the default download user-agent (passing a UA
# through Get-ChocolateyWebFile -Options is unreliable, since Choco sets UserAgent
# via the request property). Download with an explicit WebClient that sends a full
# browser header set, then validate the checksum with Choco's own helper.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers['User-Agent']      = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
$wc.Headers['Accept']          = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
$wc.Headers['Accept-Language'] = 'en-US,en;q=0.9'
$wc.Headers['Referer']         = 'https://www.supermicro.com/en/solutions/management-software/ipmi-utilities'
Write-Host "Downloading ipmiview from $url"
$wc.DownloadFile($url, $zip)

Get-ChecksumValid -File $zip -Checksum $checksum -ChecksumType 'sha256'

Get-ChocolateyUnzip -FileFullPath $zip -Destination $toolsDir
Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue

$installer = Join-Path $toolsDir 'IPMIView_2.21.0_build.221118_Windows.exe'

# TODO(verify on Windows): IPMIView uses an InstallAnywhere installer; '-i silent'
# is its standard unattended switch. Confirm the silent flag (and whether a
# response file is needed) on a real Windows box before publishing.
Install-ChocolateyInstallPackage -PackageName $packageName `
  -FileType 'exe' `
  -File $installer `
  -SilentArgs '-i silent' `
  -ValidExitCodes @(0)

# Drop the large extracted installer; it is not needed after install.
Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue

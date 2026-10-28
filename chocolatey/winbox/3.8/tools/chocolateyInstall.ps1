$packageName = 'winbox'
$appName = 'WinBox'
$url = 'https://download.mikrotik.com/routeros/winbox/3.8/winbox.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exe = $packageName + '.exe'
$fullPath = Join-Path -Path $dir -ChildPath $exe
$checksum = 'D3845E9C34BD45E549971F0F16C57F47442C4D0C4FB0D4F0C7A53E0F75A3FABE'
$checksumType = 'sha256'

$startFolder = $appName
$processName = 'winbox'

Function CreateStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) `
        -ChildPath $startFolder
    $startMenuFolder = New-Item $startMenuFolderPath -Type Directory `
        -ErrorAction SilentlyContinue
    If ($startMenuFolder) {
            Install-ChocolateyShortcut -shortcutFilePath `
                (Join-Path -Path $startMenuFolderPath -ChildPath ($appName + '.lnk')) `
                -targetPath $fullPath -workingDirectory $dir
    } Else {
        Write-Warning "Start menu folder couldn't be created."
    }
}

# SCRIPT STARTS HERE #

Stop-Process -Name $processName -ErrorAction SilentlyContinue

Get-ChocolateyWebFile -packageName $packageName -fileFullPath $fullPath -url $url -checksum $checksum -checksumType $checksumType

# create .gui file
New-Item -Path $dir -Name ($exe + '.gui') -ItemType file

CreateStartMenuShortcut
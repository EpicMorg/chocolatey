$packageName = 'winbox'
$appName = 'WinBox'
$url = 'http://download.mikrotik.com/routeros/winbox/3.2/winbox.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exe = $packageName + '.exe'
$fullPath = Join-Path -Path $dir -ChildPath $exe
$checksum = '3D0BD4A90F04FF1F48B45E63338C593E1466D38C1AF90A7DF9F58805A9EA13E6'
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
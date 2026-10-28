$packageName = 'winbox'
$appName = 'WinBox'
$url = 'https://download.mikrotik.com/routeros/winbox/3.0beta1/winbox.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$exe = $packageName + '.exe'
$fullPath = Join-Path -Path $dir -ChildPath $exe
$checksum = '90E9200FD0419503C93F170660AC804ACA151CC74EE8A79CB6F3A53DB2F82B21'
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
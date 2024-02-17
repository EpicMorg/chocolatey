$packageName = 'winbox'
$appName = 'WinBox'
$url32 = 'https://download.mikrotik.com/winbox/3.37/winbox.exe'
$url64 = 'https://download.mikrotik.com/winbox/3.37/winbox64.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$is64 = ((Get-ProcessorBits 64) -and !$env:chocolateyForceX86)
$processName32 = 'winbox'
$processName64 = 'winbox64'
$processName = If ($is64) { $processName64 } Else { $processName32 }
$exe = $processName + '.exe'
$fullPath = Join-Path -Path $dir -ChildPath $exe
$checksum32 = '94336289cf2e1de339b75d6a799a7855eabbe55bc1b9b4dd2bbd94c316188afe'
$checksum64 = 'abe696e45809f26b0320926a0014d3088dcc5ac43d553a2b7a4e25f54a047439'
$checksumType = 'sha256'

$startFolder = $appName

Function CreateStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) `
        -ChildPath $startFolder
    New-Item $startMenuFolderPath -Type Directory -ErrorAction SilentlyContinue
    If (Test-Path -Path $startMenuFolderPath -PathType Container) {
            Install-ChocolateyShortcut -shortcutFilePath `
                (Join-Path -Path $startMenuFolderPath -ChildPath ($appName + '.lnk')) `
                -targetPath $fullPath -workingDirectory $dir
    } Else {
        Write-Warning "Start menu folder couldn't be created."
    }
}

# SCRIPT STARTS HERE #

Stop-Process -Name $processName32 -ErrorAction SilentlyContinue
Stop-Process -Name $processName64 -ErrorAction SilentlyContinue

# Workaround for https://github.com/chocolatey/choco/issues/952
Remove-Item -Path $fullPath -Force -Confirm:$FALSE -ErrorAction SilentlyContinue

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $fullPath -Url $url32 -Url64bit $url64 -Checksum $checksum32 -ChecksumType $checksumType -Checksum64 $checksum64 -ChecksumType64 $ChecksumType

# create .gui file
New-Item -Path $dir -Name ($exe + '.gui') -ItemType file

CreateStartMenuShortcut


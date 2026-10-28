$packageName = 'winbox'
$appName = 'WinBox'
$url32 = 'https://download.mikrotik.com/routeros/winbox/3.26/winbox.exe'
$url64 = 'https://download.mikrotik.com/routeros/winbox/3.26/winbox64.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$is64 = ((Get-ProcessorBits 64) -and !$env:chocolateyForceX86)
$processName32 = 'winbox'
$processName64 = 'winbox64'
$processName = If ($is64) { $processName64 } Else { $processName32 }
$exe = $processName + '.exe'
$fullPath = Join-Path -Path $dir -ChildPath $exe
$checksum32 = 'CD9E2F3F5A123CC8C765A8B31249BE35A2A9B1DCFA50DF556054AC2FF96C5C63'
$checksum64 = '28AB2B8821AF73E1882ACA535A18F025455875AEE8A1C97954B142667790CB5D'
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

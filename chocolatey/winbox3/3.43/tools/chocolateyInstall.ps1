$packageName = 'winbox3'
$appName = 'WinBox3'
$url32 = 'https://download.mikrotik.com/routeros/winbox/3.43/winbox.exe'
$url64 = 'https://download.mikrotik.com/routeros/winbox/3.43/winbox64.exe'
$dir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$is64 = ((Get-ProcessorBits 64) -and !$env:chocolateyForceX86)

# Базовое имя всегда winbox3 для удобства вызова из консоли
$exePrimary = 'winbox3.exe'
$fullPathPrimary = Join-Path -Path $dir -ChildPath $exePrimary

$checksum32 = 'A4038E4E09A34285C8DA8D8C2930EE38EA5BEEAD2B6FFCD60130CDC8030E2E6B'
$checksum64 = '5B41CF51FD81E8D082687F6B522159CF4ABA22E6DF8EDC486721D4E09507B6E9'
$checksumType = 'sha256'

$startFolder = $appName

Function CreateStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) -ChildPath $startFolder
    New-Item $startMenuFolderPath -Type Directory -ErrorAction SilentlyContinue
    If (Test-Path -Path $startMenuFolderPath -PathType Container) {
            Install-ChocolateyShortcut -shortcutFilePath `
                (Join-Path -Path $startMenuFolderPath -ChildPath ($appName + '.lnk')) `
                -targetPath $fullPathPrimary -workingDirectory $dir
    }
}

Stop-Process -Name 'winbox3' -ErrorAction SilentlyContinue
Stop-Process -Name 'winbox3-64' -ErrorAction SilentlyContinue

Remove-Item -Path $fullPathPrimary -Force -Confirm:$FALSE -ErrorAction SilentlyContinue

Get-ChocolateyWebFile -PackageName $packageName `
    -FileFullPath $fullPathPrimary `
    -Url $url32 -Url64bit $url64 `
    -Checksum $checksum32 -ChecksumType $checksumType `
    -Checksum64 $checksum64 -ChecksumType64 $ChecksumType

New-Item -Path $dir -Name ($exePrimary + '.gui') -ItemType file | Out-Null

If ($is64) {
    $exe64 = 'winbox3-64.exe'
    $fullPath64 = Join-Path -Path $dir -ChildPath $exe64
    Copy-Item -Path $fullPathPrimary -Destination $fullPath64 -Force
    New-Item -Path $dir -Name ($exe64 + '.gui') -ItemType file | Out-Null
}

CreateStartMenuShortcut
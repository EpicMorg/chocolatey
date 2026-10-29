$packageName = 'winbox'
$appName = 'WinBox'
$version = '4.2rc1'
$url = "https://download.mikrotik.com/routeros/winbox/$version/WinBox_Windows.zip"

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$is64 = (Get-ProcessorBits 64)
If (!$is64) { throw "WinBox 4 requires a 64-bit operating system." }

$processName = 'WinBox'
$exe = 'WinBox.exe'
$exe64 = 'winbox64.exe'
$fullPath = Join-Path -Path $toolsDir -ChildPath $exe
$fullPath64 = Join-Path -Path $toolsDir -ChildPath $exe64

$checksum = 'A14700167EE90AA864B81B5D12B3BEA39489B5F1E52FA508ABEADB10EA9F04BA' 
$checksumType = 'sha256'

$startFolder = $appName

Function CreateStartMenuShortcut {
    $startMenuFolderPath = Join-Path -Path ([Environment]::GetFolderPath('Programs')) -ChildPath $startFolder
    New-Item $startMenuFolderPath -Type Directory -ErrorAction SilentlyContinue
    If (Test-Path -Path $startMenuFolderPath -PathType Container) {
            Install-ChocolateyShortcut -shortcutFilePath `
                (Join-Path -Path $startMenuFolderPath -ChildPath ($appName + '.lnk')) `
                -targetPath $fullPath -workingDirectory $toolsDir
    } Else {
        Write-Warning "Start menu folder couldn't be created."
    }
}

Stop-Process -Name $processName -ErrorAction SilentlyContinue
Stop-Process -Name "winbox64" -ErrorAction SilentlyContinue

Install-ChocolateyZipPackage -PackageName $packageName `
    -Url $url `
    -UnzipLocation $toolsDir `
    -Checksum $checksum `
    -ChecksumType $checksumType

Copy-Item -Path $fullPath -Destination $fullPath64 -Force

New-Item -Path $toolsDir -Name ($exe + '.gui') -ItemType file -Force | Out-Null
New-Item -Path $toolsDir -Name ($exe64 + '.gui') -ItemType file -Force | Out-Null

CreateStartMenuShortcut
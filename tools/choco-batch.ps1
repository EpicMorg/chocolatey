<#
.SYNOPSIS
  Run choco pack / push / install / uninstall over every version folder of a package (or of all packages).

.DESCRIPTION
  Finds every *.nuspec under <Path>, recursively (e.g. chocolatey\thedude\7.25\thedude.nuspec;
  point it at chocolatey\ to take all packages), sorts them by package id and version
  (pre-releases before their release) and runs the given actions for each version,
  in the order given. The nuspecs are only read, never modified:

    pack       choco pack <nuspec> --out <version dir>  (skipped if the nupkg is already there, unless -Force)
    push       choco push --source=https://push.chocolatey.org/ <version dir>\<id>.<ver>.nupkg
    install    choco install <id> --version <ver> from the version dir (+ community feed for dependencies)
    uninstall  choco uninstall <id>

  The API key is taken from choco's config (choco apikey). Pre-release versions
  get --pre automatically. A failed push stops the run (usually the moderation
  queue limit) unless -ContinueOnError is set.

.EXAMPLE
  .\tools\choco-batch.ps1 chocolatey\thedude pack -WhatIf
  Show the pack commands for every thedude version without running them.

.EXAMPLE
  .\tools\choco-batch.ps1 chocolatey\thedude pack,push -From 7.21 -To 7.25
  Pack and push thedude 7.21 ... 7.25.

.EXAMPLE
  .\tools\choco-batch.ps1 chocolatey\thedude push -Exclude 7.20.5
  Push every thedude version except the already published 7.20.5.

.EXAMPLE
  .\tools\choco-batch.ps1 chocolatey\thedude install,uninstall -Version 7.25
  Local install + uninstall test of one version.
#>
[CmdletBinding()]
param(
  # Folder searched recursively for *.nuspec, e.g. chocolatey\thedude or chocolatey.
  [Parameter(Mandatory, Position = 0)]
  [string]$Path,

  # One or more of: pack, push, install, uninstall (run per version in this order).
  [Parameter(Mandatory, Position = 1)]
  [string[]]$Action,

  # Only these versions (folder name or nuspec version, wildcards allowed).
  [string[]]$Version,

  # Skip these versions (same matching as -Version), e.g. -Exclude 7.20.5.
  [string[]]$Exclude,

  # Version range (inclusive), compared on the numeric part: -From 7.0 -To 7.25.
  [string]$From,
  [string]$To,

  # Push target.
  [string]$Source = 'https://push.chocolatey.org/',

  # Seconds to wait between pushes.
  [int]$Delay = 0,

  # pack: rebuild even if the version's nupkg already exists (it is overwritten).
  # install: pass --force to choco (reinstall / switch between versions).
  [switch]$Force,

  # Keep going after a failed command.
  [switch]$ContinueOnError,

  # Only print the commands.
  [switch]$WhatIf
)

$ErrorActionPreference = 'Stop'
$communityFeed = 'https://community.chocolatey.org/api/v2/'

# 7.20.5 -> 7.20.5.0 ; 3.0.0.20250101-beta1 -> 3.0.0.20250101 ; 7.25 -> 7.25.0.0
function Get-NumericVersion([string]$v) {
  $num = ($v -split '-', 2)[0]
  $parts = @($num.Split('.') | ForEach-Object { [int]$_ })
  while ($parts.Count -lt 4) { $parts += 0 }
  [version]::new($parts[0], $parts[1], $parts[2], $parts[3])
}

# Accept both `pack,push` (array) and "pack,push" (one string, e.g. from cmd / -File).
$Action = @($Action -split ',' | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_ })
$bad = $Action | Where-Object { $_ -notin 'pack', 'push', 'install', 'uninstall' }
if ($bad) { throw "Unknown action(s): $($bad -join ', '). Use pack, push, install, uninstall." }

$root = Resolve-Path -LiteralPath $Path
$items = foreach ($nuspec in Get-ChildItem -LiteralPath $root -Filter '*.nuspec' -File -Recurse) {
  $dir = $nuspec.Directory
  $meta = ([xml](Get-Content -LiteralPath $nuspec.FullName -Raw)).package.metadata
  $ver = $meta.version.Trim()
  if ($ver -notmatch '^\d+(\.\d+){0,3}(-[0-9A-Za-z.-]+)?$') {
    Write-Warning "Skipping $([IO.Path]::GetRelativePath($root, $nuspec.FullName)): unexpected version '$ver' in $($nuspec.Name)."
    continue
  }
  [pscustomobject]@{
    Dir        = $dir.FullName
    Name       = $dir.Name
    Nuspec     = $nuspec.FullName
    Id         = $meta.id.Trim()
    Version    = $ver
    Numeric    = Get-NumericVersion $ver
    Prerelease = ($ver -split '-', 2)[1]
  }
}

if ($Version) {
  $items = $items | Where-Object { $i = $_; $Version | Where-Object { $i.Name -like $_ -or $i.Version -like $_ } }
}
if ($Exclude) {
  $items = $items | Where-Object { $i = $_; -not ($Exclude | Where-Object { $i.Name -like $_ -or $i.Version -like $_ }) }
}
if ($From) { $lo = Get-NumericVersion $From; $items = $items | Where-Object { $_.Numeric -ge $lo } }
if ($To)   { $hi = Get-NumericVersion $To;   $items = $items | Where-Object { $_.Numeric -le $hi } }

# Pre-releases sort before the release with the same numeric version.
$items = @($items | Sort-Object Id, Numeric, @{ Expression = { [bool]$_.Prerelease }; Descending = $true }, Prerelease)
if (-not $items) { Write-Warning "No version folders matched under $root."; return }
$ids = @($items.Id | Select-Object -Unique)
Write-Host "$($items.Count) version(s) of $($ids -join ', '); actions: $($Action -join ', ')" -ForegroundColor Cyan

# The version's nupkg in its folder. choco v2 normalises the file name
# (7.25 -> 7.25.0), so compare the numeric part and the pre-release tag.
function Find-Nupkg($i) {
  Get-ChildItem -LiteralPath $i.Dir -Filter "$($i.Id).*.nupkg" -File | Where-Object {
    $v = $_.BaseName.Substring($i.Id.Length + 1)
    $v -match '^\d+(\.\d+){0,3}(-[0-9A-Za-z.-]+)?$' -and
      (Get-NumericVersion $v) -eq $i.Numeric -and ($v -split '-', 2)[1] -eq $i.Prerelease
  } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

function Invoke-Choco([string[]]$chocoArgs) {
  Write-Host "> choco $($chocoArgs -join ' ')" -ForegroundColor DarkGray
  if ($WhatIf) { return $true }
  # Show choco's output but keep it out of the return value (otherwise the
  # function returns the log lines and any failure looks like success).
  & choco @chocoArgs 2>&1 | Tee-Object -Variable log | Out-Host
  $code = $LASTEXITCODE
  # 1641 / 3010: success, reboot required
  if ($code -notin 0, 1641, 3010) { return $false }
  # Belt and braces: a rejected push (e.g. 403 when too many versions are in the
  # moderation queue) must not pass as success even if choco exits with 0.
  if ($chocoArgs[0] -eq 'push' -and ($log -match '\(403\)|Forbidden|Failed to process request|ERROR')) { return $false }
  return $true
}

$failed = @()
$pushed = 0
:versions foreach ($i in $items) {
  Write-Host "== $($i.Id) $($i.Version) [$($i.Name)]" -ForegroundColor Yellow
  foreach ($a in $Action) {
    $pre = if ($i.Prerelease) { @('--pre') } else { @() }
    switch ($a) {
      'pack' {
        $existing = Find-Nupkg $i
        if ($existing -and -not $Force) {
          Write-Warning "$($existing.Name) already exists - not repacking (use -Force to overwrite)."
          $ok = $true
        } else {
          $ok = Invoke-Choco @('pack', $i.Nuspec, "--out=$($i.Dir)")
        }
      }
      'push' {
        $nupkg = Find-Nupkg $i
        if (-not $nupkg -and -not $WhatIf) {
          Write-Warning "No $($i.Id) nupkg in $($i.Dir) - run pack first."
          $ok = $false
        } else {
          if ($pushed -gt 0 -and $Delay -gt 0 -and -not $WhatIf) { Start-Sleep -Seconds $Delay }
          $file = if ($nupkg) { $nupkg.FullName } else { Join-Path $i.Dir "$($i.Id).$($i.Version).nupkg" }
          $ok = Invoke-Choco @('push', "--source=$Source", $file)
          $pushed++
        }
      }
      'install' {
        $extra = if ($Force) { @('--force') } else { @() }
        $ok = Invoke-Choco (@('install', $i.Id, "--version=$($i.Version)", "--source=$($i.Dir);$communityFeed", '-y') + $pre + $extra)
      }
      'uninstall' {
        $ok = Invoke-Choco @('uninstall', $i.Id, '-y')
      }
    }
    if (-not $ok) {
      $failed += "$($i.Version) $a"
      Write-Warning "$($i.Id) $($i.Version): $a failed."
      if ($ContinueOnError) { continue versions }
      $hint = if ($a -eq 'push' -and $nupkg) { ' (moderation queue limit?)' } else { '' }
      Write-Warning "Stopping$hint. Use -ContinueOnError to keep going."
      Write-Warning "To resume: -From $($i.Version)"
      break versions
    }
  }
}

if ($failed) {
  Write-Host "Failed: $($failed -join '; ')" -ForegroundColor Red
  exit 1
}
Write-Host 'Done.' -ForegroundColor Green

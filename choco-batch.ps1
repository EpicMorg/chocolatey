<#
.SYNOPSIS
  Run choco pack / push / install / uninstall over every version folder of a package.

.DESCRIPTION
  Walks <Path>\<version>\*.nuspec (e.g. chocolatey\thedude\7.25\thedude.nuspec),
  sorted by version (pre-releases before their release), and runs the given
  actions for each version, in the order given:

    pack       choco pack <nuspec> --out <version dir>  (skipped if the nupkg is already there, unless -Force)
    push       choco push --source=https://push.chocolatey.org/ <version dir>\<id>.<ver>.nupkg
    install    choco install <id> --version <ver> from the version dir (+ community feed for dependencies)
    uninstall  choco uninstall <id>

  The API key is taken from choco's config (choco apikey). Pre-release versions
  get --pre automatically. A failed push stops the run (usually the moderation
  queue limit) unless -ContinueOnError is set.

.EXAMPLE
  .\choco-batch.ps1 chocolatey\thedude pack -WhatIf
  Show the pack commands for every thedude version without running them.

.EXAMPLE
  .\choco-batch.ps1 chocolatey\thedude pack,push -From 7.21 -To 7.25
  Pack and push thedude 7.21 ... 7.25.

.EXAMPLE
  .\choco-batch.ps1 chocolatey\thedude install,uninstall -Version 7.25
  Local install + uninstall test of one version.
#>
[CmdletBinding()]
param(
  # Package folder holding the version folders, e.g. chocolatey\thedude.
  [Parameter(Mandatory, Position = 0)]
  [string]$Path,

  # One or more of: pack, push, install, uninstall (run per version in this order).
  [Parameter(Mandatory, Position = 1)]
  [string[]]$Action,

  # Only these versions (folder name or nuspec version, wildcards allowed).
  [string[]]$Version,

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
$items = foreach ($dir in Get-ChildItem -LiteralPath $root -Directory) {
  $nuspec = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.nuspec' -File | Select-Object -First 1
  if (-not $nuspec) { continue }
  $meta = ([xml](Get-Content -LiteralPath $nuspec.FullName -Raw)).package.metadata
  $ver = $meta.version.Trim()
  if ($ver -notmatch '^\d+(\.\d+){0,3}(-[0-9A-Za-z.-]+)?$') {
    Write-Warning "Skipping $($dir.Name): unexpected version '$ver' in $($nuspec.Name)."
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
if ($From) { $lo = Get-NumericVersion $From; $items = $items | Where-Object { $_.Numeric -ge $lo } }
if ($To)   { $hi = Get-NumericVersion $To;   $items = $items | Where-Object { $_.Numeric -le $hi } }

# Pre-releases sort before the release with the same numeric version.
$items = @($items | Sort-Object Numeric, @{ Expression = { [bool]$_.Prerelease }; Descending = $true }, Prerelease)
if (-not $items) { Write-Warning "No version folders matched under $root."; return }
Write-Host "$($items.Count) version(s): $($items[0].Version) .. $($items[-1].Version); actions: $($Action -join ', ')" -ForegroundColor Cyan

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
  & choco @chocoArgs
  # 1641 / 3010: success, reboot required
  return ($LASTEXITCODE -in 0, 1641, 3010)
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
      $hint = if ($a -eq 'push') { ' (moderation queue limit?)' } else { '' }
      Write-Warning "Stopping$hint. Use -ContinueOnError to keep going."
      break versions
    }
  }
}

if ($failed) {
  Write-Host "Failed: $($failed -join '; ')" -ForegroundColor Red
  exit 1
}
Write-Host 'Done.' -ForegroundColor Green

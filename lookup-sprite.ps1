param(
    [Parameter(Mandatory = $true, Position = 0)]
    [int]$SpriteId,

    [Parameter(Position = 1)]
    [string]$NfoPath = "$env:TEMP\brtrainsAOpushpulltest_tmp.nfo",

    [Parameter(Position = 2)]
    [string]$BuildNmlPath = "build\brtrains2AOpushpulltest.nml",

    [Parameter(Position = 3)]
    [string]$SrcRoot = "src",

    [switch]$NoSourceLookup
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Normalize-PathToken {
    param([string]$Value)
    return $Value.Replace("\", "/").ToLowerInvariant()
}

if (-not (Test-Path -LiteralPath $NfoPath)) {
    throw "NFO file not found: $NfoPath"
}

if (-not (Test-Path -LiteralPath $BuildNmlPath)) {
    throw "Build NML file not found: $BuildNmlPath"
}

$nfoLines = Get-Content -LiteralPath $NfoPath
$spriteLine = $nfoLines | Where-Object { $_ -match "^\s*$SpriteId\s+" } | Select-Object -First 1
if (-not $spriteLine) {
    throw "Sprite ID $SpriteId was not found in $NfoPath"
}

$spritePattern = '^\s*(?<id>\d+)\s+(?<img>.+?)\s+8bpp\s+(?<x>-?\d+)\s+(?<y>-?\d+)\s+(?<w>-?\d+)\s+(?<h>-?\d+)\s+(?<ox>-?\d+)\s+(?<oy>-?\d+)\s+(?<kind>\S+)'
if (-not ($spriteLine -match $spritePattern)) {
    throw "Could not parse sprite line: $spriteLine"
}

$img = $matches["img"]
$x = [int]$matches["x"]
$y = [int]$matches["y"]
$w = [int]$matches["w"]
$h = [int]$matches["h"]
$ox = [int]$matches["ox"]
$oy = [int]$matches["oy"]

$imgNorm = Normalize-PathToken $img
$buildLines = Get-Content -LiteralPath $BuildNmlPath
$templateRegex = [regex]'(?<call>template_[A-Za-z0-9_]+\(\s*(?<tx>-?\d+)\s*,\s*(?<ty>-?\d+)\s*\))'
$spritesetRegex = [regex]'^\s*spriteset\s*\(\s*(?<name>[A-Za-z0-9_]+)\s*,\s*"(?<path>[^"]+)"\s*\)\s*\{'

$hits = New-Object System.Collections.Generic.List[object]

for ($i = 0; $i -lt $buildLines.Length; $i++) {
    $line = $buildLines[$i]
    $ss = $spritesetRegex.Match($line)
    if (-not $ss.Success) {
        continue
    }

    $setName = $ss.Groups["name"].Value
    $setPath = $ss.Groups["path"].Value
    if ((Normalize-PathToken $setPath) -ne $imgNorm) {
        continue
    }

    $max = [Math]::Min($i + 8, $buildLines.Length - 1)
    $window = $buildLines[($i + 1)..$max] -join "`n"
    $tm = $templateRegex.Match($window)
    if (-not $tm.Success) {
        continue
    }

    $ty = [int]$tm.Groups["ty"].Value
    if ($ty -ne $y) {
        continue
    }

    $hits.Add([pscustomobject]@{
        BuildLine      = $i + 1
        Spriteset      = $setName
        TemplateCall   = $tm.Groups["call"].Value
        BuildNmlPath   = $BuildNmlPath
        SourcePath     = $null
        SourceLine     = $null
    })
}

if ($hits.Count -eq 0) {
    Write-Host "Sprite: $SpriteId"
    Write-Host "  NFO line: $spriteLine"
    Write-Host "  Parsed: image=$img x=$x y=$y size=${w}x${h} offset=($ox,$oy)"
    Write-Host ""
    Write-Host "No matching spriteset/template found in $BuildNmlPath."
    Write-Host "This usually means the NFO came from grfcodec decode of a compiled GRF,"
    Write-Host "not from nmlc output for the same source state."
    Write-Host ""
    Write-Host "Generate a matching NFO with:"
    Write-Host "  .\nmlc.exe --grf $env:TEMP\brtrainsAOpushpulltest_tmp.grf --nfo $env:TEMP\brtrainsAOpushpulltest_tmp.nfo build\brtrains2AOpushpulltest.nml"
    exit 2
}

if (-not $NoSourceLookup) {
    if (-not (Test-Path -LiteralPath $SrcRoot)) {
        Write-Warning "Source root not found: $SrcRoot"
    } else {
        $srcFiles = Get-ChildItem -Path $SrcRoot -Recurse -File -Filter *.pnml
        foreach ($hit in $hits) {
            $pat = "spriteset\s*\(\s*" + [regex]::Escape($hit.Spriteset) + "\s*,"
            $srcMatch = $srcFiles | Select-String -Pattern $pat | Select-Object -First 1
            if ($srcMatch) {
                $hit.SourcePath = $srcMatch.Path
                $hit.SourceLine = $srcMatch.LineNumber
            }
        }
    }
}

Write-Host "Sprite: $SpriteId"
Write-Host "  NFO line: $spriteLine"
Write-Host "  Parsed: image=$img x=$x y=$y size=${w}x${h} offset=($ox,$oy)"
Write-Host ""

$idx = 1
foreach ($hit in $hits) {
    Write-Host ("Match #{0}" -f $idx)
    Write-Host ("  Build: {0}:{1}" -f $hit.BuildNmlPath, $hit.BuildLine)
    Write-Host ("  Spriteset: {0}" -f $hit.Spriteset)
    Write-Host ("  Template:  {0}" -f $hit.TemplateCall)
    if ($hit.SourcePath) {
        Write-Host ("  Source:    {0}:{1}" -f $hit.SourcePath, $hit.SourceLine)
    }
    $idx++
}

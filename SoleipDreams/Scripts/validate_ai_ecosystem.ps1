param()

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir "..\..")
Set-Location $repoRoot

$instructionDir = Join-Path $repoRoot ".github\instructions"
$agentDir = Join-Path $repoRoot ".github\agents"
$skillsDir = Join-Path $repoRoot ".github\skills"
$manifestPath = Join-Path $repoRoot "SoleipDreams\AI-Ecosystem\MANIFEST.md"

$checksFailed = 0
$checksPassed = 0

function Pass($message) {
    $script:checksPassed += 1
    Write-Output "PASS: $message"
}

function Fail($message) {
    $script:checksFailed += 1
    Write-Output "FAIL: $message"
}

function Test-FrontmatterAndDescription($filePath, $requireUseWhen) {
    $content = Get-Content -Raw $filePath
    if (-not $content.StartsWith("---")) {
        Fail "$filePath missing starting frontmatter delimiter"
        return
    }

    if ($content -notmatch '(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n') {
        Fail "$filePath missing closing frontmatter delimiter"
        return
    }

    $frontmatter = $Matches[1]
    if ($frontmatter -notmatch '(?m)^description:\s*".+"') {
        Fail "$filePath missing description field in frontmatter"
    } else {
        Pass "$filePath has description field"
    }

    if ($requireUseWhen) {
        if ($frontmatter -match "Use when") {
            Pass "$filePath description has Use when trigger"
        } else {
            Fail "$filePath description missing Use when trigger"
        }
    }
}

if (Test-Path $instructionDir) { Pass "$instructionDir exists" } else { Fail "$instructionDir missing" }
if (Test-Path $agentDir) { Pass "$agentDir exists" } else { Fail "$agentDir missing" }
if (Test-Path $skillsDir) { Pass "$skillsDir exists" } else { Fail "$skillsDir missing" }
if (Test-Path $manifestPath) { Pass "$manifestPath exists" } else { Fail "$manifestPath missing" }

$instructionFiles = Get-ChildItem -Path $instructionDir -Filter "*.instructions.md" -File -Recurse
$agentFiles = Get-ChildItem -Path $agentDir -Filter "*.agent.md" -File -Recurse
$skillFiles = Get-ChildItem -Path $skillsDir -Filter "SKILL.md" -File -Recurse

if ($instructionFiles.Count -gt 0) { Pass "Found $($instructionFiles.Count) instruction files" } else { Fail "No instruction files found" }
if ($agentFiles.Count -gt 0) { Pass "Found $($agentFiles.Count) agent files" } else { Fail "No agent files found" }
if ($skillFiles.Count -gt 0) { Pass "Found $($skillFiles.Count) skill files" } else { Fail "No skill files found" }

foreach ($f in $instructionFiles) {
    Test-FrontmatterAndDescription -filePath $f.FullName -requireUseWhen $true
}

foreach ($f in $agentFiles) {
    Test-FrontmatterAndDescription -filePath $f.FullName -requireUseWhen $true
}

foreach ($f in $skillFiles) {
    Test-FrontmatterAndDescription -filePath $f.FullName -requireUseWhen $true
}

if (Test-Path $manifestPath) {
    $manifest = Get-Content -Raw $manifestPath

    foreach ($f in $skillFiles) {
        $skillName = Split-Path -Leaf (Split-Path -Parent $f.FullName)
        if ($manifest -match "\| Skill \|\s*$([regex]::Escape($skillName))\s*\|") {
            Pass "Manifest contains skill $skillName"
        } else {
            Fail "Manifest missing skill $skillName"
        }
    }

    foreach ($f in $agentFiles) {
        $agentName = [IO.Path]::GetFileNameWithoutExtension([IO.Path]::GetFileNameWithoutExtension($f.Name))
        if ($manifest -match "\| Agent \|\s*$([regex]::Escape($agentName))\s*\|") {
            Pass "Manifest contains agent $agentName"
        } else {
            Fail "Manifest missing agent $agentName"
        }
    }
}

Write-Output ""
Write-Output "Summary: PASS=$checksPassed FAIL=$checksFailed"

if ($checksFailed -gt 0) {
    exit 1
}

exit 0

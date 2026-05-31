# ============================================================
# ComfyUI Backup Script
# Guarda user/, workflows y manifests en una carpeta de backup
# ============================================================
# Uso:
#   .\SoleipDreams\Scripts\backup_comfyui.ps1                    # Backup completo
#   .\SoleipDreams\Scripts\backup_comfyui.ps1 -IncludeOutput     # + carpeta output/ (imagenes generadas)
#   .\SoleipDreams\Scripts\backup_comfyui.ps1 -Destination D:\Backups\ComfyUI
# ============================================================

param(
    [switch]$IncludeOutput,
    [string]$Destination = "D:\IA\Backups\ComfyUI"
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$BackupDir = Join-Path $Destination $Timestamp

function Info    { param($msg) Write-Host "  $msg" -ForegroundColor Cyan }
function Success { param($msg) Write-Host "  [OK] $msg" -ForegroundColor Green }
function Warn    { param($msg) Write-Host "  [!]  $msg" -ForegroundColor Yellow }
function Header  { param($msg) Write-Host "`n=== $msg ===" -ForegroundColor Magenta }

function Format-Size {
    param([long]$Bytes)
    if ($Bytes -gt 1GB) { return "{0:F1} GB" -f ($Bytes / 1GB) }
    if ($Bytes -gt 1MB) { return "{0:F1} MB" -f ($Bytes / 1MB) }
    return "{0:F0} KB" -f ($Bytes / 1KB)
}

# ---- Banner ----
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ComfyUI Backup" -ForegroundColor Yellow
Write-Host "  Destino: $BackupDir" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan

# ---- Crear directorio de backup ----
Header "1. Preparando directorio de backup"
if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
}
New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
Success "Carpeta creada: $BackupDir"

$TotalSize = 0

# ---- Backup user/ ----
Header "2. Backup user/ (settings, DB, Manager state)"
$UserSrc = Join-Path $SourceDir "user"
$UserDst = Join-Path $BackupDir "user"
if (Test-Path $UserSrc) {
    Copy-Item -Path $UserSrc -Destination $UserDst -Recurse -Force
    $UserSize = (Get-ChildItem $UserDst -Recurse | Measure-Object -Property Length -Sum).Sum
    $TotalSize += $UserSize
    Success "user/ copiado ($(Format-Size $UserSize))"
    Info "  - comfyui.db (historial de workflows y settings)"
    Info "  - comfy.settings.json (preferencias UI)"
    Info "  - __manager/ (estado de ComfyUI Manager)"
} else {
    Warn "user/ no encontrado en $SourceDir"
}

# ---- Backup manifests ----
Header "3. Backup manifests (recuperabilidad)"
$Manifests = @(
    "MODELS_MANIFEST.md",
    "CUSTOM_NODES.md",
    "SoleipDreams\Scripts\update_comfyui.ps1",
    "SoleipDreams\Scripts\backup_comfyui.ps1",
    "SoleipDreams\Scripts\comfyui_hub.ps1",
    "SoleipDreams\ComfyUI.lnk",
    "requirements.txt"
)
$ManifestDst = Join-Path $BackupDir "manifests"
New-Item -ItemType Directory -Path $ManifestDst -Force | Out-Null
foreach ($file in $Manifests) {
    $src = Join-Path $SourceDir $file
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $ManifestDst -Force
        Success "$file"
    } else {
        Warn "$file no encontrado (omitido)"
    }
}

# ---- Backup SoleipDreams/ ----
Header "4. Backup SoleipDreams/ (proyectos personales)"
$SoleipSrc = Join-Path $SourceDir "SoleipDreams"
$SoleipDst = Join-Path $BackupDir "SoleipDreams"
if (Test-Path $SoleipSrc) {
    Copy-Item -Path $SoleipSrc -Destination $SoleipDst -Recurse -Force
    $SoleipSize = (Get-ChildItem $SoleipDst -Recurse -File | Measure-Object -Property Length -Sum).Sum
    $TotalSize += $SoleipSize
    Success "SoleipDreams/ copiado ($(Format-Size $SoleipSize))"
} else {
    Warn "SoleipDreams/ no encontrado (omitido)"
}

# ---- Backup output/ (opcional) ----
if ($IncludeOutput) {
    Header "5. Backup output/ (imagenes generadas)"
    $OutputSrc = Join-Path $SourceDir "output"
    $OutputDst = Join-Path $BackupDir "output"
    if (Test-Path $OutputSrc) {
        Copy-Item -Path $OutputSrc -Destination $OutputDst -Recurse -Force
        $OutSize = (Get-ChildItem $OutputDst -Recurse -File | Measure-Object -Property Length -Sum).Sum
        $TotalSize += $OutSize
        Success "output/ copiado ($(Format-Size $OutSize))"
    } else {
        Warn "output/ no encontrado (omitido)"
    }
} else {
    Info "Omitiendo output/ (usa -IncludeOutput para incluir imagenes generadas)"
}

# ---- Generar index del backup ----
Header "6. Generando index"
$IndexPath = Join-Path $BackupDir "BACKUP_INDEX.txt"
$IndexContent = @"
ComfyUI Backup - $Timestamp
Fuente: $SourceDir
ComfyUI version: $(Select-String -Path "$SourceDir\comfyui_version.py" -Pattern '__version__.*"([^"]+)"' | ForEach-Object { $_.Matches[0].Groups[1].Value })

Contenido:
"@

Get-ChildItem $BackupDir -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Replace($BackupDir, "").TrimStart("\")
    $IndexContent += "`n  $rel ($(Format-Size $_.Length))"
}

Set-Content -Path $IndexPath -Value $IndexContent -Encoding UTF8
Success "BACKUP_INDEX.txt generado"

# ---- Listar backups anteriores ----
Header "7. Backups existentes en $Destination"
Get-ChildItem $Destination -Directory | Sort-Object Name -Descending | Select-Object -First 10 | ForEach-Object {
    $size = (Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    Info "$($_.Name)  ($(Format-Size $size))"
}

# ---- Resumen ----
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Backup completado" -ForegroundColor Green
Write-Host "  Tamano total: $(Format-Size $TotalSize)" -ForegroundColor White
Write-Host "  Ubicacion:    $BackupDir" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para restaurar user/ (settings y workflows):" -ForegroundColor Yellow
Write-Host "  Copy-Item -Recurse `"$BackupDir\user`" D:\IA\ComfyUI\" -ForegroundColor Gray
Write-Host ""

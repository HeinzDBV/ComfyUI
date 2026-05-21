# ============================================================
# ComfyUI Updater - Instalacion manual con git
# Sincroniza con Comfy-Org/ComfyUI (upstream) y actualiza deps
# ============================================================
# Uso:
#   .\update_comfyui.ps1                   # Update normal
#   .\update_comfyui.ps1 -UpdateTorch      # Update + reinstala PyTorch
#   .\update_comfyui.ps1 -PushFork         # Update + push a tu fork (origin)
#   .\update_comfyui.ps1 -DryRun           # Solo muestra qu? cambio sin aplicar
# ============================================================

param(
    [switch]$UpdateTorch,
    [switch]$PushFork,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# ---- Colores utiles ----
function Info    { param($msg) Write-Host "  $msg" -ForegroundColor Cyan }
function Success { param($msg) Write-Host "  [OK] $msg" -ForegroundColor Green }
function Warn    { param($msg) Write-Host "  [!]  $msg" -ForegroundColor Yellow }
function Err     { param($msg) Write-Host "  [X]  $msg" -ForegroundColor Red }
function Header  { param($msg) Write-Host "`n=== $msg ===" -ForegroundColor Magenta }

function Get-LocalVersion {
    $ver = Select-String -Path "$ScriptDir\comfyui_version.py" -Pattern '__version__\s*=\s*"([^"]+)"'
    if ($ver) { return $ver.Matches[0].Groups[1].Value }
    return "desconocida"
}

function Get-PipExe {
    $pip = "$ScriptDir\.venv\Scripts\pip.exe"
    if (-not (Test-Path $pip)) {
        Err "No se encontro .venv\Scripts\pip.exe"
        Err "Asegurate de tener el entorno virtual en .venv"
        exit 1
    }
    return $pip
}

# ---- Banner ----
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ComfyUI Updater" -ForegroundColor Yellow
Write-Host "  Sincroniza con Comfy-Org/ComfyUI (upstream)" -ForegroundColor White
if ($DryRun) { Write-Host "  MODO DRY-RUN - No se aplicaran cambios" -ForegroundColor Yellow }
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# ---- Verificar git ----
Header "1. Verificando git"
try {
    $null = git --version
    Success "git disponible"
} catch {
    Err "git no encontrado. Instala git y vuelve a intentar."
    exit 1
}

# ---- Guardar version antes ----
$versionAntes = Get-LocalVersion
Info "Version actual: $versionAntes"

# ---- Verificar estado del repo ----
Header "2. Estado del repositorio"
$dirty = git status --porcelain
if ($dirty) {
    Warn "Hay cambios sin commitear:"
    $dirty | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
    Warn "Los cambios locales en archivos del core podrian generar conflictos."
    $resp = Read-Host "  Continuar de todos modos? (s/N)"
    if ($resp -notmatch '^[sS]$') {
        Info "Cancelado por el usuario."
        exit 0
    }
} else {
    Success "Working tree limpio"
}

# ---- Fetch upstream ----
Header "3. Descargando cambios de upstream (Comfy-Org)"
$remotes = git remote
if ($remotes -notcontains "upstream") {
    Warn "Remote 'upstream' no configurado. Agregandolo..."
    if (-not $DryRun) {
        git remote add upstream https://github.com/Comfy-Org/ComfyUI.git
        Success "upstream agregado"
    }
}

if ($DryRun) {
    Info "[DRY-RUN] git fetch upstream"
} else {
    git fetch upstream
    Success "Fetch completado"
}

# ---- Mostrar commits nuevos ----
Header "4. Cambios disponibles"
$newCommits = git log --oneline HEAD..upstream/master
if (-not $newCommits) {
    Success "Ya estas al dia con upstream/master"
    if (-not $UpdateTorch) {
        Info "Usa -UpdateTorch para forzar reinstalacion de PyTorch de todos modos."
        exit 0
    }
} else {
    Info "Commits nuevos en upstream:"
    $newCommits | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
    $commitCount = ($newCommits | Measure-Object -Line).Lines
    Info "Total: $commitCount commits nuevos"
}

# ---- Merge ----
Header "5. Aplicando actualizacion"
if ($DryRun) {
    Info "[DRY-RUN] git merge upstream/master"
} else {
    git merge upstream/master --no-edit
    if ($LASTEXITCODE -ne 0) {
        Err "Conflicto durante el merge!"
        Warn "Archivos en conflicto:"
        git diff --name-only --diff-filter=U | ForEach-Object { Write-Host "    - $_" -ForegroundColor Gray }
        Warn ""
        Warn "Pasos para resolver:"
        Warn "  1. Edita los archivos conflictivos (busca <<<<<<< HEAD)"
        Warn "  2. git add <archivo>"
        Warn "  3. git commit --no-edit"
        Warn ""
        Warn "O descarta todo: git merge --abort"
        exit 1
    }
    $versionDespues = Get-LocalVersion
    if ($versionAntes -ne $versionDespues) {
        Success "Version actualizada: $versionAntes -> $versionDespues"
    } else {
        Success "Merge completado (version: $versionDespues)"
    }
}

# ---- Actualizar dependencias Python ----
Header "6. Actualizando dependencias Python"
$pip = Get-PipExe

if ($DryRun) {
    Info "[DRY-RUN] pip install -r requirements.txt --upgrade"
} else {
    Info "Instalando requirements.txt..."
    & $pip install -r requirements.txt --upgrade --quiet
    Success "requirements.txt actualizado"
}

# ---- Actualizar PyTorch (opcional) ----
if ($UpdateTorch) {
    Header "7. Reinstalando PyTorch (cu130)"
    Info "Esto puede tardar varios minutos..."
    if ($DryRun) {
        Info "[DRY-RUN] pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130"
    } else {
        & $pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130 --quiet
        $torchVer = & $pip show torch | Select-String "^Version:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
        Success "PyTorch $torchVer instalado"
    }
}

# ---- Push al fork (opcional) ----
if ($PushFork) {
    Header "8. Sincronizando fork (origin)"
    if ($DryRun) {
        Info "[DRY-RUN] git push origin master"
    } else {
        git push origin master
        Success "Fork actualizado en origin"
    }
}

# ---- Resumen final ----
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Actualizacion completada" -ForegroundColor Green
$versionFinal = Get-LocalVersion
Write-Host "  Version: $versionFinal" -ForegroundColor White
if ($UpdateTorch) {
    Write-Host "  PyTorch: reinstalado con cu130" -ForegroundColor White
}
if ($PushFork) {
    Write-Host "  Fork:    sincronizado con origin" -ForegroundColor White
}
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para iniciar ComfyUI usa:" -ForegroundColor Yellow
Write-Host "  .\run_comfyui_optimized.ps1   (RTX 4060 optimizado)" -ForegroundColor White
Write-Host "  .\run_comfyui.bat             (estandar)" -ForegroundColor White
Write-Host ""

# ============================================
# ComfyUI Launcher - Optimizado RTX 4060 8GB
# ============================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  ComfyUI - Splash Art LoL Workflow" -ForegroundColor Yellow
Write-Host "  Optimizado para RTX 4060 8GB" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Activar entorno virtual
Write-Host "[1/3] Activando entorno virtual..." -ForegroundColor Yellow
& .\.venv\Scripts\Activate.ps1

# Configurar variables de optimización
Write-Host "[2/3] Configurando optimizaciones para RTX 4060..." -ForegroundColor Yellow
$env:PYTORCH_CUDA_ALLOC_CONF = "garbage_collection_threshold:0.6,max_split_size_mb:128"

# Mostrar información del sistema
Write-Host "[3/3] Verificando GPU..." -ForegroundColor Yellow
try {
    $gpuInfo = nvidia-smi --query-gpu=name,memory.free --format=csv,noheader 2>$null
    if ($gpuInfo) {
        Write-Host "GPU Detectada: $gpuInfo" -ForegroundColor Green
    }
} catch {
    Write-Host "Advertencia: No se pudo verificar GPU" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Configuracion:" -ForegroundColor White
Write-Host "  - GPU: RTX 4060 8GB" -ForegroundColor White
Write-Host "  - Modo: Normal VRAM" -ForegroundColor White
Write-Host "  - Optimizaciones: Activadas" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "ComfyUI estara disponible en:" -ForegroundColor Yellow
Write-Host "http://127.0.0.1:8188" -ForegroundColor Cyan
Write-Host ""
Write-Host "Workflow recomendado:" -ForegroundColor Yellow
Write-Host "SoleipDreams/Workflows/workflow_splash_art_SD15_optimized.json" -ForegroundColor Green
Write-Host ""
Write-Host "Presiona Ctrl+C para detener" -ForegroundColor Red
Write-Host ""

# Iniciar ComfyUI
python main.py --preview-method auto

Read-Host "Presiona Enter para salir"

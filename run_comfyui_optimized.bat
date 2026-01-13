@echo off
REM ============================================
REM ComfyUI Launcher - Optimizado RTX 4060 8GB
REM ============================================

echo.
echo ============================================
echo   ComfyUI - Splash Art LoL Workflow
echo   Optimizado para RTX 4060 8GB
echo ============================================
echo.

REM Activar entorno virtual
echo [1/3] Activando entorno virtual...
call .venv\Scripts\activate.bat

REM Configurar variables de optimización
echo [2/3] Configurando optimizaciones para RTX 4060...
set PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:128

REM Iniciar ComfyUI con configuración óptima
echo [3/3] Iniciando ComfyUI...
echo.
echo ============================================
echo   Configuracion:
echo   - GPU: RTX 4060 8GB
echo   - Modo: Normal VRAM
echo   - Optimizaciones: Activadas
echo ============================================
echo.
echo ComfyUI estara disponible en:
echo http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener
echo.

python main.py --preview-method auto

pause

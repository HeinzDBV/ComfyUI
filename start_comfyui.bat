@echo off
setlocal enabledelayedexpansion
title ComfyUI - Menu de Inicio
cd /d "%~dp0"

:MENU
cls
echo.
echo ========================================================
echo            COMFYUI - MENU DE INICIO
echo        Optimizado para RTX 4060 8GB ^| 32GB RAM
echo ========================================================
echo.
echo  [1] ComfyUI Optimizado (RECOMENDADO)
echo      - Optimizado para RTX 4060 8GB
echo      - Mejor rendimiento con SD 1.5
echo      - Preview automatico
echo.
echo  [2] ComfyUI Estandar
echo      - Configuracion basica por defecto
echo      - Tiempo: Normal
echo.
echo  [3] ComfyUI con Manager
echo      - Incluye ComfyUI Manager para extensiones
echo      - Gestion facil de custom nodes
echo.
echo  [4] ComfyUI LowVRAM Mode
echo      - Para modelos SDXL pesados
echo      - Usa menos VRAM (mas lento)
echo      - Recomendado solo para SDXL
echo.
echo  [5] ComfyUI HighVRAM Mode
echo      - Maxima velocidad (modelos en GPU)
echo      - Usa toda la VRAM disponible
echo      - Solo para SD 1.5 o modelos ligeros
echo.
echo  [6] ComfyUI CPU Mode
echo      - Sin GPU (muy lento)
echo      - Para testing sin CUDA
echo.
echo  [7] ComfyUI Verbose (Debug)
echo      - Modo debug con logs detallados
echo      - Para diagnosticar problemas
echo.
echo  [0] Salir
echo.
echo ========================================================
echo.

set /p opcion="Selecciona una opcion (0-7): "

if "%opcion%"=="1" goto OPTIMIZADO
if "%opcion%"=="2" goto ESTANDAR
if "%opcion%"=="3" goto MANAGER
if "%opcion%"=="4" goto LOWVRAM
if "%opcion%"=="5" goto HIGHVRAM
if "%opcion%"=="6" goto CPU
if "%opcion%"=="7" goto VERBOSE
if "%opcion%"=="0" goto SALIR

echo.
echo Opcion invalida. Presiona cualquier tecla para volver al menu...
pause >nul
goto MENU

:ESTANDAR
cls
echo ========================================================
echo  Iniciando ComfyUI ESTANDAR
echo ========================================================
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py
goto FIN

:MANAGER
cls
echo ========================================================
echo  Iniciando ComfyUI con MANAGER
echo ========================================================
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo Manager UI: Click en "Manager" en el menu
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --enable-manager
goto FIN

:OPTIMIZADO
cls
echo ========================================================
echo  Iniciando ComfyUI OPTIMIZADO para RTX 4060 8GB
echo ========================================================
echo.
echo Configurando optimizaciones...
call .venv\Scripts\activate.bat
set PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:128
echo.
echo Configuracion aplicada:
echo  - GPU: RTX 4060 8GB
echo  - Modo: Normal VRAM
echo  - Optimizaciones CUDA: Activadas
echo  - Preview: Automatico
echo  - Manager: Habilitado
echo.
echo Servidor disponible en: http://127.0.0.1:8188
echo Manager UI: Click en "Manager" en el menu
echo.
echo Workflow optimizado para fondos de escritorio:
echo SoleipDreams/Workflows/workflow_splash_art_SD15_optimized.json
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --preview-method auto --enable-manager
goto FIN

:LOWVRAM
cls
echo ========================================================
echo  Iniciando ComfyUI en modo LOW VRAM
echo ========================================================
echo.
echo ATENCION: Este modo es MAS LENTO pero permite SDXL
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo.
echo Configuracion:
echo  - Modelos se cargan/descargan dinamicamente
echo  - Ideal para SDXL en 8GB VRAM
echo  - Tiempo generacion: 2-4 minutos
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --lowvram
goto FIN

:HIGHVRAM
cls
echo ========================================================
echo  Iniciando ComfyUI en modo HIGH VRAM
echo ========================================================
echo.
echo ADVERTENCIA: Mantiene modelos en GPU (usa mas VRAM)
echo Solo recomendado para SD 1.5 en RTX 4060 8GB
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --highvram
goto FIN

:CPU
cls
echo ========================================================
echo  Iniciando ComfyUI en modo CPU (sin GPU)
echo ========================================================
echo.
echo ADVERTENCIA: Este modo es MUY LENTO
echo Solo usar para testing o debugging
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --cpu
goto FIN

:VERBOSE
cls
echo ========================================================
echo  Iniciando ComfyUI en modo DEBUG (Verbose)
echo ========================================================
echo.
call .venv\Scripts\activate.bat
echo Servidor disponible en: http://127.0.0.1:8188
echo.
echo Modo debug: Logs detallados en consola
echo.
echo Presiona Ctrl+C para detener
echo.
python main.py --verbose
goto FIN

:SALIR
cls
echo.
echo Saliendo...
echo.
exit

:FIN
echo.
echo ========================================================
echo  ComfyUI se ha detenido
echo ========================================================
echo.
pause
goto MENU

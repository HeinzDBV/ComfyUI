@echo off
title ComfyUI with Manager - Starting...
cd /d "%~dp0"

echo ================================
echo   ComfyUI con Manager
echo ================================
echo.

REM Activar entorno virtual
call .venv\Scripts\activate.bat

REM Iniciar ComfyUI con Manager
echo Iniciando servidor ComfyUI con Manager...
echo Abre tu navegador en: http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

python main.py --enable-manager

pause

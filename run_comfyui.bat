@echo off
title ComfyUI - Starting...
cd /d "%~dp0"

echo ================================
echo   Iniciando ComfyUI
echo ================================
echo.

REM Activar entorno virtual
call .venv\Scripts\activate.bat

REM Iniciar ComfyUI
echo Iniciando servidor ComfyUI...
echo Abre tu navegador en: http://127.0.0.1:8188
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

python main.py

pause

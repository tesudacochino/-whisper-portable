@echo off
chcp 65001 >nul
title Whisper Portable - Lotes Texto Limpio (sin timecodes)
echo.
echo  +----------------------------------------------------------+
echo  ^|   WHISPER PORTABLE - Lotes Texto Limpio (sin timecodes) ^|
echo  ^|   Procesa todos los audios de la carpeta "input"        ^|
echo  +----------------------------------------------------------+
echo.

set "SCRIPT_DIR=%~dp0"
call "%SCRIPT_DIR%config.bat"
set "WHISPER_EXE=%SCRIPT_DIR%Faster-Whisper-XXL\faster-whisper-xxl.exe"
set "INPUT_DIR=%SCRIPT_DIR%input"
set "OUTPUT_DIR=%SCRIPT_DIR%output"

:: Construir argumento de idioma
set "LANG_ARG="
if /i not "%WHISPER_LANGUAGE%"=="auto" set "LANG_ARG=--language %WHISPER_LANGUAGE%"

:: Verificar que existe el ejecutable
if not exist "%WHISPER_EXE%" (
    echo  [ERROR] No se encuentra faster-whisper-xxl.exe
    pause
    exit /b 1
)

:: Crear carpetas si no existen
if not exist "%INPUT_DIR%" mkdir "%INPUT_DIR%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Contar archivos de audio en input
set COUNT=0
for %%f in ("%INPUT_DIR%\*.mp3" "%INPUT_DIR%\*.wav" "%INPUT_DIR%\*.m4a" "%INPUT_DIR%\*.ogg" "%INPUT_DIR%\*.flac" "%INPUT_DIR%\*.wma" "%INPUT_DIR%\*.aac" "%INPUT_DIR%\*.mp4" "%INPUT_DIR%\*.mkv" "%INPUT_DIR%\*.avi" "%INPUT_DIR%\*.webm") do set /a COUNT+=1

if %COUNT%==0 (
    echo  [AVISO] No hay archivos de audio en la carpeta "input"
    echo  Copia tus archivos de audio a: %INPUT_DIR%
    echo.
    echo  Formatos soportados: mp3, wav, m4a, ogg, flac, wma, aac, mp4, mkv, avi, webm
    echo.
    pause
    exit /b 0
)

echo  Encontrados %COUNT% archivos de audio en "input"
echo  Modelo:  %WHISPER_MODEL%
echo  Idioma:  %WHISPER_LANGUAGE%
echo  Salida:  carpeta "output" (texto limpio, sin timecodes)
echo.
echo  ============================================================

set CURRENT=0
for %%f in ("%INPUT_DIR%\*.mp3" "%INPUT_DIR%\*.wav" "%INPUT_DIR%\*.m4a" "%INPUT_DIR%\*.ogg" "%INPUT_DIR%\*.flac" "%INPUT_DIR%\*.wma" "%INPUT_DIR%\*.aac" "%INPUT_DIR%\*.mp4" "%INPUT_DIR%\*.mkv" "%INPUT_DIR%\*.avi" "%INPUT_DIR%\*.webm") do (
    set /a CURRENT+=1
    echo.
    echo  [!CURRENT!/%COUNT%] Procesando: %%~nxf
    echo  --------------------------------------------------------
    "%WHISPER_EXE%" "%%f" --model %WHISPER_MODEL% --output_format txt --output_dir "%OUTPUT_DIR%" --device %WHISPER_DEVICE% --compute_type %WHISPER_COMPUTE% %LANG_ARG%

    :: Limpiar timecodes del archivo generado
    if exist "%OUTPUT_DIR%\%%~nf.txt" (
        echo  Limpiando timecodes de %%~nf.txt...
        powershell -NoProfile -Command "$c = Get-Content '%OUTPUT_DIR%\%%~nf.txt' -Encoding UTF8; ($c | ForEach-Object { $_ -replace '^\[[\d:.]+\s*-->\s*[\d:.]+\]\s*', '' } | Where-Object { $_.Trim() -ne '' }) -join [Environment]::NewLine | Set-Content '%OUTPUT_DIR%\%%~nf.txt' -Encoding UTF8"
    )
)

echo.
echo  ============================================================
echo  [OK] Procesamiento por lotes completado (texto limpio)!
echo  Resultados en: %OUTPUT_DIR%
echo.
echo  Archivos generados:
dir /b "%OUTPUT_DIR%\*.txt" 2>nul
echo.
pause

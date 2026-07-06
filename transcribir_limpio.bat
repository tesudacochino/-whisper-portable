@echo off
chcp 65001 >nul
title Whisper Portable - Transcripción Limpia (sin timecodes)
echo.
echo  +----------------------------------------------------------+
echo  ^|     WHISPER PORTABLE - Texto Limpio (sin timecodes)     ^|
echo  ^|     Faster-Whisper-XXL r245.4                           ^|
echo  +----------------------------------------------------------+
echo.

set "SCRIPT_DIR=%~dp0"
call "%SCRIPT_DIR%config.bat"
set "WHISPER_EXE=%SCRIPT_DIR%Faster-Whisper-XXL\faster-whisper-xxl.exe"
set "OUTPUT_DIR=%SCRIPT_DIR%output"

:: Construir argumento de idioma
set "LANG_ARG="
if /i not "%WHISPER_LANGUAGE%"=="auto" set "LANG_ARG=--language %WHISPER_LANGUAGE%"

:: Verificar que existe el ejecutable
if not exist "%WHISPER_EXE%" (
    echo  [ERROR] No se encuentra faster-whisper-xxl.exe
    echo  Asegúrate de haber extraído Faster-Whisper-XXL en la carpeta correcta.
    pause
    exit /b 1
)

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Si se arrastró un archivo
if "%~1"=="" (
    echo  USO: Arrastra un archivo de audio sobre este .bat
    echo       o ejecuta: transcribir_limpio.bat "ruta\al\audio.mp3"
    echo.
    echo  Genera texto plano SIN marcas de tiempo.
    echo  Formatos soportados: mp3, wav, m4a, ogg, flac, wma, aac, mp4, mkv, avi
    echo.
    pause
    exit /b 0
)

set "INPUT_FILE=%~1"
set "BASENAME=%~n1"

echo  Archivo: %~nx1
echo  Modelo:  %WHISPER_MODEL%
echo  Idioma:  %WHISPER_LANGUAGE%
echo  Salida:  %OUTPUT_DIR%\%BASENAME%.txt (sin timecodes)
echo.
echo  Procesando... (esto puede tardar unos minutos)
echo  ============================================================
echo.

"%WHISPER_EXE%" "%INPUT_FILE%" --model %WHISPER_MODEL% --output_format txt --output_dir "%OUTPUT_DIR%" --device %WHISPER_DEVICE% --compute_type %WHISPER_COMPUTE% %LANG_ARG%

echo.

:: Limpiar timecodes del archivo generado
if exist "%OUTPUT_DIR%\%BASENAME%.txt" (
    echo  Limpiando timecodes...
    powershell -NoProfile -Command "$content = Get-Content '%OUTPUT_DIR%\%BASENAME%.txt' -Encoding UTF8; $clean = $content | ForEach-Object { $_ -replace '^\[[\d:.]+\s*-->\s*[\d:.]+\]\s*', '' } | Where-Object { $_.Trim() -ne '' }; $clean -join [Environment]::NewLine | Set-Content '%OUTPUT_DIR%\%BASENAME%.txt' -Encoding UTF8"
    echo.
    echo  ============================================================
    echo  [OK] Transcripción limpia completada!
    echo  Archivo: %OUTPUT_DIR%\%BASENAME%.txt
    echo.
    echo  --- Primeras líneas ---
    type "%OUTPUT_DIR%\%BASENAME%.txt" | more /e /p
) else (
    echo  [AVISO] Revisa si se generó algún archivo en: %OUTPUT_DIR%
)

echo.
pause

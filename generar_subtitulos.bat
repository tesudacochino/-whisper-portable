@echo off
chcp 65001 >nul
title Whisper Portable - Transcripción con Subtítulos (SRT)
echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║      WHISPER PORTABLE - Generar Subtítulos (SRT)        ║
echo  ║      Arrastra un archivo de audio/video sobre este bat  ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.

set "SCRIPT_DIR=%~dp0"
call "%SCRIPT_DIR%config.bat"
set "WHISPER_EXE=%SCRIPT_DIR%Faster-Whisper-XXL\faster-whisper-xxl.exe"
set "OUTPUT_DIR=%SCRIPT_DIR%output"

:: Construir argumento de idioma
set "LANG_ARG="
if /i not "%WHISPER_LANGUAGE%"=="auto" set "LANG_ARG=--language %WHISPER_LANGUAGE%"

if not exist "%WHISPER_EXE%" (
    echo  [ERROR] No se encuentra faster-whisper-xxl.exe
    pause
    exit /b 1
)

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

if "%~1"=="" (
    echo  USO: Arrastra un archivo de audio/video sobre este .bat
    echo.
    echo  Genera archivos .srt con marcas de tiempo para subtítulos.
    echo.
    pause
    exit /b 0
)

set "INPUT_FILE=%~1"
set "BASENAME=%~n1"

echo  Archivo: %~nx1
echo  Modelo:  %WHISPER_MODEL%
echo  Formato: SRT (subtítulos)
echo  Idioma:  %WHISPER_LANGUAGE%
echo.
echo  Procesando...
echo  ════════════════════════════════════════════════════════════
echo.

"%WHISPER_EXE%" "%INPUT_FILE%" --model %WHISPER_MODEL% --output_format srt --output_dir "%OUTPUT_DIR%" --device %WHISPER_DEVICE% --compute_type %WHISPER_COMPUTE% %LANG_ARG%

echo.
echo  ════════════════════════════════════════════════════════════

if exist "%OUTPUT_DIR%\%BASENAME%.srt" (
    echo  [OK] Subtítulos generados!
    echo  Archivo: %OUTPUT_DIR%\%BASENAME%.srt
) else (
    echo  [AVISO] Revisa los archivos en: %OUTPUT_DIR%
)

echo.
pause

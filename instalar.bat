@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Whisper Portable - Instalación Automática
echo.
echo  +----------------------------------------------------------+
echo  ^|       WHISPER PORTABLE - Instalacion Automatica         ^|
echo  ^|       Descarga e instala todo lo necesario              ^|
echo  +----------------------------------------------------------+
echo.

set "SCRIPT_DIR=%~dp0"
set "WHISPER_DIR=%SCRIPT_DIR%Faster-Whisper-XXL"
set "WHISPER_EXE=%WHISPER_DIR%\faster-whisper-xxl.exe"
set "ARCHIVE=%SCRIPT_DIR%Faster-Whisper-XXL_r245.4_windows.7z"
set "DOWNLOAD_URL=https://github.com/Purfview/whisper-standalone-win/releases/download/Faster-Whisper-XXL/Faster-Whisper-XXL_r245.4_windows.7z"

:: ==============================================================
:: PASO 0: Verificar si ya está instalado
:: ==============================================================
if exist "%WHISPER_EXE%" (
    echo  [OK] Faster-Whisper-XXL ya está instalado.
    echo  Ejecutable: %WHISPER_EXE%
    echo.
    echo  Si quieres reinstalar, borra la carpeta Faster-Whisper-XXL
    echo  y ejecuta este script de nuevo.
    echo.
    pause
    exit /b 0
)

:: ==============================================================
:: PASO 1: Verificar 7-Zip
:: ==============================================================
echo  [1/3] Verificando 7-Zip...

set "SEVENZIP="
where 7z >nul 2>&1 && set "SEVENZIP=7z"
if not defined SEVENZIP (
    if exist "C:\Program Files\7-Zip\7z.exe" set "SEVENZIP=C:\Program Files\7-Zip\7z.exe"
)
if not defined SEVENZIP (
    if exist "C:\Program Files (x86)\7-Zip\7z.exe" set "SEVENZIP=C:\Program Files (x86)\7-Zip\7z.exe"
)

if not defined SEVENZIP (
    echo  [ERROR] No se encontró 7-Zip.
    echo  Instala 7-Zip desde https://www.7-zip.org/ y ejecuta este script de nuevo.
    echo.
    pause
    exit /b 1
)
echo  7-Zip encontrado: %SEVENZIP%
echo.

:: ==============================================================
:: PASO 2: Descargar Faster-Whisper-XXL (~1.4 GB)
:: ==============================================================
if exist "%ARCHIVE%" (
    echo  [2/3] El archivo .7z ya existe, saltando descarga...
) else (
    echo  [2/3] Descargando Faster-Whisper-XXL r245.4 (~1.4 GB)...
    echo  URL: %DOWNLOAD_URL%
    echo.
    echo  Esto puede tardar varios minutos dependiendo de tu conexión.
    echo  Por favor, espera...
    echo.
    powershell -NoProfile -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%ARCHIVE%' -UseBasicParsing; Write-Host '  Descarga completada.' } catch { Write-Host '  [ERROR] Fallo en la descarga: ' $_.Exception.Message; exit 1 }"
    if errorlevel 1 (
        echo.
        echo  [ERROR] No se pudo descargar. Verifica tu conexión a internet.
        echo  También puedes descargarlo manualmente desde:
        echo  %DOWNLOAD_URL%
        echo  y colocarlo en esta carpeta.
        echo.
        pause
        exit /b 1
    )
)
echo.

:: ==============================================================
:: PASO 3: Extraer
:: ==============================================================
echo  [3/3] Extrayendo (~4.5 GB)... esto puede tardar 1-2 minutos.
echo.
"%SEVENZIP%" x "%ARCHIVE%" -o"%SCRIPT_DIR%" -y
echo.

if not exist "%WHISPER_EXE%" (
    echo  [ERROR] La extracción falló. El ejecutable no se encuentra.
    echo  Intenta extraer manualmente el archivo .7z con 7-Zip.
    echo.
    pause
    exit /b 1
)

:: ==============================================================
:: LIMPIEZA: Borrar el .7z para ahorrar espacio
:: ==============================================================
echo  Eliminando archivo .7z para ahorrar espacio...
del "%ARCHIVE%" 2>nul
echo.

:: ==============================================================
:: LISTO
:: ==============================================================
echo  ============================================================
echo.
echo  [OK] Instalación completada!
echo.
echo  El modelo large-v3 (~3 GB) se descargará automáticamente
echo  la primera vez que transcribas un archivo.
echo.
echo  Para empezar:
echo    - Arrastra un audio/vídeo sobre "transcribir.bat"
echo    - O ejecuta: transcribir.bat "ruta\al\audio.mp3"
echo.
echo  Consulta MANUAL.md para más opciones.
echo.
echo  ============================================================
echo.
pause

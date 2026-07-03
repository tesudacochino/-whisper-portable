@echo off
:: ══════════════════════════════════════════════════════════════
::  CONFIGURACIÓN DE WHISPER PORTABLE
::  Edita este archivo para cambiar los ajustes de todos los scripts.
:: ══════════════════════════════════════════════════════════════

:: MODELO: tiny, base, small, medium, large-v3, distil-large-v3.5
set "WHISPER_MODEL=large-v3"

:: IDIOMA: auto (detección automática), es (español), en (inglés), etc.
set "WHISPER_LANGUAGE=auto"

:: DISPOSITIVO: auto (GPU si disponible, si no CPU), cuda, cpu
set "WHISPER_DEVICE=auto"

:: TIPO DE CÓMPUTO: auto, float16, int8, int8_float16
set "WHISPER_COMPUTE=auto"

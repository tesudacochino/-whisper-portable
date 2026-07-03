# 🎙️ Whisper Portable — Audio a Texto

Herramienta portable para transcribir audio/vídeo a texto en Windows usando [Faster-Whisper-XXL](https://github.com/Purfview/whisper-standalone-win) (r245.4).  
**No requiere Python ni instalación.** Solo descargar, extraer y usar.

## 📁 Estructura

```
whisper-portable/
├── Faster-Whisper-XXL/              ← Motor (se descarga con instalar.bat)
│   ├── faster-whisper-xxl.exe
│   ├── _models/                     ← Modelo (se descarga en primer uso)
│   └── ...
├── input/                           ← Pon aquí audios para lotes
├── output/                          ← Aquí se guardan los resultados
├── instalar.bat                     ← 🔧 Instalación automática (ejecutar primero)
├── config.bat                       ← ⚙️ Configuración (modelo, idioma, GPU)
├── transcribir.bat                  ← 🟢 Drag & Drop (con timecodes)
├── transcribir_limpio.bat           ← 📝 Drag & Drop (texto plano)
├── transcribir_lotes.bat            ← 📦 Lotes (con timecodes)
├── transcribir_lotes_limpio.bat     ← 📦 Lotes (texto plano)
├── generar_subtitulos.bat           ← 🎬 Genera .srt con timestamps
├── MANUAL.md                        ← 📖 Manual de usuario completo
├── BENCHMARK.md                     ← 📊 Comparativa de modelos
└── README.md
```

## 🚀 Instalación

### 1. Clonar este repositorio

```bash
git clone git@github.com:tesudacochino/-whisper-portable.git
cd -- -whisper-portable
```

### 2. Ejecutar el instalador

Haz **doble clic** en `instalar.bat` (o ejecútalo desde la terminal):

```cmd
instalar.bat
```

El script automáticamente:
- ✅ Verifica que tienes [7-Zip](https://www.7-zip.org/) instalado
- ✅ Descarga Faster-Whisper-XXL (~1.4 GB) desde GitHub
- ✅ Extrae el motor (~4.5 GB)
- ✅ Limpia el archivo descargado

> **Requisitos:** Windows 10+, [7-Zip](https://www.7-zip.org/), conexión a internet.  
> **Primer uso:** El modelo large-v3 (~3 GB) se descarga automáticamente la primera vez.

### 3. ¡Listo!

Arrastra un archivo de audio/vídeo sobre `transcribir.bat` y espera el resultado en `output/`.

## 📋 Uso rápido

### Un solo archivo (Drag & Drop)

| Script | Resultado |
|--------|-----------|
| `transcribir.bat` | Texto **con** timecodes |
| `transcribir_limpio.bat` | Texto **sin** timecodes (plano) |
| `generar_subtitulos.bat` | Subtítulos `.srt` |

**Arrastra** un archivo de audio/vídeo encima del `.bat` que quieras.

### Procesamiento por lotes

1. Copia tus archivos a `input/`
2. Ejecuta `transcribir_lotes.bat` (con timecodes) o `transcribir_lotes_limpio.bat` (texto plano)
3. Resultados en `output/`

### Línea de comandos

```cmd
transcribir.bat "D:\Videos\mi_video.mp4"
transcribir_limpio.bat "D:\Videos\reunion.mp3"
generar_subtitulos.bat "D:\Videos\presentacion.mp4"
```

## ⚙️ Configuración

Edita **`config.bat`** para cambiar la configuración de todos los scripts a la vez:

```bat
set "WHISPER_MODEL=large-v3"     :: tiny, base, small, medium, large-v3
set "WHISPER_LANGUAGE=auto"      :: auto, es, en, fr, de...
set "WHISPER_DEVICE=auto"        :: auto, cuda, cpu
set "WHISPER_COMPUTE=auto"       :: auto, float16, int8
```

## 📊 Benchmark

Resultados del test comparativo con un vídeo de 6 min en español:

| Modelo | Tiempo | Velocidad | Calidad |
|--------|:------:|:---------:|:-------:|
| `tiny` | 00:20 | 31.8x | ❌ Errores graves |
| `base` | 00:20 | 36.3x | ❌ Sin puntuación |
| `small` | 00:40 | 18.3x | ⚠️ Aceptable |
| `medium` | 01:21 | 11.9x | ✅ Muy bueno |
| `large-v3` | 00:52 | 9.0x | ✅ El mejor |

Ver [BENCHMARK.md](BENCHMARK.md) para el informe completo.

**Recomendación:** `large-v3` para calidad, `small` para velocidad.

## 🎯 Formatos soportados

mp3, wav, m4a, ogg, flac, wma, aac, mp4, mkv, avi, webm (y más — usa FFmpeg internamente)

## 💡 Tips

- **GPU NVIDIA**: Se usa automáticamente si tienes CUDA
- **Sin GPU**: Funciona en CPU (más lento)
- **Audio largo**: Para archivos de +1 hora, ten paciencia
- **Portabilidad**: Copia toda la carpeta a un USB → funciona en cualquier Windows 10+
- **Modelo preinstalado**: Para distribución offline, incluye `Faster-Whisper-XXL/_models/faster-whisper-large-v3/`

## 🔗 Enlaces

- [Faster-Whisper-XXL (GitHub)](https://github.com/Purfview/whisper-standalone-win)
- [Whisper de OpenAI](https://github.com/openai/whisper)
- [Modelos disponibles](https://huggingface.co/Systran)

## 📄 Licencia

Este repositorio contiene scripts wrapper. El motor [Faster-Whisper-XXL](https://github.com/Purfview/whisper-standalone-win) tiene su propia licencia.

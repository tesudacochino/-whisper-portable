# 📖 Manual de Usuario — Whisper Portable

## Convertir audio/vídeo a texto en Windows

---

## 📋 Índice

1. [Requisitos](#requisitos)
2. [Transcribir un solo vídeo](#transcribir-un-solo-vídeo)
3. [Transcribir un lote de vídeos](#transcribir-un-lote-de-vídeos)
4. [Generar subtítulos (SRT)](#generar-subtítulos-srt)
5. [Resumen de scripts](#resumen-de-scripts)
6. [Solución de problemas](#solución-de-problemas)

---

## Requisitos

- **Windows 10** o superior
- La carpeta `Faster-Whisper-XXL` ya extraída (contiene el motor de transcripción)
- **Primera vez**: se descargará automáticamente el modelo de IA (~3 GB). Solo ocurre una vez y necesita conexión a internet.

> [!NOTE]
> Si tienes una **GPU NVIDIA**, Whisper la usará automáticamente para ir mucho más rápido.
> Si no tienes GPU, funciona igualmente con CPU (será más lento).

---

## Transcribir un solo vídeo

### Método A: Texto con marcas de tiempo

Genera un `.txt` con cada frase marcada con su instante en el vídeo.

**Pasos:**

1. Localiza el archivo `transcribir.bat` en la carpeta de Whisper
2. **Arrastra** tu archivo de vídeo (o audio) y **suéltalo** encima de `transcribir.bat`
3. Se abrirá una ventana de comandos mostrando el progreso
4. Cuando termine, el archivo `.txt` estará en la carpeta `output/`

**Ejemplo de salida:**
```
[00:00.000 --> 00:09.600]  En este vídeo vamos a enseñaros cómo cargar un set...
[00:10.240 --> 00:13.780]  Bueno, para ello tenemos que tener un proyecto de Cinema.
[00:13.960 --> 00:16.720]  En este caso voy a salvar este como versión 6.
```

---

### Método B: Texto plano (sin marcas de tiempo)

Genera un `.txt` con solo el texto, ideal para copiar/pegar en documentos.

**Pasos:**

1. Localiza el archivo `transcribir_limpio.bat` en la carpeta de Whisper
2. **Arrastra** tu archivo de vídeo (o audio) y **suéltalo** encima de `transcribir_limpio.bat`
3. Se abrirá una ventana de comandos mostrando el progreso
4. Cuando termine, el archivo `.txt` limpio estará en la carpeta `output/`

**Ejemplo de salida:**
```
En este vídeo vamos a enseñaros cómo cargar un set...
Bueno, para ello tenemos que tener un proyecto de Cinema.
En este caso voy a salvar este como versión 6.
```

> [!TIP]
> Usa este método si el texto es para documentación, resúmenes o traducción.

---

## Transcribir un lote de vídeos

Procesa múltiples archivos de una sola vez, de forma desatendida.

**Pasos:**

1. Copia todos tus archivos de vídeo/audio a la carpeta `input/`
2. Haz **doble clic** en `transcribir_lotes.bat`
3. El script procesará todos los archivos uno por uno
4. Los archivos `.txt` resultantes aparecerán en la carpeta `output/`

**Formatos soportados:**
mp3, wav, m4a, ogg, flac, wma, aac, mp4, mkv, avi, webm

> [!IMPORTANT]
> La transcripción por lotes genera archivos **con marcas de tiempo**.
> Si necesitas texto limpio para todo el lote, usa el paso de limpieza manual descrito abajo.

### Limpiar timecodes de un lote (opcional)

Si has procesado un lote y quieres quitar los timecodes de todos los `.txt`:

1. Abre **PowerShell** en la carpeta `output/`
2. Ejecuta:

```powershell
Get-ChildItem *.txt | ForEach-Object {
    $content = Get-Content $_.FullName -Encoding UTF8
    $clean = $content | ForEach-Object { $_ -replace '^\[[\d:.]+\s*-->\s*[\d:.]+\]\s*', '' } | Where-Object { $_.Trim() -ne '' }
    $clean -join "`r`n" | Set-Content $_.FullName -Encoding UTF8
}
```

---

## Generar subtítulos (SRT)

Genera un archivo `.srt` con marcas de tiempo, compatible con reproductores de vídeo.

**Pasos:**

1. **Arrastra** tu archivo de vídeo/audio sobre `generar_subtitulos.bat`
2. El archivo `.srt` aparecerá en la carpeta `output/`
3. Puedes abrir el `.srt` con cualquier editor de texto o cargarlo en un reproductor

> [!TIP]
> Los archivos `.srt` se pueden usar en VLC, YouTube, editores de vídeo, etc.

---

## Resumen de scripts

| Script | Acción | Cómo usar |
|--------|--------|-----------|
| `transcribir.bat` | Texto **con** timecodes | Arrastra un archivo encima |
| `transcribir_limpio.bat` | Texto **sin** timecodes | Arrastra un archivo encima |
| `transcribir_lotes.bat` | Lotes **con** timecodes | Doble clic |
| `transcribir_lotes_limpio.bat` | Lotes **sin** timecodes | Doble clic |
| `generar_subtitulos.bat` | Genera `.srt` | Arrastra un archivo encima |

**Carpetas:**

| Carpeta | Uso |
|---------|-----|
| `input/` | Pon aquí los archivos para procesamiento por lotes |
| `output/` | Aquí aparecen todos los resultados |

---

## Ejemplos con línea de comandos

Si prefieres usar la terminal en lugar de arrastrar archivos, aquí tienes los comandos completos.

> [!NOTE]
> Abre **cmd** o **PowerShell** en la carpeta de Whisper Portable antes de ejecutar estos comandos.

### Transcribir un solo vídeo (con timecodes)

```cmd
transcribir.bat "D:\Videos\Tutorial_Unreal_Datasmith.mp4"
```

El resultado se guardará en `output\Tutorial_Unreal_Datasmith.txt`.

### Transcribir un solo vídeo (texto limpio, sin timecodes)

```cmd
transcribir_limpio.bat "D:\Videos\Grabacion_Reunion_2026-07-03.mp3"
```

El resultado se guardará en `output\Grabacion_Reunion_2026-07-03.txt` sin marcas de tiempo.

### Generar subtítulos SRT

```cmd
generar_subtitulos.bat "D:\Videos\Presentacion_Producto_Final.mp4"
```

El resultado se guardará en `output\Presentacion_Producto_Final.srt`.

### Transcribir un lote de vídeos (con timecodes)

```cmd
:: 1. Copiar los vídeos a la carpeta input
copy "D:\Videos\Clase01_Introduccion.mp4" input\
copy "D:\Videos\Clase02_Materiales.mp4" input\
copy "D:\Videos\Clase03_Iluminacion.mp4" input\

:: 2. Ejecutar la transcripción por lotes
transcribir_lotes.bat
```

Resultado: se generarán en `output\`:
- `Clase01_Introduccion.txt` (con timecodes)
- `Clase02_Materiales.txt` (con timecodes)
- `Clase03_Iluminacion.txt` (con timecodes)

### Transcribir un lote de vídeos (texto limpio, sin timecodes)

```cmd
:: 1. Copiar los vídeos a la carpeta input
copy "D:\Videos\Clase01_Introduccion.mp4" input\
copy "D:\Videos\Clase02_Materiales.mp4" input\
copy "D:\Videos\Clase03_Iluminacion.mp4" input\

:: 2. Ejecutar la transcripción por lotes LIMPIA
transcribir_lotes_limpio.bat
```

Resultado: se generarán en `output\`:
- `Clase01_Introduccion.txt` (solo texto)
- `Clase02_Materiales.txt` (solo texto)
- `Clase03_Iluminacion.txt` (solo texto)

### Lote directo con el ejecutable (avanzado)

Si quieres procesar un lote directamente desde la terminal sin copiar a `input\`:

```cmd
:: Procesar todos los .mp4 de una carpeta externa
for %f in ("D:\Videos\Curso_Unreal\*.mp4") do (
    Faster-Whisper-XXL\faster-whisper-xxl.exe "%f" --model large-v3 --output_format txt --output_dir output --device auto --compute_type auto
)
```

> [!TIP]
> Si usas esto dentro de un `.bat`, cambia `%f` por `%%f`.

### Usar el ejecutable directamente (avanzado)

Si quieres control total sobre las opciones:

```cmd
:: Transcribir en español forzado, modelo medium, solo CPU
Faster-Whisper-XXL\faster-whisper-xxl.exe "D:\Videos\Entrevista_Cliente.mp4" --model medium --language es --output_format txt --output_dir output --device cpu --compute_type auto

:: Transcribir en inglés, generar todos los formatos (txt, srt, vtt, json)
Faster-Whisper-XXL\faster-whisper-xxl.exe "D:\Videos\Webinar_AI_Tools.mp4" --model large-v3 --language en --output_format all --output_dir output --device auto --compute_type auto

:: Transcribir con modelo más ligero para ir rápido
Faster-Whisper-XXL\faster-whisper-xxl.exe "D:\Videos\Nota_de_Voz.m4a" --model small --output_format txt --output_dir output --device auto --compute_type auto
```

---

## Solución de problemas

### "No se encuentra faster-whisper-xxl.exe"
La carpeta `Faster-Whisper-XXL` no está extraída. Extrae el archivo `.7z` con 7-Zip dentro de esta misma carpeta.

### La primera transcripción tarda mucho
Es normal. La primera vez descarga el modelo de IA (~3 GB). Las siguientes veces será mucho más rápido.

### El texto tiene errores
- Prueba con audio más claro o sin ruido de fondo
- El modelo `large-v3` es el más preciso, pero si necesitas más velocidad puedes editar los `.bat` y cambiar `--model large-v3` por `--model medium` o `--model small`

### La ventana se cierra sin resultado
Ejecuta el script desde una terminal (cmd o PowerShell) para ver el error:
```cmd
transcribir.bat "ruta\al\archivo.mp4"
```

### Quiero forzar un idioma concreto
Edita el `.bat` y añade `--language es` (español) o `--language en` (inglés) al final de la línea del comando `faster-whisper-xxl.exe`.

---

> **Velocidad de referencia**: Un vídeo de 6 minutos se transcribe en ~1 min 30 seg con GPU NVIDIA (~8.5x tiempo real).

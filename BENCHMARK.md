# 📊 Informe Benchmark — Comparación de Modelos Whisper

**Archivo de prueba:** `ExportCinemaUnrealInfinity_PluginDatasmith.mp4` (55.4 MB, ~6 min de audio en español)
**Hardware:** GPU NVIDIA (CUDA) + CPU
**Fecha:** 2026-07-03

---

## ⏱️ Resultados de Rendimiento

| Modelo | Tamaño modelo | Tiempo total | Velocidad | Palabras |
|--------|:------------:|:------------:|:---------:|:--------:|
| `tiny` | ~75 MB | **00:20** | 31.8x ⚡⚡⚡⚡⚡ | 938 |
| `base` | ~142 MB | **00:20** | 36.3x ⚡⚡⚡⚡⚡ | 936 |
| `small` | ~466 MB | **00:40** | 18.3x ⚡⚡⚡⚡ | 928 |
| `medium` | ~1.5 GB | **01:21** | 11.9x ⚡⚡⚡ | 924 |
| `large-v3` | ~3.1 GB | **00:52** | 9.0x ⚡⚡ | 932 |

> [!NOTE]
> `large-v3` fue más rápido que `medium` porque su modelo ya estaba cacheado de una ejecución anterior. En condiciones iguales, `medium` es más rápido que `large-v3`.

---

## 🔍 Comparación de Calidad

### Inicio de la transcripción (primeras frases)

| Modelo | Texto transcrito |
|--------|-----------------|
| `tiny` | "**La** este video vamos a enseñaros también cómo cargar... tenemos que tener **cloud** que tenemos que tener..." |
| `base` | "este vídeo vamos a enseñaros... tenemos que tener **cloud** que tenemos que tener..." (sin puntuación, todo junto) |
| `small` | "**En** este vídeo vamos a enseñaros... tenemos que tener **claro** que tenemos que tener..." ✅ |
| `medium` | "**En** este vídeo vamos a enseñaros... tenemos que tener **claro** que tenemos que tener..." ✅ |
| `large-v3` | "**En** este vídeo vamos a enseñaros... tenemos que tener **claro** que tenemos que tener..." ✅ |

### Final de la transcripción (últimas frases)

| Modelo | Texto transcrito |
|--------|-----------------|
| `tiny` | "espero que está a parte del tutorial, también ha **sepido**, saludo, **top**" ❌ |
| `base` | "espero que está aparte del tutorial también **acépido** saludo" ❌ (sin puntuación) |
| `small` | "Espero que esta parte del tutorial también **ha sido**. Un saludo. Chao." ⚠️ |
| `medium` | "Espero que esta parte del tutorial también **ha servido**. Un saludo, chao." ✅ |
| `large-v3` | "Espero que esta parte del tutorial también **haya servido**. Un saludo. Chao." ✅ |

### Términos técnicos

| Término real | tiny | base | small | medium | large-v3 |
|-------------|:----:|:----:|:-----:|:------:|:--------:|
| Cinema 4D | ✅ | ✅ | ✅ | ✅ | ✅ |
| Datasmith | ✅ | ✅ | ✅ | ✅ | ✅ |
| Unreal | ✅ | ✅ | ✅ | ✅ | ✅ |
| UVs | ❌ | ❌ | ✅ | ✅ | ✅ |
| Redshift | ❌ | ⚠️ | ✅ | ✅ | ✅ |
| Infinity Set | ❌ | ⚠️ | ✅ | ✅ | ✅ |
| Puntuación | ❌ | ❌ | ✅ | ✅ | ✅ |
| Mayúsculas correctas | ❌ | ❌ | ✅ | ✅ | ✅ |

---

## 🏆 Análisis por Modelo

### `tiny` — ❌ No recomendado para español
- **Pros:** Ultrarrápido (31.8x), modelo minúsculo (75 MB)
- **Contras:** Errores graves: "cloud" en vez de "claro", "sepido" en vez de "servido", "top" en vez de "chao". Sin puntuación ni mayúsculas. Inutilizable para documentación.

### `base` — ❌ No recomendado para español
- **Pros:** Muy rápido (36.3x), modelo pequeño (142 MB)
- **Contras:** No puntúa. Todo el texto es un bloque continuo sin frases. Mismos errores que tiny ("cloud", "acépido"). Difícil de leer.

### `small` — ⚠️ Aceptable
- **Pros:** Buen equilibrio velocidad/calidad (18.3x). Puntúa correctamente. Capta bien los términos técnicos. Modelo de 466 MB.
- **Contras:** Algunos errores menores: "ha sido" en vez de "ha servido", "star" en vez de "Start".

### `medium` — ✅ Muy bueno
- **Pros:** Alta calidad. Puntuación excelente, frases bien segmentadas. Todos los términos técnicos correctos. "ha servido" correcto.
- **Contras:** El más lento del test (1:21). Modelo de 1.5 GB.

### `large-v3` — ✅ El mejor (recomendado)
- **Pros:** Máxima calidad. "haya servido" (subjuntivo correcto). Mejor segmentación de frases. Todos los términos perfectos.
- **Contras:** Modelo pesado (3.1 GB). Segundo más lento.

---

## 📌 Recomendación

| Caso de uso | Modelo recomendado | Por qué |
|-------------|-------------------|---------|
| **Documentación / publicación** | `large-v3` | Máxima fidelidad, gramática correcta |
| **Uso diario / notas rápidas** | `medium` | 95% de calidad, buena velocidad |
| **Muchos archivos / prisa** | `small` | Calidad aceptable, 2x más rápido que large |
| **Solo necesitas la idea general** | `base` | Rapidísimo, pero sin puntuación |
| **No usar** | `tiny` | Demasiados errores en español |

### Mejor relación calidad/peso: **`small`** (466 MB)
### Mejor calidad absoluta: **`large-v3`** (3.1 GB)
### Mejor relación calidad/velocidad: **`medium`** (1.5 GB)

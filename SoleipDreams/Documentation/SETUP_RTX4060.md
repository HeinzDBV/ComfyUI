# ⚡ CONFIGURACIÓN OPTIMIZADA - RTX 4060 8GB

## 📊 TU SISTEMA
```
GPU: NVIDIA GeForce RTX 4060 Laptop
VRAM: 8GB
RAM: 32GB DDR4/DDR5
Modelo Recomendado: Stable Diffusion 1.5 ✅
```

## 🚀 INICIO RÁPIDO

### 1. Ejecutar ComfyUI Optimizado
Usa uno de estos scripts optimizados para tu GPU:
```bash
# Opción 1 (recomendado):
.\run_comfyui_optimized.ps1

# Opción 2:
.\run_comfyui_optimized.bat
```

### 2. Cargar Workflow Optimizado
En ComfyUI, arrastra:
```
SoleipDreams/Workflows/workflow_splash_art_SD15_optimized.json
```

### 3. Modelos Necesarios

#### ✅ MODELO BASE (elige uno):
1. **DreamShaper 8** ⭐ RECOMENDADO
   - https://civitai.com/models/4384/dreamshaper
   - Guarda en: `models/checkpoints/dreamshaper_8.safetensors`

2. **ReV Animated v1.2.2**
   - https://civitai.com/models/7371/rev-animated
   - Guarda en: `models/checkpoints/revAnimated_v122.safetensors`

#### ✅ CONTROLNET (obligatorio):
- **OpenPose SD 1.5**
  - https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth
  - Guarda en: `models/controlnet/control_v11p_sd15_openpose.pth`

#### ✅ UPSCALER (recomendado):
- **RealESRGAN 4x**
  - https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth
  - Guarda en: `models/upscale_models/RealESRGAN_x4plus.pth`

## ⚙️ CONFIGURACIÓN ÓPTIMA

```json
Resolución: 512 x 768 (vertical) o 768 x 512 (horizontal)
Steps: 25-30
CFG Scale: 7-8
Sampler: DPM++ 2M Karras
Scheduler: karras
ControlNet Strength: 0.75-0.85
```

## ⏱️ TIEMPOS ESPERADOS

| Proceso | Tiempo |
|---------|--------|
| Generación base (512x768) | 20-30s |
| Upscale 4x (→2048x3072) | 12-15s |
| **TOTAL** | **~35-45s** |

## ⚠️ IMPORTANTE: SD 1.5 vs SDXL

### ✅ USA SD 1.5 (Recomendado para tu GPU):
- ⚡ Rápido: 20-40 segundos
- 💾 Usa solo 3-4 GB VRAM
- ✅ Estable con ControlNet + Upscale
- 🎯 Perfecto para tu RTX 4060 8GB

### ❌ NO uses SDXL:
- 🐌 Muy lento: 2-4 minutos
- 💾 Usa 6-8 GB VRAM (al límite)
- ⚠️ Puede fallar con ControlNet
- ❌ No recomendado para 8GB

## 📁 ESTRUCTURA DE ARCHIVOS

```
D:\IA\ComfyUI\
├── run_comfyui_optimized.bat/ps1  ← Scripts de inicio optimizados
├── models/
│   ├── checkpoints/               ← Pon aquí DreamShaper 8
│   ├── controlnet/                ← Pon aquí OpenPose SD15
│   └── upscale_models/            ← Pon aquí RealESRGAN 4x
└── SoleipDreams/
    ├── Workflows/
    │   ├── workflow_splash_art_SD15_optimized.json  ← USAR ESTE
    │   └── README_WORKFLOWS.md    ← Info de workflows
    └── Documentation/
        └── INSTRUCCIONES_SPLASH_ART.md  ← Guía completa
```

## 🎨 EJEMPLO DE PROMPT

**Positivo:**
```
(masterpiece, best quality:1.3), league of legends splash art, 
epic fantasy warrior, dynamic heroic pose with sword raised, 
detailed ornate armor with gold trim, flowing cape, 
magical glowing effects, vibrant blue purple energy, 
dramatic cinematic lighting, stormy sky background, 
professional digital painting, highly detailed, 8k
```

**Negativo:**
```
(worst quality, low quality:1.4), bad anatomy, bad hands, 
poorly drawn, blurry, text, watermark, signature, 
deformed, mutation, extra limbs, malformed
```

## 🔧 SOLUCIÓN RÁPIDA DE PROBLEMAS

### "Out of Memory"
→ Asegúrate de usar workflow SD 1.5, NO SDXL

### "Muy lento (>2 min)"
→ Verifica que estés usando SD 1.5 y DPM++ 2M Karras

### "Pose no se mantiene"
→ Aumenta ControlNet strength a 0.85-0.90

### "Calidad baja"
→ Usa el upscaler 4x incluido en el workflow

## 📚 DOCUMENTACIÓN COMPLETA

Para tutoriales detallados, ejemplos y troubleshooting completo:
```
SoleipDreams/Documentation/INSTRUCCIONES_SPLASH_ART.md
```

## ✨ TIPS PROFESIONALES

1. 📸 Usa fotos con **poses dinámicas** (brazos extendidos)
2. 💡 Fotos con **buena iluminación** funcionan mejor
3. 🎨 **Experimenta** con diferentes prompts
4. 🔄 Genera **múltiples variaciones** (seed: randomize)
5. ⬆️ Siempre usa el **upscaler** para calidad wallpaper

---

**Workflow creado y optimizado específicamente para tu RTX 4060 8GB**

Para más ayuda, consulta: `SoleipDreams/Documentation/INSTRUCCIONES_SPLASH_ART.md`

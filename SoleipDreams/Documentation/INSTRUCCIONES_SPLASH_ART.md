# 🎨 Workflow: Foto a Splash Art de League of Legends

## � ESPECIFICACIONES DE HARDWARE - OPTIMIZADO PARA:
```
🖥️ GPU: NVIDIA GeForce RTX 4060 Laptop (8GB VRAM)
🧠 RAM: 32GB DDR4/DDR5
⚡ Modelo Recomendado: Stable Diffusion 1.5
📏 Resolución Óptima: 512x768 (vertical) o 768x512 (horizontal)
⏱️ Tiempo de Generación: 20-40 segundos por imagen
```

### ⚠️ ¿Por qué SD 1.5 en vez de SDXL?
Con 8GB VRAM:
- ✅ **SD 1.5**: Rápido (20-40s), usa 3-4GB VRAM, sin problemas con ControlNet
- ❌ **SDXL**: Lento (2-4min), usa 6-8GB VRAM, puede fallar con ControlNet activo

---

## �📋 Descripción
Este workflow transforma una foto normal en un **splash art épico estilo League of Legends** con poses dinámicas y composición profesional.

## 🎯 Resultado Final
Convierte fotos comunes en ilustraciones de estilo splash art con:
- ✨ Efectos mágicos y brillos
- 🦸 Poses heroicas y dinámicas
- 🎨 Estilo de pintura digital profesional
- 🌟 Composición cinematográfica
- ⚔️ Elementos de fantasía épica

## 📦 Requisitos Previos

### 1. Modelos Necesarios
Descarga e instala estos modelos en las carpetas correspondientes:

#### a) **Checkpoint Model SD 1.5** (carpeta `models/checkpoints/`)
**OPTIMIZADO PARA TU RTX 4060 8GB:**

1. **DreamShaper 8** ⭐ (RECOMENDADO)
   - Perfecto para splash art de fantasía
   - Colores vibrantes estilo LoL
   - Descargar: https://civitai.com/models/4384/dreamshaper

2. **ReV Animated v1.2.2**
   - Excelente para personajes épicos
   - Gran detalle en armaduras y efectos
   - Descargar: https://civitai.com/models/7371/rev-animated

3. **Deliberate v2**
   - Balance realismo/artístico
   - Bueno para splash art
   - Descargar: https://civitai.com/models/4823/deliberate

4. **AbyssOrangeMix3** (alternativa anime)
   - Si prefieres estilo más anime
   - Descargar: https://huggingface.co/WarriorMama777/OrangeMixs

#### b) **ControlNet SD 1.5** (carpeta `models/controlnet/`)
- **REQUERIDO**: `control_v11p_sd15_openpose.pth`
- **OPCIONAL**: `control_v11p_sd15_canny.pth` (para mayor control de bordes)
  
**Descargar desde:**
- Hugging Face: https://huggingface.co/lllyasviel/ControlNet-v1-1/tree/main
- Direct link OpenPose: https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth

#### c) **Upscaler** (carpeta `models/upscale_models/`)
- `RealESRGAN_x4plus.pth` o `RealESRGAN_x4plus_anime_6B.pth`
- Descarga desde: https://github.com/xinntao/Real-ESRGAN/releases

### 2. Custom Nodes Necesarios
Si usas preprocesadores avanzados, instala:
```
ComfyUI-Manager (recomendado para instalar todo fácilmente)
comfyui_controlnet_aux (para preprocesadores de OpenPose)
```

## 🚀 Cómo Usar el Workflow

### Paso 1: Cargar el Workflow
1. Abre ComfyUI en tu navegador
2. Arrastra el archivo `workflow_splash_art_lol.json` a la ventana de ComfyUI
3. O usa el botón "Load" y selecciona el archivo

### Paso 2: Preparar la Foto
1. **Foto de entrada**: 
   - Usa una foto con buena iluminación
   - La persona debe estar visible de cuerpo completo o al menos medio cuerpo
   - Pose clara y definida
   - Fondo no tan importante (será reemplazado)

2. **Carga la foto** en el nodo "Cargar Foto Original"

### Paso 3: Configurar el Prompt

#### **Prompt Positivo** (personaliza según tu visión):
```
masterpiece, best quality, league of legends splash art style, 
epic fantasy character portrait, [DESCRIBE LA POSE: "warrior wielding sword", "mage casting spell", etc],
dramatic lighting, magical energy effects, vibrant colors, 
detailed armor and clothing, cinematic composition, 
digital painting, professional illustration, high detail, 
fantasy warrior, glowing effects, dramatic sky background, 
epic atmosphere, splash art, dynamic action pose
```

**Ejemplos específicos:**

Para **guerrera mágica**:
```
masterpiece, league of legends splash art, beautiful female warrior mage, 
casting powerful spell, magical energy swirling around hands, 
glowing eyes, flowing hair, ornate armor with gold details, 
dramatic lighting, epic fantasy, cinematic composition, 
vibrant blue and purple magical effects, splash art style
```

Para **héroe épico**:
```
masterpiece, league of legends splash art, heroic male knight, 
wielding glowing sword, standing triumphantly, 
detailed plate armor, cape flowing in wind, 
dramatic lighting from behind, epic pose, 
golden hour lighting, fantasy warrior, cinematic, 
professional digital painting
```

#### **Prompt Negativo** (mantén esto):
```
bad quality, low quality, blurry, jpeg artifacts, ugly, 
duplicate, mutation, deformed, poorly drawn, low resolution, 
watermark, text, signature, cropped, out of frame, 
extra limbs, malformed limbs, bad anatomy
```

### Paso 4: Ajustar Parámetros

#### **Tamaño de Imagen** (nodo "EmptyLatentImage"):
**OPTIMIZADO PARA RTX 4060 8GB + SD 1.5:**
- **Vertical (splash art LoL)**: 512 x 768 ⭐ (RECOMENDADO)
- **Horizontal épico**: 768 x 512
- **Cuadrado**: 512 x 512
- **Alta resolución**: 640 x 960 (más lento pero mejor calidad)

💡 **Tip**: Genera en 512x768 y luego usa el upscaler 4x para obtener 2048x3072 (calidad wallpaper)

#### **ControlNet Strength**:
- **0.6-0.8**: Balance entre mantener pose y creatividad (recomendado)
- **0.8-1.0**: Mantiene más fielmente la pose original
- **0.4-0.6**: Más libertad creativa

#### **KSampler Settings** (Optimizado RTX 4060):
- **Steps**: 25-30 (25 recomendado para velocidad) ⭐
- **CFG Scale**: 7-8 (7.5 recomendado)
- **Sampler**: DPM++ 2M Karras ⭐ (mejor calidad/velocidad)
  - Alternativa rápida: euler_ancestral
  - Alternativa calidad: DPM++ SDE Karras
- **Scheduler**: karras (recomendado)
- **Batch Size**: 1-2 (puedes generar 2 a la vez sin problemas)

⏱️ **Tiempos estimados en tu RTX 4060:**
- 512x768, 25 steps: ~20-30 segundos
- 512x768, 30 steps: ~30-40 segundos
- Upscale 4x adicional: ~15-20 segundos

### Paso 5: Ejecutar
1. Click en **"Queue Prompt"** (arriba a la derecha)
2. Espera la generación (puede tardar 1-3 minutos dependiendo de tu GPU)
3. Revisa los resultados en los nodos "SaveImage"

## 🎨 Consejos para Mejores Resultados

### Para Poses Épicas:
- Usa fotos donde la persona tenga **brazos extendidos** o en posición dinámica
- **Evita** fotos muy estáticas o sentadas
- Fotos con **acción** funcionan mejor (saltando, en movimiento)

### Para Estilo League of Legends:
- Añade en el prompt: "splash art", "league of legends style"
- Incluye elementos de fantasía: "magical effects", "glowing weapons"
- Especifica iluminación dramática: "dramatic lighting", "rim light"

### Para Diferentes Tipos de Personajes:

**Mago/Hechicero:**
```
Add to prompt: "mage robes, spell casting, magical energy, staff, 
glowing runes, mystical atmosphere"
```

**Guerrero:**
```
Add to prompt: "heavy armor, sword and shield, battle ready pose, 
war paint, cape, heroic stance"
```

**Asesino/Rogue:**
```
Add to prompt: "leather armor, dual daggers, stealthy pose, 
shadowy effects, agile stance, mysterious"
```

**Tirador/Arquero:**
```
Add to prompt: "bow and arrow, aiming pose, leather armor, 
focused expression, arrow with glowing tip"
```

## 🔧 Solución de Problemas (RTX 4060 8GB)

### ⚠️ Problema: "Out of Memory / CUDA Out of Memory"
**Solución ESPECÍFICA para tu RTX 4060 8GB:**
1. Asegúrate de usar **SD 1.5** (NO SDXL)
2. Mantén resolución en **512x768 o menor**
3. Cierra otros programas que usen GPU (navegadores, juegos)
4. Si persiste, inicia ComfyUI con: `--lowvram` o `--normalvram`
5. Desactiva temporalmente el upscaler (desconecta ese nodo)

### Problema: "Generación muy lenta (>2 minutos)"
**Solución**:
- ✅ Verifica que estés usando **SD 1.5** (no SDXL)
- ✅ Comprueba sampler: usa **DPM++ 2M Karras** o **Euler A**
- ✅ Reduce steps a **20-25**
- ✅ Cierra otros programas pesados
- ❌ Si usas SDXL por error, cambia a SD 1.5

### Problema: "La pose no se mantiene"
**Solución**: 
- Aumenta el ControlNet strength a **0.8-0.9**
- Verifica que el preprocesador OpenPose esté funcionando (mira el preview)
- Usa una foto con pose más clara y brazos visibles
- El modelo OpenPose debe ser: `control_v11p_sd15_openpose.pth`

### Problema: "Resultado muy diferente a la foto"
**Solución**:
- Esto es esperado - el objetivo es crear arte estilizado, no clonar
- Para mantener más parecido facial, necesitarías IPAdapter (avanzado)
- Aumenta ControlNet strength a 0.85-0.95 para más fidelidad a la pose
- Describe características físicas en el prompt si es importante

### Problema: "Calidad baja o borrosa"
**Solución**:
- Aumenta los steps del KSampler a **30-35** (aún rápido en tu RTX 4060)
- **USA EL UPSCALER** - está incluido y te da 4x mejor calidad
- Verifica que el checkpoint sea bueno (DreamShaper 8 recomendado)
- Añade al prompt: `(ultra detailed, 8k, high quality:1.2)`
- Reduce CFG a 7-7.5 si está muy saturado

### Problema: "Anatomía extraña / manos deformadas"
**Solución**:
- Mejora el **prompt negativo** añadiendo: `bad anatomy, extra limbs, mutated hands, poorly drawn hands, fused fingers`
- Reduce el CFG Scale a **6.5-7**
- Usa modelos entrenados en personajes (ReV Animated es bueno para esto)
- Genera múltiples versiones (seed "randomize") y elige la mejor
- Para manos: incluye en prompt positivo `detailed hands, perfect anatomy`

### Problema: "El preprocesador OpenPose no funciona"
**Solución**:
- Instala **comfyui_controlnet_aux** desde ComfyUI Manager
- O usa el nodo "DWPose Preprocessor" como alternativa
- Verifica que la imagen sea clara y la persona esté bien visible

### Problema: "Colores apagados / sin efectos mágicos"
**Solución**:
- Enfatiza en el prompt: `(vibrant colors, glowing magical effects:1.3)`
- Añade: `volumetric lighting, rim light, dramatic lighting`
- Aumenta CFG a **8-8.5** para más adherencia al prompt
- Usa modelos artísticos como DreamShaper o ReV Animated

## 🎯 Variaciones del Workflow

### Variación 1: Añadir LoRA de Estilo LoL
Si tienes un LoRA específico de League of Legends:
1. Añade nodo "LoraLoader"
2. Conecta entre Checkpoint y KSampler
3. Strength: 0.6-0.8

### Variación 2: Múltiples Generaciones
Para probar diferentes estilos:
1. Duplica el nodo KSampler
2. Cambia la seed a "randomize"
3. Genera múltiples variaciones a la vez

### Variación 3: Inpainting para Ajustes
Si necesitas modificar partes específicas:
1. Usa el resultado como base
2. Aplica inpainting con máscaras
3. Refina detalles específicos

## 📸 Mejores Prácticas

1. **Calidad de foto original**: Mientras mejor la foto, mejor el resultado
2. **Iluminación**: Fotos con buena iluminación funcionan mejor
3. **Resolución**: Usa fotos de al menos 512x512
4. **Experimentación**: Prueba diferentes prompts y parámetros
5. **Iteración**: Usa los resultados como referencia para mejorar

## ⚡ BENCHMARK & RENDIMIENTO (RTX 4060 8GB)

### Tiempos Reales Esperados:

**Configuración Rápida** (Steps: 20, 512x768):
- Generación base: ~18-25 segundos
- Upscale 4x: ~12-15 segundos
- **Total: ~30-40 segundos** ⚡

**Configuración Calidad** (Steps: 30, 512x768):
- Generación base: ~30-40 segundos
- Upscale 4x: ~12-15 segundos
- **Total: ~45-55 segundos** ⭐

**Configuración Alta Resolución** (Steps: 25, 640x960):
- Generación base: ~40-50 segundos
- Upscale 4x: ~20-25 segundos
- **Total: ~60-75 segundos** 💎

### Uso de VRAM:
- **SD 1.5 solo**: 2.5-3.5 GB
- **SD 1.5 + ControlNet**: 3.5-4.5 GB
- **Con Upscaler activo**: +1-1.5 GB adicional
- **Total máximo**: ~5.5-6 GB (seguro para 8GB VRAM)

### Comparación SD 1.5 vs SDXL en tu GPU:

| Aspecto | SD 1.5 ⭐ | SDXL ⚠️ |
|---------|----------|---------|
| Tiempo generación | 20-40s | 120-240s (2-4min) |
| VRAM usado | 3-4 GB | 6-8 GB |
| Resolución nativa | 512x512 | 1024x1024 |
| Estabilidad | ✅ Excelente | ⚠️ Al límite |
| ControlNet + Upscale | ✅ Sin problemas | ❌ Puede fallar |
| **Recomendación** | ✅ **USAR ESTO** | ❌ No recomendado |

### Optimizaciones Aplicadas:
✅ Modelo SD 1.5 en vez de SDXL
✅ Resolución 512x768 (óptima para tu VRAM)
✅ Sampler DPM++ 2M Karras (mejor velocidad/calidad)
✅ Steps 25-30 (balance perfecto)
✅ Upscaler por separado (no satura VRAM)

## 🎨 Galería de Ejemplos de Prompts

### Estilo Campeón LoL Clásico:
```
league of legends splash art, epic fantasy character, 
heroic pose, dramatic angle, professional illustration, 
high detail, vibrant colors, magical effects, 
cinematic composition, detailed armor
```

### Estilo Campeón Oscuro/Gótico:
```
league of legends splash art, dark fantasy character, 
menacing pose, shadowy atmosphere, gothic armor, 
purple and black color scheme, glowing red eyes, 
dramatic rim lighting, ominous background
```

### Estilo Campeón Elemental/Mágico:
```
league of legends splash art, elemental mage character, 
controlling [fire/ice/lightning], magical aura, 
glowing effects everywhere, dynamic casting pose, 
energy swirling, vibrant magical colors, epic scale
```

## 📝 Notas Finales

- Este workflow es **versátil** - funciona para hombres, mujeres, cualquier edad
- **Experimenta** con diferentes combinaciones de prompts
- Los mejores resultados vienen de **iteración** - prueba varias veces
- **Comparte** tus resultados y aprende de otros
- Workflow optimizado específicamente para **RTX 4060 8GB + SD 1.5**

## 📥 LINKS DE DESCARGA RÁPIDA

### Modelos Base SD 1.5 (Elige UNO):
1. **DreamShaper 8** ⭐ (Recomendado)
   - https://civitai.com/api/download/models/128713
   - Guarda en: `models/checkpoints/dreamshaper_8.safetensors`

2. **ReV Animated v1.2.2**
   - https://civitai.com/api/download/models/46846
   - Guarda en: `models/checkpoints/revAnimated_v122.safetensors`

3. **Deliberate v2**
   - https://civitai.com/api/download/models/15236
   - Guarda en: `models/checkpoints/deliberate_v2.safetensors`

### ControlNet OpenPose (REQUERIDO):
- **Direct Download**: https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth
- Guarda en: `models/controlnet/control_v11p_sd15_openpose.pth`

### Upscaler (Opcional pero recomendado):
- **RealESRGAN 4x**: https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth
- Guarda en: `models/upscale_models/RealESRGAN_x4plus.pth`

### Custom Nodes (Instalar desde ComfyUI Manager):
1. **comfyui_controlnet_aux** - Para preprocesadores OpenPose
2. **ComfyUI-Manager** - Para gestionar todo fácilmente

**Instalación rápida ComfyUI Manager:**
```bash
cd D:\IA\ComfyUI\custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
```

## 🆘 Soporte

Si tienes problemas:
1. Verifica que todos los modelos estén descargados en las carpetas correctas
2. Revisa la consola de ComfyUI para errores específicos
3. Actualiza ComfyUI a la última versión
4. Instala ComfyUI Manager para facilitar la gestión de dependencias
5. Asegúrate de usar **SD 1.5** (NO SDXL) para tu RTX 4060 8GB

### Información del Sistema:
```
GPU: NVIDIA GeForce RTX 4060 Laptop - 8GB VRAM
RAM: 32GB
Modelo: Stable Diffusion 1.5
Workflow optimizado para: Velocidad + Calidad
```

---

**¡Disfruta creando splash arts épicos!** 🎨✨

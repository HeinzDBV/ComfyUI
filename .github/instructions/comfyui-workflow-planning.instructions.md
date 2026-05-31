---
applyTo: "blueprints/**/*.json"
description: "Workflow planning rules for ComfyUI graphs. Use when designing or reviewing workflow JSON structures and node chains."
---
# Workflow Planning Rules

## Planning Sequence
1. Clarify target output and quality-speed tradeoff.
2. Select checkpoint family (SD1.5 or SDXL) using VRAM budget.
3. Build minimal valid graph first.
4. Add conditioning and control modules second.
5. Add upscale and polish last.

## Minimum Graph Requirements
- Load model stack.
- Text conditioning path.
- Sampler path.
- Decode and output path.

## Performance Defaults
- SD1.5 default size: 512x768.
- SDXL default size: 768x1024.
- Suggest 512x768 then upscale for high quality under 8GB VRAM.

## Review Checklist
- All required node inputs are connected.
- Sampler settings are consistent with model family.
- Latent size is coherent with output resolution.
- Optional modules (ControlNet, IPAdapter, Upscale) are ordered correctly.
- Output node is present and configured.

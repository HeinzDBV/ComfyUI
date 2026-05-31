---
name: model-selection-rtx4060
description: "Select practical model and resolution settings for RTX 4060 8GB. Use when balancing quality, speed, and VRAM constraints."
---
# Skill: Model Selection RTX4060

## Use When
- You need safe defaults for this local hardware.
- You need a quality/speed recommendation before building.

## Decision Rules
1. Fast iteration: SD1.5 at 512x768.
2. Higher quality: SDXL at 768x1024 with caution.
3. If memory pressure appears: step down resolution or use generate-then-upscale.

## Output Expected
- Model family recommendation.
- Resolution and sampler baseline.
- Expected runtime range.
- Recovery option for memory pressure.

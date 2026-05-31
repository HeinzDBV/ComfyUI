---
name: img2img-inpaint-variations
description: "Design img2img and inpaint variation workflows. Use when refining existing images without losing key composition intent."
---
# Skill: Img2Img Inpaint Variations

## Use When
- You need controlled variation from an existing image.
- You need local edits while preserving the rest of the image.
- You need multiple alternatives with consistent style.

## Inputs Expected
- Source image.
- Optional mask for local edits.
- Prompt delta from source intent.
- Variation intensity target.

## Output Expected
1. Recommended branch: img2img or inpaint.
2. Denoise and strength baseline.
3. Masking strategy.
4. Variation batch strategy.

## Tuning Order
1. Lock base model and resolution.
2. Set conservative denoise first.
3. Increase variation step by step.
4. Apply inpaint only where local control is needed.

## Anti-Patterns
- High denoise with strict style lock.
- Global inpaint for tiny local changes.
- Mixing too many variation levers at once.

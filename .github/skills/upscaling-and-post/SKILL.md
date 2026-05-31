---
name: upscaling-and-post
description: "Plan upscale and post-processing stages. Use when finishing images with improved detail while preserving style fidelity."
---
# Skill: Upscaling And Post

## Use When
- Base output quality is good but resolution is too low.
- You need a final polish stage after generation.
- You want quality gains without rerunning heavy full-resolution generation.

## Inputs Expected
- Base generated image.
- Target final resolution.
- Preferred upscaler family.
- Tolerance for extra runtime.

## Output Expected
1. Upscale strategy.
2. Post chain ordering.
3. Safe parameter baseline.
4. Quality validation checks.

## Recommended Strategy
1. Generate at a stable base size.
2. Upscale in a separate stage.
3. Apply post effects conservatively.
4. Validate sharpness versus artifact balance.

## Failure Checks
- Over-sharpen artifacts.
- Hallucinated textures from aggressive settings.
- Mismatch between source style and chosen upscaler.

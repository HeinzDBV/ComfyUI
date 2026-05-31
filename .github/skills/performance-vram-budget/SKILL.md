---
name: performance-vram-budget
description: "Plan workflow performance and VRAM usage. Use when tuning graph settings to fit RTX 4060 memory limits."
---
# Skill: Performance VRAM Budget

## Use When
- Workflows fail or slow down due to VRAM pressure.
- You need predictable run cost before execution.

## Inputs Expected
- Model family.
- Resolution.
- Optional modules (ControlNet, IPAdapter, Upscale).

## Output Expected
1. VRAM risk classification.
2. Tuning actions in priority order.
3. Lower-risk fallback graph.

## Tuning Order
1. Reduce resolution.
2. Reduce parallel heavy modules.
3. Move to generate then upscale strategy.
4. Adjust steps or sampler complexity.

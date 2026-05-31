# Template: Splash Art

## Goal
High impact scene composition with controlled character framing.

## Baseline
- Model family: SDXL or Illustrious variant
- Resolution: 768x1024
- Priority: quality

## Stage Plan
1. Core generation path.
2. Optional pose control integration.
3. Refinement and upscale stage.

## Safe Defaults
- Start without dual ControlNet constraints.
- Add pose guidance after baseline composition is acceptable.

## Fallback
If VRAM pressure occurs, generate at 512x768 and upscale as final stage.

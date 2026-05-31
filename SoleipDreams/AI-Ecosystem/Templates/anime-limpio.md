# Template: Anime Limpio

## Goal
Clean linework and color separation with consistent style.

## Baseline
- Model family: anime-focused SDXL checkpoint
- Resolution: 768x1024
- Priority: style consistency

## Stage Plan
1. Base generation.
2. Variation pass with controlled denoise.
3. Optional line and color polish.

## Safe Defaults
- Keep denoise moderate in variation passes.
- Avoid over-sharpening during polish.

## Fallback
If style drifts, reduce variation strength and simplify prompt modifiers.

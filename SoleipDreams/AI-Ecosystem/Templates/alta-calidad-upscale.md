# Template: Alta Calidad Con Upscale

## Goal
Produce high perceived quality while controlling runtime and VRAM.

## Baseline
- Generation resolution: 512x768 or 768x1024
- Final stage: dedicated upscale workflow
- Priority: quality under memory constraints

## Stage Plan
1. Stable base generation.
2. Candidate selection.
3. Upscale and post-processing.

## Safe Defaults
- Do not combine heavy post filters in one pass.
- Validate artifacts after each upscale change.

## Fallback
If artifacts appear, reduce upscale aggressiveness and retry from selected base output.

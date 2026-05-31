# Template: Boceto Rapido

## Goal
Fast ideation workflow with low latency and stable quality.

## Baseline
- Model family: SD1.5
- Resolution: 512x768
- Priority: speed

## Stage Plan
1. Model loading.
2. Prompt conditioning.
3. Sampling.
4. Decode and save.

## Safe Defaults
- Keep sampler settings conservative for quick iteration.
- Avoid heavy control modules in first pass.

## Fallback
If quality is unstable, reduce complexity and lock seed for comparison.

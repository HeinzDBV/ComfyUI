---
name: controlnet-pose-depth
description: "Guide ControlNet setup for pose and depth conditioning. Use when adding structured guidance to improve composition consistency."
---
# Skill: ControlNet Pose Depth

## Use When
- You need pose control for characters or body composition.
- You need depth guidance for scene structure.
- A baseline generation is too inconsistent in layout.

## Inputs Expected
- Base prompt and style target.
- Control input assets (pose image, depth map, or both).
- Model family and resolution target.

## Output Expected
1. Recommended ControlNet path.
2. Node order and connection map.
3. Strength and range baseline.
4. Fallback path if over-constrained.

## Baseline Guidance
1. Start with one control source first.
2. Add second control source only after baseline quality is stable.
3. Keep strength moderate before aggressive tuning.
4. Align control resolution with generation resolution.

## Failure Checks
- Control image resolution mismatch.
- Excessive control strength causing style collapse.
- Incompatible ControlNet model family.

---
name: workflow-composition
description: "Compose end-to-end ComfyUI workflows from goals. Use when defining node stages, dependencies, and baseline parameterization."
---
# Skill: Workflow Composition

## Use When
- You need a full workflow plan from a creative or technical objective.
- You need a staged node architecture before building details.

## Inputs Expected
- Goal and style target.
- Speed vs quality preference.
- Optional control modules (ControlNet, IPAdapter, inpaint).

## Output Expected
1. Stage map of the workflow.
2. Node groups per stage.
3. Baseline settings.
4. Fallback variants.

## Checklist
- Model family chosen.
- Core generation path complete.
- Optional modules placed after core path.
- Output and save path defined.

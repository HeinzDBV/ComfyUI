---
name: qa-workflow-validation
description: "Validate ComfyUI workflow quality before execution. Use when auditing graph integrity, dependencies, and readiness criteria."
---
# Skill: QA Workflow Validation

## Use When
- A workflow is ready for final review.
- You need a repeatable pre-run quality gate.
- You need to reduce runtime failures in iterative work.

## Inputs Expected
- Workflow structure or node plan.
- Dependency expectations (models, control assets).
- Hardware constraints.

## Output Expected
1. Findings grouped by severity.
2. Required fixes before run.
3. Optional improvements.
4. Execution readiness decision.

## Validation Axes
- Graph completeness and connectivity.
- Type compatibility across node links.
- Dependency availability.
- VRAM and runtime plausibility.
- Fallback path existence.

## Go/No-Go Rule
No critical findings should remain unresolved before execution.

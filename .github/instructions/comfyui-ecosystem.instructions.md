---
applyTo: "**"
description: "Base policy for the local ComfyUI AI ecosystem. Use when planning or editing skills, agents, instructions, and workflow templates."
---
# ComfyUI AI Ecosystem Core Rules

## Scope
- This workspace uses a local private AI ecosystem for Copilot.
- Prefer reusable skills and role agents over one-off ad hoc responses.
- Keep implementation focused on practical ComfyUI workflows.

## Operating Priorities
1. Safety and correctness of workflow logic.
2. VRAM-aware recommendations for RTX 4060 8GB.
3. Reusability through templates and explicit contracts.
4. Minimal disruption to upstream ComfyUI files.

## Source of Truth
- Model inventory and availability come from MODELS_MANIFEST.md.
- Hardware constraints come from .github/copilot-instructions.md and SoleipDreams docs.
- Workflow examples should use blueprints as reference patterns when possible.

## Output Contract
When producing a workflow-oriented answer, return:
1. Goal summary.
2. Node-level plan.
3. Parameters with safe defaults.
4. Failure checks and fallback path.

## Change Guardrails
- Prefer creating new ecosystem assets under .github/skills, .github/agents, and .github/instructions.
- Do not alter update/backup wrapper semantics unless explicitly requested.
- Keep advice executable with this local hardware and installed models.

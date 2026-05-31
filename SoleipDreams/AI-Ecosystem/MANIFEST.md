# AI Ecosystem Manifest

## Scope
Local private Copilot ecosystem for ComfyUI workflow engineering.

## Version
- Ecosystem version: 1.0.0
- Date: 2026-05-31
- Status: active

## Components
| Component | Id | Version | Status | Location |
| --- | --- | --- | --- | --- |
| Instruction | comfyui-ecosystem | 1.0.0 | active | .github/instructions |
| Instruction | comfyui-workflow-planning | 1.0.0 | active | .github/instructions |
| Agent | comfy-architect | 1.0.0 | active | .github/agents |
| Agent | comfy-builder | 1.0.0 | active | .github/agents |
| Agent | comfy-reviewer | 1.0.0 | active | .github/agents |
| Skill | workflow-composition | 1.0.0 | active | .github/skills |
| Skill | prompt-to-graph | 1.0.0 | active | .github/skills |
| Skill | model-selection-rtx4060 | 1.0.0 | active | .github/skills |
| Skill | performance-vram-budget | 1.0.0 | active | .github/skills |
| Skill | troubleshooting-comfy-errors | 1.0.0 | active | .github/skills |
| Skill | controlnet-pose-depth | 1.0.0 | active | .github/skills |
| Skill | img2img-inpaint-variations | 1.0.0 | active | .github/skills |
| Skill | upscaling-and-post | 1.0.0 | active | .github/skills |
| Skill | qa-workflow-validation | 1.0.0 | active | .github/skills |
| Skill | packaging-workflow-presets | 1.0.0 | active | .github/skills |
| Contract | AGENT_HANDOFF_CONTRACTS | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Contracts |
| Policy | GOVERNANCE | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Policy | VERSIONING | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Policy | VALIDATION_CHECKLIST | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Policy | RELEASE_CHECKLIST | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Metrics | METRICS | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Doc | README | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Doc | OPERATIONS_RUNBOOK | 1.0.0 | active | SoleipDreams/AI-Ecosystem |
| Script | validate_ai_ecosystem | 1.0.0 | active | SoleipDreams/Scripts |
| Template | boceto-rapido | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Templates |
| Template | splash-art | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Templates |
| Template | anime-limpio | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Templates |
| Template | logo-diseno | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Templates |
| Template | alta-calidad-upscale | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Templates |
| Scenario | scenario-01-fast-ideation | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Scenarios |
| Scenario | scenario-02-pose-controlled-character | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Scenarios |
| Scenario | scenario-03-local-edit-inpaint | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Scenarios |
| Scenario | scenario-04-upscale-finish | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Scenarios |
| Scenario | scenario-05-missing-dependency | 1.0.0 | active | SoleipDreams/AI-Ecosystem/Scenarios |

## Governance Rules
1. Keep all ecosystem assets additive and local-first.
2. Use semantic version bumps for behavior changes.
3. Record every new capability in this manifest.
4. Validate outputs against local model availability.
5. Keep guidance consistent with RTX 4060 constraints.

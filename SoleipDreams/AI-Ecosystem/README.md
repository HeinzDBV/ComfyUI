# ComfyUI Local AI Ecosystem

## Purpose
Local private Copilot ecosystem for workflow design, execution guidance, and quality control.

## Layout
- .github/instructions: behavior and planning policies.
- .github/agents: role-based agent profiles.
- .github/skills: reusable workflow capabilities.
- SoleipDreams/AI-Ecosystem/Templates: reusable workflow templates.
- SoleipDreams/AI-Ecosystem/Scenarios: validation scenarios.
- SoleipDreams/AI-Ecosystem/Contracts: handoff contracts.

## Working Loop
1. Architect designs staged graph.
2. Builder generates executable setup plan.
3. Reviewer validates readiness and risk.

## Lifecycle
- Govern with MANIFEST.md.
- Version with VERSIONING.md and CHANGELOG.md.
- Validate with VALIDATION_CHECKLIST.md and scenario suite.
- Release with RELEASE_CHECKLIST.md.
- Operate daily with OPERATIONS_RUNBOOK.md.

## Validation Command
Run local ecosystem validation with:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\SoleipDreams\Scripts\validate_ai_ecosystem.ps1
```

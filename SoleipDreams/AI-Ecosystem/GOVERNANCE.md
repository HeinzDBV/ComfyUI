# Governance

## Scope
This governance applies to local Copilot ecosystem assets.

## Asset Classes
- Instructions: global behavior constraints and planning policies.
- Agents: role-specific execution behavior.
- Skills: reusable domain capabilities.
- Templates: reusable workflow recipes.

## Ownership
- Primary owner: local workspace maintainer.
- Every new asset must be reflected in MANIFEST.md.

## Change Policy
1. Additive changes are preferred.
2. Breaking behavior changes require version bump and changelog entry.
3. Keep recommendations executable on local RTX 4060 constraints.
4. Avoid edits to upstream-sensitive scripts unless explicitly requested.

## Review Cadence
- Light review: weekly.
- Full review: after each major ComfyUI update.

## Quality Gates
- Frontmatter validity.
- Discoverability phrase in description (Use when ...).
- Contract completeness.
- Validation scenario pass.

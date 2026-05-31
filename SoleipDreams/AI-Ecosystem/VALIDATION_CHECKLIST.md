# Validation Checklist

## Static Validation
- All instructions, agents, and skills include valid frontmatter.
- Descriptions include a clear Use when phrase.
- Asset names are unique.
- MANIFEST.md includes every active asset.

## Functional Validation
- Run scenario suite in Scenarios/.
- Confirm staged output contract (goal, node plan, parameters, fallback).
- Confirm handoff contract fields are present.

## Operational Validation
- Verify model recommendations align with local inventory.
- Verify resolutions are realistic for RTX 4060 8GB.
- Verify each scenario has at least one fallback strategy.

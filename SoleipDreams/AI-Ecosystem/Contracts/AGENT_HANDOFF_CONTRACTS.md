# Agent Handoff Contracts

## Objective
Define deterministic handoff rules between Architect, Builder, and Reviewer roles.

## Architect -> Builder Contract
Required fields:
1. Workflow objective.
2. Constraints (resolution, speed, hardware).
3. Stage map.
4. Node groups per stage.
5. Critical baseline parameters.
6. Risks and fallback path.

Acceptance criteria:
- Builder can implement without guessing missing core stages.
- Control modules are explicitly marked required or optional.

## Builder -> Reviewer Contract
Required fields:
1. Final build sequence.
2. Parameter table.
3. Dependency list.
4. Validation checks executed.
5. Known weak spots.

Acceptance criteria:
- Reviewer can perform a full go/no-go decision from provided data.

## Reviewer -> User Contract
Required fields:
1. Findings by severity.
2. Blocking issues.
3. Corrective actions.
4. Go/no-go recommendation.

Acceptance criteria:
- User can decide to run immediately or apply fixes first.

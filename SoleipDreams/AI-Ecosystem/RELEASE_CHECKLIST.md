# Release Checklist

## Pre-Release
- Confirm MANIFEST.md includes all new or changed assets.
- Confirm CHANGELOG.md has a new version entry.
- Confirm frontmatter is valid in all .github ecosystem files.
- Confirm descriptions contain actionable Use when trigger phrases.

## Validation
- Run scenario suite in Scenarios/.
- Verify handoff contracts are respected in outputs.
- Verify hardware-aware recommendations remain realistic for RTX 4060.

## Release
- Bump ecosystem version in MANIFEST.md and VERSIONING.md if needed.
- Record release date and scope.
- Archive open issues for next iteration.

## Post-Release
- Track success metrics for at least one week.
- Log regressions and update backlog.

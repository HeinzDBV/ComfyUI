# Scenario 03: Local Edit Inpaint

## Input
Need to change only one region without rewriting the full image.

## Expected System Behavior
1. Choose inpaint branch.
2. Use local mask strategy.
3. Preserve global composition and style.

## Pass Criteria
- Includes conservative denoise baseline.
- Provides rollback path to source image.

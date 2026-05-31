# Scenario 02: Pose Controlled Character

## Input
Character scene must follow a provided reference pose.

## Expected System Behavior
1. Build baseline generation path.
2. Add pose ControlNet with moderate strength.
3. Include over-constraint fallback path.

## Pass Criteria
- Control path is explicit and ordered after core setup.
- Provides tuning strategy for strength and range.

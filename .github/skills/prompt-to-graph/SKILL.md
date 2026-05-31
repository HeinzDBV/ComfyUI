---
name: prompt-to-graph
description: "Convert user prompt intent into graph decisions. Use when mapping prompt semantics to model, conditioning, and control node choices."
---
# Skill: Prompt To Graph

## Use When
- A text prompt must be converted into node-level decisions.
- Prompt intent is clear but graph structure is not.

## Inputs Expected
- Positive prompt.
- Negative prompt.
- Style or domain target.
- Required constraints (resolution, speed).

## Output Expected
1. Prompt interpretation summary.
2. Recommended model family.
3. Conditioning strategy.
4. Suggested graph path.

## Anti-Patterns
- Overloading graph complexity before baseline quality is proven.
- Mixing incompatible model assumptions in one path.

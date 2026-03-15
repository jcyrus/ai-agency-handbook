# Workflow Overview

This section explains how work moves through the handbook. Use it to decide whether a task should be handled as a human-routed specialist workflow or through a more automated execution path.

## Execution Models

| Model             | Best For                                                     | Control Level                           |
| ----------------- | ------------------------------------------------------------ | --------------------------------------- |
| Manual Specialist | Architecture, design, compliance, high-stakes delivery       | Full human approval at each handoff     |
| Automated Team    | Repetitive implementation, testing, refactoring, scaffolding | Human-in-the-loop with scriptable setup |

## Included Workflows

- [Feature Handoff](feature-handoff.md)
- [Legal Review Loop](legal-review-loop.md)
- [Agent Skill Creation](agent-skill-creation.md)

## Operating Guidance

- Use Manual Specialist when a task changes system behavior, user experience direction, or policy exposure.
- Use the faster implementation path when the scope is concrete and acceptance criteria already exist.
- Keep the human as the router for approvals, escalation, and merge decisions.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent senior-builder --target cursor
```

**Manual:**
Start with [feature-handoff.md](feature-handoff.md), then route any compliance-sensitive change through [legal-review-loop.md](legal-review-loop.md) before merge.

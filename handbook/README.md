# Handbook Overview

This handbook is the authoritative guide for running an AI-assisted agency workflow. It explains why the role model exists, how the agents hand work off to each other, and how to operationalize the system without turning the repository into a raw prompt dump.

## What This Section Covers

- The operating philosophy behind the agent roster
- Reusable domain skills that can be layered onto a role
- Templates that standardize specs, briefs, and handoffs
- Practical workflows for moving work from strategy to delivery

## Core Principles

- Architect first. The Builder should implement from a brief, not invent the system design on the fly.
- Context is leverage. The Librarian handles large-document and compliance-heavy analysis that other agents cannot reliably cover.
- Use the smallest capable agent. Fast or local agents are preferred for repetitive tasks, while deeper models are reserved for planning, design, and review.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent system-architect --target cursor
```

**Manual:**
Copy the contents of [../agents/system-architect.md](../agents/system-architect.md) into your IDE's system prompt or rules file, then pair it with a template from [templates](templates/README.md) or a workflow from [../workflows](../workflows/README.md).

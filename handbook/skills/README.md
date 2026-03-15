# Skills Overview

Skills are reusable domain packs that refine what an agent knows without changing how that agent behaves. Use them when a role needs stack-specific constraints, quality gates, or reference material for a project.

## Included Skills

- [Rust TUI Engineering](rust-tui-engineering.md)
- [Glassmorphism UI Engineering](glassmorphism-ui.md)
- [AI-Driven Development](ai-driven-development.md)

## When To Use Skills

- Add a skill when the work depends on a concrete stack, framework, or domain standard.
- Keep the base role stable. Do not move personality, escalation behavior, or routing logic into a skill.
- Stack multiple skills only when their rules do not conflict.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent senior-builder --target cursor
```

**Manual:**
Copy the base role from [../../agents/senior-builder.md](../../agents/senior-builder.md), then append the relevant skill from this folder underneath the role prompt in your AI tool.

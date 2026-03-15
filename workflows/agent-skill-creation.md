# Agent Skill Creation & Application Workflow

> How to create, apply, and orchestrate plug-and-play Skills that give your AI agents domain-specific expertise without changing their core behavior.

## Overview

The AI Agency Handbook defines agents by **Roles** — persistent identities like The Architect, The Builder, or The Librarian. Roles govern _how_ an agent behaves: its protocol, tone, escalation rules, and interaction patterns.

**Skills** are a new architectural layer. A Skill defines _what_ domain knowledge, tech stack constraints, and quality gates an agent applies to a specific task. Skills are modular, composable, and role-agnostic by design.

This workflow explains the conceptual model and provides step-by-step instructions for creating and applying Skills.

---

## Roles vs. Skills: The Conceptual Model

| Dimension         | Role                                      | Skill                                                       |
| :---------------- | :---------------------------------------- | :---------------------------------------------------------- |
| **Defines**       | HOW the agent behaves                     | WHAT knowledge the agent applies                            |
| **Scope**         | Persistent identity across all tasks      | Activated per-task or per-project                           |
| **Examples**      | The Builder, The Architect, The Librarian | Rust TUI Engineering, PH Labor Compliance, Glassmorphism UI |
| **Stored In**     | `agents/` directory                       | `handbook/skills/` directory                                |
| **Cardinality**   | One Role per agent at a time              | Multiple Skills can stack on one Role                       |
| **Modifiable By** | CTO / Handbook maintainer                 | Any team member for their project domain                    |

### The Mental Model

Think of it as hiring. A **Role** is the job description — "You are a Senior Engineer." A **Skill** is the onboarding packet — "Here's the tech stack, the compliance rules, and the quality bar for _this specific project_."

You wouldn't rewrite the job description every time you switch projects. You swap the onboarding packet.

```
┌─────────────────────────────────────────────────┐
│  Agent Instance                                 │
│                                                 │
│  ┌──────────────┐   ┌────────────────────────┐  │
│  │   ROLE       │ + │   SKILL(S)             │  │
│  │ (Identity)   │   │ (Domain Context)       │  │
│  │              │   │                        │  │
│  │ The Builder  │   │ 01_rust_tui_engineering │  │
│  │ - Protocol   │   │ - Ratatui + Crossterm  │  │
│  │ - Tone       │   │ - Zero-alloc loops     │  │
│  │ - Escalation │   │ - Memory safety gates  │  │
│  └──────────────┘   └────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

---

## Creating a New Skill

```bash
cp handbook/templates/skill-definition.md handbook/skills/your-skill-name.md
```

Use lowercase kebab-case for the filename. See the [skill template](../handbook/templates/skill-definition.md) and pair with a role from [agents/](../agents/README.md).

### Step 1: Fill Out Required Sections

Every skill must define these four sections:

| Section               | Purpose                                                          |
| :-------------------- | :--------------------------------------------------------------- |
| **Target Role**       | Which Role(s) this skill is designed for                         |
| **Core Directives**   | Non-negotiable rules when this skill is active                   |
| **Context Injection** | Tech stack, domain knowledge, references, and quality gates      |
| **Handoff Protocol**  | How the agent packages output for the next agent in the pipeline |

> **Note:** The [skill template](../handbook/templates/skill-definition.md) also requires **Usage** and **Quick Start** sections. Fill those out to ensure your skill is discoverable and easy to apply.

### Step 2: Validate

Before committing, verify:

- [ ] The skill does NOT redefine the Role's behavior (protocol, tone, escalation). It only adds domain context.
- [ ] Core Directives are testable — another agent (or human) can verify compliance.
- [ ] Quality Gates have clear pass/fail criteria.
- [ ] The Handoff Protocol specifies output format and destination Role.

---

## Applying Skills

### Method A: Manual Application (Copy & Paste)

Use this when working in Claude Projects, ChatGPT Custom Instructions, Cursor Rules, or any chat interface.

**Step 1:** Paste the base role page from `agents/`.

**Step 2:** Append a separator and the skill content:

```markdown
[Contents of agents/senior-builder.md]

---

## ACTIVE SKILL: Rust TUI Engineering

[Paste Core Directives and Context Injection sections from handbook/skills/rust-tui-engineering.md]
```

**Step 3:** Issue your task. The agent now operates with the Builder's behavioral protocol _and_ the Rust TUI skill's domain constraints.

#### Stacking Multiple Skills

You can activate multiple skills in a single session:

```markdown
[Base Role Prompt]

---

## ACTIVE SKILL: Rust TUI Engineering

[Core Directives + Context Injection]

---

## ACTIVE SKILL: AI-Driven Development

[Core Directives + Context Injection]
```

> **Conflict Resolution:** If two skills have contradictory directives, the skill listed **first** takes priority. When in doubt, the agent should escalate to a human.

---

### Method B: OpenCode + oh-my-opencode Integration

Use this when running agents via `opencode` CLI with the `oh-my-opencode` orchestration layer.

**Step 1:** Open your project's `scripts/config/oh-my-opencode.json` or copy it into your working repo root before running `opencode`.

**Step 2:** Create a skill-specific agent by appending the skill summary to `prompt_append`:

```json
{
  "agents": {
    "hephaestus-tui": {
      "model": "github-copilot/gpt-5.3-codex",
      "variant": "medium",
      "prompt_append": "You are The Builder (implementation mode). ACTIVE SKILL: Rust TUI Engineering. Enforce strict memory safety (no unsafe unless justified), zero-allocation render loops, Ratatui + Crossterm stack."
    }
  }
}
```

**Step 3:** Run the skill-equipped agent:

```bash
opencode --agent hephaestus-tui "Implement the dashboard widget based on the attached Brief."
```

---

### Method C: Skill as a Standalone Context File

For teams using tools that support file-based context injection (Cursor, Windsurf, Cline, etc.):

1. Place the skill `.md` file in your project's context directory (e.g., `.cursor/rules/`, `.github/copilot-instructions.md`, or equivalent).
2. The tool will automatically inject the skill's content into every prompt.
3. This approach works best when a project uses a single skill consistently.

---

## Skill Lifecycle

**Create** → copy template and fill sections → **Apply** → inject via paste, config, or context file → **Iterate** → review output, refine directives, bump version, commit.

- Increment the version in the skill header when directives change.
- Add `CHANGELOG` comments at the bottom of the skill file for audit trails.
- Review skills quarterly or when the underlying tech stack has a major release.

---

## Quick Reference

| I want to...               | Do this                                                                                        |
| :------------------------- | :--------------------------------------------------------------------------------------------- |
| Create a new skill         | `cp handbook/templates/skill-definition.md handbook/skills/your-skill-name.md` and fill it out |
| Apply a skill manually     | Paste role prompt → separator → skill content into your AI chat                                |
| Apply a skill via OpenCode | Add a new agent entry in `scripts/config/oh-my-opencode.json` with skill in `prompt_append`    |
| Stack multiple skills      | Concatenate skill blocks below the role prompt with `---` separators                           |
| Resolve skill conflicts    | First-listed skill wins; escalate ambiguity to human                                           |
| Update a skill             | Edit the `.md`, bump version, commit with changelog note                                       |

# Skill Definition: [Skill Name]

**Skill ID:** `[XX]_[snake_case_name]`
**Version:** 1.0
**Last Updated:** [YYYY-MM-DD]

---

## Target Role

| Field             | Value                                                                      |
| :---------------- | :------------------------------------------------------------------------- |
| **Primary Role**  | [The Architect / The Builder / The Librarian / The Visionary / The Intern] |
| **Model Target**  | [e.g., Claude Opus 4.6, GPT-5.3 Codex]                                     |
| **Fallback Role** | [Optional — secondary role that can use this skill]                        |

> **Note:** A Skill is NOT a Role. The Role defines HOW the agent behaves (its personality, protocol, interaction style). This Skill defines WHAT domain knowledge and constraints the agent applies to a given task. One Role can load many Skills. One Skill can be shared across Roles.

---

## Core Directives

_The non-negotiable rules the agent must follow when this skill is active._

### 1. [Directive Category]

- [Specific rule or constraint]
- [Specific rule or constraint]

### 2. [Directive Category]

- [Specific rule or constraint]
- [Specific rule or constraint]

### 3. [Directive Category]

- [Specific rule or constraint]
- [Specific rule or constraint]

---

## Context Injection

_The domain-specific knowledge, tech stack references, and standards the agent must internalize._

### Tech Stack

| Layer         | Technology         | Version / Notes          |
| :------------ | :----------------- | :----------------------- |
| **Language**  | [e.g., TypeScript] | [e.g., 5.x, strict mode] |
| **Framework** | [e.g., Next.js]    | [e.g., App Router]       |
| **Library**   | [e.g., Ratatui]    | [e.g., latest stable]    |

### Domain Knowledge

- [Reference document, standard, or specification the agent should treat as authoritative]
- [Key concepts the agent must understand before generating output]
- [Anti-patterns the agent must avoid in this domain]

### Quality Gates

The agent must verify the following before considering any output complete:

- [ ] [Gate 1 — e.g., "All types are strict, no `any`"]
- [ ] [Gate 2 — e.g., "Zero unsafe blocks unless explicitly justified"]
- [ ] [Gate 3 — e.g., "Accessibility audit passes WCAG 2.1 AA"]

---

## Handoff Protocol

_How the agent should package its output for the next agent in the pipeline._

### Output Artifacts

| Artifact                  | Format         | Destination Role      |
| :------------------------ | :------------- | :-------------------- |
| [e.g., Component Code]    | `.tsx` / `.rs` | [e.g., The Builder]   |
| [e.g., Compliance Report] | Markdown       | [e.g., The Architect] |

### Handoff Message Template

```

@[Next Role]: [Skill Name] output is ready.

- Artifacts: [list of files/documents produced]
- Assumptions: [any assumptions made during execution]
- Open Questions: [unresolved items requiring human or senior agent review]
- Quality Gates: [PASSED / FAILED — list any failures]

```

### Escalation Triggers

The agent must **stop and escalate** to a human or senior agent if:

- [Condition 1 — e.g., "Spec is ambiguous or contradictory"]
- [Condition 2 — e.g., "A security-critical decision must be made"]
- [Condition 3 — e.g., "Output would violate a Core Directive"]

---

## Usage

### Manual Application

Paste this skill block **below** the base Role prompt in your AI conversation:

```

[Base Role Prompt — e.g., contents of agents/senior-builder.md]

---

ACTIVE SKILL: [Skill Name]
[Paste the Core Directives and Context Injection sections here]

---

```

### OpenCode Integration

Add the skill to an agent's `prompt_append` in `scripts/config/oh-my-opencode.json`:

```jsonc
{
  "agents": {
    "agent-name": {
      "model": "provider/model",
      "prompt_append": "[Base role prompt] ACTIVE SKILL: [Skill Name]. [Core Directives summary].",
    },
  },
}
```

> See [`../../workflows/agent-skill-creation.md`](../../workflows/agent-skill-creation.md) for the full integration guide.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/new-agent.sh --name "Domain Specialist" --division "Engineering"
```

**Manual:**
Copy this template into `handbook/skills/your-skill-name.md`, fill in the sections, and reference it from a role in [../../agents/README.md](../../agents/README.md).

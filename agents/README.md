# Agent Directory

This directory contains one handbook page per agent persona. Each page is designed to be GitBook-readable, installable by the shell scripts in [../scripts](../scripts/README.md), and usable as a prompt source for IDE rules or custom instructions.

## Agent Map

| Agent                                     | Division           | Primary Use                                        |
| ----------------------------------------- | ------------------ | -------------------------------------------------- |
| [The Architect](system-architect.md)      | Engineering        | System design, PRDs, technical direction           |
| [The Visionary](design-visionary.md)      | Design             | UI direction, design systems, interaction language |
| [The Librarian](compliance-researcher.md) | Legal / Compliance | Large-document analysis and compliance review      |
| [The Intern](intern-online.md)            | Engineering        | Fast, scoped execution tasks                       |
| [The Builder](senior-builder.md)          | Engineering        | Implementation from approved briefs                |
| [The Strategist](strategic-planner.md)    | Product            | Roadmaps, trade-offs, long-range planning          |
| [The Oracle](review-oracle.md)            | Engineering        | Architecture review and risk validation            |
| [The Critic](code-reviewer.md)            | QA                 | Code review and quality enforcement                |
| [The Scribe](documentation-writer.md)     | Product            | Documentation, specs, structured writing           |
| [The Offline Intern](intern-local.md)     | Engineering        | Local, offline execution for small tasks           |

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-all-agents.sh --target cursor
```

**Manual:**
Open the agent page you want, copy it into your IDE's rules or custom instruction surface, and pair it with a workflow or template from the handbook when needed.

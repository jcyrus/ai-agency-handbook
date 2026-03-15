# Templates Overview

Templates standardize the outputs that move between agents. They keep handoffs readable, reviewable, and predictable across architecture, design, implementation, and skill authoring.

## Included Templates

- [Architecture Specification](architecture-spec.md)
- [Design Specification](design-spec.md)
- [Implementation Brief](implementation-brief.md)
- [Skill Definition](skill-definition.md)

## How To Use Templates

- **Architecture Specification** — capture system design decisions before implementation.
- **Design Specification** — turn user flows and component behavior into a concrete UI brief.
- **Implementation Brief** — consolidate approved scope for the Builder.
- **Skill Definition** — add new domain expertise to the handbook.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent documentation-writer --target cursor
```

**Manual:**
Open the template you need, fill in the placeholders, and pass the completed document to the next agent in the workflow.

# Templates Overview

Templates standardize the outputs that move between agents. They keep handoffs readable, reviewable, and predictable across architecture, design, implementation, and skill authoring.

## Included Templates

- [Architecture Specification](architecture-spec.md)
- [Design Specification](design-spec.md)
- [Implementation Brief](implementation-brief.md)
- [Skill Definition](skill-definition.md)

## How To Use Templates

- Use the Architecture Specification to capture system design decisions before implementation.
- Use the Design Specification to turn user flows and component behavior into a concrete UI brief.
- Use the Implementation Brief to consolidate approved scope for the Builder.
- Use the Skill Definition template when adding new domain expertise to the handbook.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent documentation-writer --target cursor
```

**Manual:**
Open the template you need, fill in the placeholders, and pass the completed document to the next agent in the workflow.

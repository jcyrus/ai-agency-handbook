# Automation Overview

The scripts in this directory turn the handbook from reference material into runnable setup commands. They install agents into common tools, scaffold new agent pages, and validate GitBook navigation.

## Included Scripts

- `install-agent.sh` installs one agent into Cursor, Claude Code, Aider, or prints ChatGPT instructions
- `install-all-agents.sh` installs every agent file for Cursor, Claude Code, or Aider (chatgpt not supported in batch mode)
- `validate-links.sh` checks that links in `SUMMARY.md` resolve to real files and warns about orphaned markdown files
- `new-agent.sh` scaffolds a new agent page with the required frontmatter and sections

## Quick Start

**Automated (recommended):**

```bash
bash scripts/validate-links.sh
```

**Manual:**
Review [../SUMMARY.md](../SUMMARY.md), then open each linked page directly in GitBook or your editor to verify the structure by hand.

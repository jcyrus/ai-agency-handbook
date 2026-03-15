#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

success() {
  printf '%b\n' "${GREEN}[OK] $1${NC}"
}

warn() {
  printf '%b\n' "${YELLOW}[WARN] $1${NC}"
}

error() {
  printf '%b\n' "${RED}[ERROR] $1${NC}" >&2
}

usage() {
  cat <<'EOF'
Usage:
  bash scripts/new-agent.sh --name "Agent Name" --division "Engineering"

Options:
  --name      Display name for the agent
  --division  Division shown in frontmatter
  --help      Show this help message
EOF
}

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/--+/-/g'
}

NAME=""
DIVISION=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --name)
      if [ -z "${2:-}" ]; then
        error "Missing value for --name"
        usage
        exit 1
      fi
      NAME="$2"
      shift 2
      ;;
    --division)
      if [ -z "${2:-}" ]; then
        error "Missing value for --division"
        usage
        exit 1
      fi
      DIVISION="$2"
      shift 2
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      error "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [ -z "$NAME" ] || [ -z "$DIVISION" ]; then
  error "Both --name and --division are required"
  usage
  exit 1
fi

SLUG="$(slugify "$NAME")"

if [ -z "$SLUG" ]; then
  error "Unable to generate a slug from the provided name"
  exit 1
fi

TARGET_FILE="$REPO_ROOT/agents/$SLUG.md"

if [ -f "$TARGET_FILE" ]; then
  warn "Agent file already exists: agents/$SLUG.md"
  exit 0
fi

TEMP_FILE="$(mktemp)"
cat > "$TEMP_FILE" <<'EOF'
---
title: __NAME__
division: __DIVISION__
tags: [todo, agent]
---

# __NAME__

## Identity

[Who this agent is, personality traits, communication style]

## Mission

[Core purpose and primary responsibilities]

## Rules

[Domain-specific critical rules and constraints this agent always follows]

## Success Metrics

[How you know this agent did its job well — measurable outcomes]

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent __SLUG__ --target cursor
```

**Manual:**
Copy the contents of `/agents/__SLUG__.md` into your IDE's system prompt or rules file.
EOF
sed -e "s/__NAME__/$NAME/g" -e "s/__DIVISION__/$DIVISION/g" -e "s/__SLUG__/$SLUG/g" "$TEMP_FILE" > "$TARGET_FILE"
rm -f "$TEMP_FILE"

success "Created agents/$SLUG.md"
warn "Next steps: edit the new file, add it to SUMMARY.md if needed, then run bash scripts/validate-links.sh"
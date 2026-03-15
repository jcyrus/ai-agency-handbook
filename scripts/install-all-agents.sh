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
  bash scripts/install-all-agents.sh --target <cursor|claude|aider>

Options:
  --target  Installation target for all agents
  --help    Show this help message
EOF
}

TARGET=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target)
      if [ -z "${2:-}" ]; then
        error "Missing value for --target"
        usage
        exit 1
      fi
      TARGET="$2"
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

# chatgpt is excluded: install-agent.sh handles it by printing to stdout,
# which does not work in batch mode.
case "$TARGET" in
  cursor|claude|aider)
    ;;
  *)
    error "Target must be one of: cursor, claude, aider"
    usage
    exit 1
    ;;
esac

INSTALLED=0
FAILED=0
AGENT_LIST="$(mktemp)"
trap 'rm -f "$AGENT_LIST"' EXIT

find "$REPO_ROOT/agents" -maxdepth 1 -type f -name '*.md' ! -name 'README.md' | sort > "$AGENT_LIST"

while IFS= read -r agent_path; do
  agent_slug="$(basename "$agent_path" .md)"
  if bash "$SCRIPT_DIR/install-agent.sh" --agent "$agent_slug" --target "$TARGET"; then
    INSTALLED=$((INSTALLED + 1))
  else
    FAILED=$((FAILED + 1))
  fi
done < "$AGENT_LIST"

if [ "$FAILED" -gt 0 ]; then
  warn "Completed with failures. Installed: $INSTALLED, Failed: $FAILED"
  exit 1
fi

success "Installed $INSTALLED agents for target: $TARGET"
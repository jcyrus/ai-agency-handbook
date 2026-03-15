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
  bash scripts/install-agent.sh --agent <slug> --target <cursor|claude|aider|chatgpt>

Options:
  --agent   Agent slug from the agents/ directory
  --target  Installation target: cursor, claude, aider, or chatgpt
  --help    Show this help message

Examples:
  bash scripts/install-agent.sh --agent system-architect --target cursor
  bash scripts/install-agent.sh --agent design-visionary --target claude
EOF
}

require_value() {
  if [ -z "${2:-}" ]; then
    error "Missing value for $1"
    usage
    exit 1
  fi
}

strip_managed_block() {
  file_path="$1"
  begin_marker="$2"
  end_marker="$3"

  if [ ! -f "$file_path" ]; then
    return 0
  fi

  awk -v begin="$begin_marker" -v end="$end_marker" '
    $0 == begin { skip = 1; next }
    $0 == end { skip = 0; next }
    !skip { print }
  ' "$file_path"
}

remove_top_level_system_prompt() {
  file_path="$1"

  if [ ! -f "$file_path" ]; then
    return 0
  fi

  awk '
    BEGIN { skip = 0 }
    /^system_prompt:[[:space:]]*\|[[:space:]]*$/ { skip = 1; next }
    skip && /^[^[:space:]#]/ { skip = 0 }
    skip { next }
    /^system_prompt:[[:space:]]*".*"[[:space:]]*$/ { next }
    /^system_prompt:[[:space:]]*\047.*\047[[:space:]]*$/ { next }
    { print }
  ' "$file_path"
}

indent_content() {
  sed 's/^/  /'
}

AGENT_SLUG=""
TARGET=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent)
      require_value "$1" "${2:-}"
      AGENT_SLUG="$2"
      shift 2
      ;;
    --target)
      require_value "$1" "${2:-}"
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

if [ -z "$AGENT_SLUG" ] || [ -z "$TARGET" ]; then
  error "Both --agent and --target are required"
  usage
  exit 1
fi

AGENT_FILE="$REPO_ROOT/agents/$AGENT_SLUG.md"

if [ ! -f "$AGENT_FILE" ]; then
  error "Agent file not found: agents/$AGENT_SLUG.md"
  exit 1
fi

case "$TARGET" in
  cursor)
    TARGET_DIR="$REPO_ROOT/.cursor/rules"
    TARGET_FILE="$TARGET_DIR/$AGENT_SLUG.mdc"
    mkdir -p "$TARGET_DIR"
    if [ -f "$TARGET_FILE" ] && cmp -s "$AGENT_FILE" "$TARGET_FILE"; then
      warn "Cursor rule already up to date: .cursor/rules/$AGENT_SLUG.mdc"
      exit 0
    fi
    cp "$AGENT_FILE" "$TARGET_FILE"
    success "Installed $AGENT_SLUG to .cursor/rules/$AGENT_SLUG.mdc"
    ;;
  claude)
    TARGET_FILE="$REPO_ROOT/CLAUDE.md"
    BEGIN_MARKER="# BEGIN AI-AGENCY-HANDBOOK:$AGENT_SLUG"
    END_MARKER="# END AI-AGENCY-HANDBOOK:$AGENT_SLUG"
    TEMP_FILE="$(mktemp)"
    strip_managed_block "$TARGET_FILE" "$BEGIN_MARKER" "$END_MARKER" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$TARGET_FILE"
    {
      if [ -s "$TARGET_FILE" ]; then
        printf '\n'
      fi
      printf '%s\n' "$BEGIN_MARKER"
      cat "$AGENT_FILE"
      printf '\n%s\n' "$END_MARKER"
    } >> "$TARGET_FILE"
    success "Installed $AGENT_SLUG into CLAUDE.md"
    ;;
  aider)
    TARGET_FILE="$REPO_ROOT/.aider.conf.yml"
    BEGIN_MARKER="# BEGIN AI-AGENCY-HANDBOOK:$AGENT_SLUG"
    END_MARKER="# END AI-AGENCY-HANDBOOK:$AGENT_SLUG"
    TEMP_FILE="$(mktemp)"
    TEMP_STRIPPED="$(mktemp)"
    strip_managed_block "$TARGET_FILE" "$BEGIN_MARKER" "$END_MARKER" > "$TEMP_STRIPPED"
    remove_top_level_system_prompt "$TEMP_STRIPPED" > "$TEMP_FILE"
    rm -f "$TEMP_STRIPPED"
    mv "$TEMP_FILE" "$TARGET_FILE"
    {
      if [ -s "$TARGET_FILE" ]; then
        printf '\n'
      fi
      printf '%s\n' "$BEGIN_MARKER"
      printf 'system_prompt: |\n'
      cat "$AGENT_FILE" | indent_content
      printf '%s\n' "$END_MARKER"
    } >> "$TARGET_FILE"
    success "Installed $AGENT_SLUG into .aider.conf.yml"
    ;;
  chatgpt)
    success "ChatGPT does not support direct file installation. Paste the following into your custom instructions or project instructions:"
    printf '\n----- BEGIN %s -----\n' "$AGENT_SLUG"
    cat "$AGENT_FILE"
    printf '\n----- END %s -----\n' "$AGENT_SLUG"
    ;;
  *)
    error "Unsupported target: $TARGET"
    usage
    exit 1
    ;;
esac
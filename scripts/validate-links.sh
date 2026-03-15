#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
SUMMARY_FILE="$REPO_ROOT/SUMMARY.md"

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
  bash scripts/validate-links.sh

Checks that:
  1. All links in SUMMARY.md resolve to real files.
  2. All markdown files in the repo are listed in SUMMARY.md (orphan check).
EOF
}

if [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ ! -f "$SUMMARY_FILE" ]; then
  error "SUMMARY.md not found"
  exit 1
fi

BROKEN=0

LINKS_FILE="$(mktemp)"
LISTED_FILE="$(mktemp)"
ALL_MD_FILE="$(mktemp)"
trap 'rm -f "$LINKS_FILE" "$LISTED_FILE" "$ALL_MD_FILE"' EXIT

grep -o '\[[^]]*\]([^)]*)' "$SUMMARY_FILE" | sed -E 's/.*\(([^)#]+)(#.*)?\)/\1/' > "$LINKS_FILE"

while IFS= read -r rel_path; do
  [ -n "$rel_path" ] || continue
  target_path="$REPO_ROOT/$rel_path"
  printf '%s\n' "$rel_path" >> "$LISTED_FILE"
  if [ -f "$target_path" ]; then
    success "Found: $rel_path"
  else
    error "Broken link: $rel_path"
    BROKEN=1
  fi
done < "$LINKS_FILE"

find "$REPO_ROOT" -type f -name '*.md' \
  ! -path "$REPO_ROOT/.git/*" \
  ! -path "$REPO_ROOT/node_modules/*" \
  | sed "s#^$REPO_ROOT/##" \
  | sort > "$ALL_MD_FILE"

sort -u "$LISTED_FILE" -o "$LISTED_FILE"

# SUMMARY.md is the index itself — skip it from the orphan check
SUMMARY_REL="SUMMARY.md"

while IFS= read -r rel_path; do
  [ "$rel_path" = "$SUMMARY_REL" ] && continue
  if ! grep -Fxq "$rel_path" "$LISTED_FILE"; then
    warn "Not listed in SUMMARY.md: $rel_path"
  fi
done < "$ALL_MD_FILE"

if [ "$BROKEN" -ne 0 ]; then
  error "Validation failed — broken links found"
  exit 1
fi

success "All links resolved. No broken references found."
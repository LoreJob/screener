#!/usr/bin/env bash
# Shared validation for the cv-screener skill.
# Used by CI (.github/workflows/validate.yml) and by contributors locally:
#   ./scripts/validate.sh
set -u

cd "$(dirname "$0")/.."
failed=0

fail() { echo "  ✗ $1"; failed=1; }
pass() { echo "  ✓ $1"; }

SKILL="skills/cv-screener/SKILL.md"
REFS="skills/cv-screener/references"

echo "Checking skill entry point ($SKILL)..."
if [ ! -f "$SKILL" ]; then
  fail "missing $SKILL"
  echo "Validation failed."
  exit 1
fi

head -1 "$SKILL" | grep -q '^---$' && pass "frontmatter opens on line 1" || fail "frontmatter must open with --- on line 1"
grep -q '^name: cv-screener$' "$SKILL" && pass "name matches directory (cv-screener)" || fail "frontmatter name must be 'cv-screener' (must match directory name)"
grep -q '^description: ' "$SKILL" && pass "description present" || fail "missing description in frontmatter"

desc_len=$(grep '^description: ' "$SKILL" | head -1 | wc -c | tr -d ' ')
if [ "$desc_len" -le 1024 ]; then
  pass "description length ${desc_len} ≤ 1024 chars"
else
  fail "description is ${desc_len} chars (max 1024)"
fi

echo
echo "Checking core references..."
for f in "$REFS/SCREENING_PROTOCOL.md" "$REFS/ATS_KEYWORDS.md"; do
  [ -f "$f" ] && pass "$f exists" || fail "missing $f"
done

for marker in "VERDICT" "ATS SCORE" "OVERALL CV SCORE" "SCORE BREAKDOWN"; do
  grep -q "$marker" "$REFS/SCREENING_PROTOCOL.md" && pass "protocol defines output marker: $marker" || fail "protocol missing output marker: $marker"
done

echo
echo "Checking sector modules..."
# Every references/*.md mentioned in SKILL.md must exist
for ref in $(grep -o 'references/[a-z-]*\.md' "$SKILL" | sort -u); do
  [ -f "skills/cv-screener/$ref" ] && pass "router reference resolves: $ref" || fail "router references missing file: $ref"
done

# Every sector module must be wired into the router and follow the template
for f in "$REFS"/*.md; do
  base=$(basename "$f")
  case "$base" in SCREENING_PROTOCOL.md|ATS_KEYWORDS.md) continue;; esac
  echo "  Module: $base"
  grep -q "references/$base" "$SKILL" && pass "  listed in router sector map" || fail "  $base not referenced in $SKILL sector map"
  grep -q 'references/SCREENING_PROTOCOL.md' "$f" && pass "  references core protocol" || fail "  $base does not reference references/SCREENING_PROTOCOL.md"
  grep -qi 'hard disqualifiers' "$f" && pass "  defines hard disqualifiers" || fail "  $base missing 'Hard Disqualifiers' section"
done

echo
if [ "$failed" -eq 1 ]; then
  echo "Validation failed."
  exit 1
fi
echo "All checks passed."

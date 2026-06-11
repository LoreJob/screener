# Contributing

This guide explains how to contribute to the CV Screener skill — most commonly by adding a new sector module.

---

## How to Submit a Change

1. **Open an issue first** for new sector modules, describing the sector and why it's distinct from the existing ones. Small fixes (typos, keyword additions) can go straight to a PR.
2. **Fork** the repository and create a branch: `git checkout -b add-<sector-name>`
3. Make your changes and **run the validation script locally**: `./scripts/validate.sh`
4. **Open a PR** against `main` using the checklist at the bottom of this guide.

---

## Repository Structure

The whole skill is one self-contained folder:

```
cv-screener/
├── SKILL.md                       # Router: triggering, input validation, sector dispatch
└── references/
    ├── SCREENING_PROTOCOL.md      # Shared evaluation framework (scoring, verdict, output format)
    ├── ATS_KEYWORDS.md            # Cross-sector ATS keyword reference
    ├── consulting.md              # One evaluation module per sector
    ├── tech-software.md
    └── ...
```

Sector modules are **reference files, not standalone skills**: they have no YAML frontmatter and are loaded by the router on demand.

---

## Adding a New Sector Module

### Before you start

Check the existing modules in `cv-screener/references/`. If a sector is already covered, consider whether your contribution adds a meaningfully different vertical (e.g., a "construction" module is distinct from "manufacturing") or whether it belongs as an extension of an existing module.

### 1. Create `cv-screener/references/<sector-name>.md`

Use a lowercase, hyphenated file name: `tech-software.md`, `pharma-biotech.md`, `retail-fmcg.md`.

The module must contain, in order:

**Recruiter persona** — open with a brief paragraph establishing the recruiter persona for this sector. Who are you? What have you hired for? What companies have you placed people at? This sets the tone for the evaluation.

**Core protocol reference** — this section is mandatory and validated by CI:

```markdown
## Core Protocol

Follow `references/SCREENING_PROTOCOL.md` for the full evaluation framework.

This file defines **[sector]-specific criteria** on top of the core protocol.
```

**Sector-specific ATS keywords** — organized by sub-function or specialization. Include core technical/functional keywords; key tools, systems, and platforms; relevant certifications.

**Sector-specific pass/fail criteria** — three sections:
- **Hard Disqualifiers** — automatic rejection regardless of score. Be specific and defensible.
- **Strong Red Flags** — penalizes score heavily. Things that consistently indicate a weak candidate for this sector.
- **Quality Signals** — what distinguishes a strong candidate. These inform the scoring calibration.

**Score calibration adjustments** — a table showing how to adjust the six scoring components from their default weights for this sector. All weights must still sum to 100%.

**Sector output additions** — a code block showing the sector-specific signals section to append to the standard output. Keep it to 5–7 fields:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[SECTOR] FIT SIGNALS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Signal label:  [Value 1 / Value 2 / Value 3]
...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2. Wire the module into the router

In `cv-screener/SKILL.md`:
- Add a row to the **Sector Map** table (`references/<sector-name>.md` + classification triggers)
- If the sector borders an existing one, add a rule to **Ambiguous Cases**

### 3. Update the README

Add the module to the **Covered Sectors** table in `README.md`.

---

## The Tone Standard

This is the most important requirement and the one most contributors get wrong.

The module must behave like a recruiter, not a coach. Read the Tone Standards section in `cv-screener/references/SCREENING_PROTOCOL.md` before writing anything.

**Do not write:**
> "Your background shows some relevant experience, but you may want to consider adding more quantification to your achievements."

**Do write:**
> "The CV lists responsibilities across six roles with zero quantified outcomes. This is a fundamental failure for this sector, where impact metrics are the baseline expectation."

The difference is not aggressiveness — it is precision and refusal to soften the verdict.

---

## Validation

CI runs `scripts/validate.sh` on every push and PR. Run the same script locally before submitting:

```bash
./scripts/validate.sh
```

It checks the skill frontmatter, that every module referenced by the router exists (and vice versa), that each module references the core protocol, and that required sections are present.

---

## PR Checklist

- [ ] New module is `cv-screener/references/<sector-name>.md` (lowercase, hyphenated)
- [ ] Module contains all required sections (persona, core protocol reference, keywords, pass/fail criteria, calibration, output additions)
- [ ] Tone follows the standard (objective, direct, no coaching)
- [ ] Hard disqualifiers are defensible and sector-specific
- [ ] Score calibration weights sum to 100%
- [ ] Router sector map in `cv-screener/SKILL.md` is updated
- [ ] `README.md` Covered Sectors table is updated
- [ ] `./scripts/validate.sh` passes locally

# CV Screener

[![Validate](https://github.com/LoreJob/screener/actions/workflows/validate.yml/badge.svg)](https://github.com/LoreJob/screener/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A Claude skill that acts as a **brutally honest, sector-specific recruiter**. No encouragement, no fluff — just the same cold, objective assessment a real recruiter would give your CV before deciding whether to call you.

---

## Philosophy

Real recruiters spend an average of **6–8 seconds** on a CV before deciding to reject it. They are not your friend. They don't care about your potential. They care about whether your CV matches the job description and clears the ATS (Applicant Tracking System) filter.

This skill replicates that exact behavior:

- **Screens your CV against a specific job description** the way an ATS would
- **Evaluates sector fit** based on industry-specific expectations
- **Gives you a score from 1 to 10**, calibrated to be honest — a 6 is not good
- **Issues a binary verdict**: `ACCEPTED FOR INTERVIEW` or `REJECTED`
- **If rejected, tells you exactly why** — no softening, no "you could improve X"

There is no "almost there." Either your CV is ready for the role or it isn't.

---

## Installation

The skill is a single self-contained folder: [cv-screener/](cv-screener/), containing the router ([SKILL.md](cv-screener/SKILL.md)) and the evaluation modules ([references/](cv-screener/references/)).

### Claude Code

```bash
git clone https://github.com/LoreJob/screener.git
mkdir -p ~/.claude/skills
cp -r screener/cv-screener ~/.claude/skills/
```

To install it for a single project instead, copy it to `.claude/skills/` inside the project. Verify with `/skills` in Claude Code.

### Claude.ai (Pro, Max, Team, Enterprise)

1. Download this repository (**Code → Download ZIP**) and extract it
2. Create a zip of the skill folder only:
   ```bash
   cd screener && zip -r cv-screener.zip cv-screener
   ```
3. On claude.ai go to **Settings → Capabilities**, enable **Skills**, and upload `cv-screener.zip`

### Claude API / Agent SDK

Upload the `cv-screener/` folder via the Skills API. See the [Agent Skills documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) for details.

---

## How to Use

1. Type **`screener`** in the chat (or just ask "is my CV good enough for this role?")
2. Upload or paste your **CV**
3. Upload or paste the **full job description** — a job title alone is not accepted
4. The skill identifies the sector from the JD, loads the matching evaluation module, and delivers the verdict

**Example output (abridged):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECTOR IDENTIFIED: STRATEGY CONSULTING
SECTOR MODULE:     consulting.md
ROLE:              Junior Consultant
COMPANY:           McKinsey & Company
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERDICT: REJECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ATS SCORE:        4.8 / 10
OVERALL CV SCORE: 5.1 / 10

ASSESSMENT
The CV describes three years of generalist project coordination with zero
quantified outcomes. For MBB screening this reads as administrative
experience, not consulting-adjacent work. It would not survive the first
human pass.

REJECTION REASONS
1. No quantified impact anywhere in the CV — consulting recruiters treat
   this as a proxy for non-analytical thinking.
2. ATS keyword match below threshold: "financial modeling", "due diligence"
   and "market sizing" required by the JD, none present.
3. ...
```

---

## Covered Sectors

| Module | Coverage |
|---|---|
| `consulting` | Strategy & Management Consulting (MBB, Big 4, boutiques) |
| `tech-software` | Software Engineering, Product, Data Science, AI/ML |
| `finance-banking` | Investment Banking, Private Equity, Asset Management |
| `manufacturing` | Operations, Supply Chain, Industrial Engineering |
| `marketing` | Brand, Digital, Growth, Communications |
| `hr-legal` | Human Resources, Legal, Compliance |
| `pharma-biotech` | Pharmaceuticals, Biotech, Medical Devices, Clinical Research |
| `retail-fmcg` | Retail, Consumer Goods, Category Management |
| `energy-utilities` | Oil & Gas, Renewables, Energy Trading, Utilities |

Roles outside these sectors are still screened using the core protocol alone, with a note that sector calibration was not applied.

All modules share the evaluation framework in [SCREENING_PROTOCOL.md](cv-screener/references/SCREENING_PROTOCOL.md): same scoring methodology, same ATS logic, comparable verdicts — a 7/10 in consulting means the same rigor as a 7/10 in finance.

---

## What This Skill Does NOT Do

- It does not tell you "here's how to rewrite your CV"
- It does not give you a list of improvements to work on
- It does not soften the verdict with "however, you have some strong points"
- It is not a career coach

Its job is to tell you **whether your CV passes the bar** for a specific role and company type. If it doesn't, you'll know exactly why — the same reasons a real recruiter would silently think and never tell you.

---

## Honest Disclaimers

In the spirit of the project, two things you should know:

- **The ATS simulation is a heuristic.** Claude does not run a real ATS parser. The keyword analysis is rigorous, but if you paste your CV as plain text, layout problems (two-column designs, tables, headers) cannot be detected — upload the original PDF for the most realistic screen.
- **The criteria mirror the market as it is, not as it should be.** Some real-world screening signals (employment gaps, employer prestige, target schools) are blunt and arguably unfair. The skill replicates how recruiters actually filter, because that is what you are up against — it is not an endorsement of those practices.

---

## Contributing

Want to add a new sector module or sharpen an existing one? See [CONTRIBUTING.md](CONTRIBUTING.md) for the structure, the tone standard, and the validation script.

---

## License

[MIT](LICENSE) — use freely, fork freely, deploy in your own Claude environments.

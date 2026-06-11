<p align="center">
  <img src="docs/assets/logo.png" width="220" alt="A pixel-art CV torn in half" />
</p>

<h1 align="center">CV Screener</h1>

<p align="center">
  <strong>the recruiter is not your friend</strong>
</p>

<p align="center">
  A Claude skill that screens your CV against a real job description the way a real recruiter does:<br/>
  in 6 seconds, with a binary verdict, and without sparing your feelings.<br/>
  <em>Not for the faint of heart. And don't take the REJECTED personally — everyone gets rejected.<br/>Here, at least, you find out exactly why.</em>
</p>

<p align="center">
  <a href="https://github.com/LoreJob/screener/actions/workflows/validate.yml"><img src="https://github.com/LoreJob/screener/actions/workflows/validate.yml/badge.svg" alt="Validate"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
  <a href="https://github.com/LoreJob/screener/releases/latest"><img src="https://img.shields.io/github/v/release/LoreJob/screener" alt="Release"></a>
  <a href="https://github.com/LoreJob/screener/stargazers"><img src="https://img.shields.io/github/stars/LoreJob/screener?style=flat&color=yellow" alt="Stars"></a>
</p>

<p align="center">
  <a href="#the-verdict-in-10-seconds">10-Second Demo</a> •
  <a href="#installation">Install</a> •
  <a href="#how-to-use">How to Use</a> •
  <a href="#covered-sectors">Sectors</a> •
  <a href="#privacy">Privacy</a> •
  <a href="examples/">Full Examples</a> •
  <a href="CONTRIBUTING.md">Contributing</a>
</p>

---

## The Verdict in 10 Seconds

<table>
<tr>
<td width="50%">

### ❌ REJECTED

**The JD:** Junior Consultant, strategy boutique. Market sizing, financial modeling, client-ready decks.

**The CV:** 4 years of event coordination. *"Responsible for managing supplier relationships."* Not one number anywhere.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 VERDICT: REJECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 OVERALL CV SCORE   3.0 / 10
 ATS SCORE          2.5 / 10

 1. Zero quantification —
    hard disqualifier in
    consulting.
 2. ✗ market sizing
    ✗ financial modeling
    ✗ benchmarking
```

</td>
<td width="50%">

### ✅ ACCEPTED

**The JD:** Senior Backend Engineer. Python, AWS, microservices, 5+ years.

**The CV:** 6 years of Python at a fintech scale-up. *"Cut p99 latency 40%."* *"Led 4 engineers."* AWS certified.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 VERDICT: ACCEPTED
          FOR INTERVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 OVERALL CV SCORE   8.1 / 10
 ATS SCORE          8.4 / 10

 ✓ Python   ✓ AWS
 ✓ microservices
 Quantified impact across
 every role.
```

</td>
</tr>
</table>

**No "almost there." Either your CV passes the bar for that role, or it doesn't — and you see exactly which keywords, numbers, and signals made the difference.** Full runs in [examples/](examples/).

---

## Philosophy

Real recruiters spend an average of **6–8 seconds** on a CV before deciding to reject it. They don't care about your potential. They care about whether your CV matches the job description and clears the ATS (Applicant Tracking System) filter.

This skill replicates that exact behavior:

- **Screens your CV against a specific job description** the way an ATS would
- **Lists every keyword the ATS looks for** — ✓ in your CV, ~ matched as synonym, ✗ missing
- **Evaluates sector fit** based on industry-specific expectations
- **Gives you a score from 1 to 10**, calibrated to be honest — a 6 is not good
- **Issues a binary verdict**: `ACCEPTED FOR INTERVIEW` or `REJECTED`
- **If rejected, tells you exactly why** — no softening, no "you could improve X"

Works in **English, Italiano, Español, Français, Português, Русский, 中文** — the skill answers in your language.

---

## Installation

### Claude.ai, Claude Desktop, or the mobile app — easiest

1. Download **`cv-screener.zip`** from the [latest release](https://github.com/LoreJob/screener/releases/latest)
2. Attach the zip in a chat with Claude and write: *"Add this skill to my skills"* — Claude installs it for you

Alternatively, upload the zip manually under **Settings → Capabilities → Skills** (requires Pro, Max, Team, or Enterprise).

### Claude Code — as a plugin

```
/plugin marketplace add LoreJob/screener
/plugin install cv-screener@screener
```

### Claude Code — manual

```bash
git clone https://github.com/LoreJob/screener.git
mkdir -p ~/.claude/skills
cp -r screener/skills/cv-screener ~/.claude/skills/
```

To install for a single project instead, copy it to `.claude/skills/` inside the project. Verify with `/skills`.

### Claude API / Agent SDK

Upload the `skills/cv-screener/` folder via the Skills API. See the [Agent Skills documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) for details.

---

## How to Use

1. Type **`screener`** in the chat (or just ask "is my CV good enough for this role?" — in any supported language)
2. Upload or paste your **CV**
3. Upload or paste the **full job description** — a job title alone is not accepted
4. The skill identifies the sector from the JD, loads the matching evaluation module, and delivers the verdict

Every verdict includes the full **ATS keyword scan**: every keyword extracted from the job description, grouped by category, each marked ✓ present / ~ synonym / ✗ missing — so you see exactly which words are filtering you out.

---

## Covered Sectors

| Module | Coverage |
|---|---|
| `consulting` | Strategy & Management Consulting (MBB, Big 4, boutiques) |
| `tech-software` | Software Engineering, Product, Data Science, AI/ML |
| `finance-banking` | Investment Banking, Private Equity, Asset Management |
| `sales-bd` | Sales, Business Development, Account Management, Partnerships |
| `manufacturing` | Operations, Supply Chain, Industrial Engineering |
| `marketing` | Brand, Digital, Growth, Communications |
| `hr-legal` | Human Resources, Legal, Compliance |
| `pharma-biotech` | Pharmaceuticals, Biotech, Medical Devices, Clinical Research |
| `retail-fmcg` | Retail, Consumer Goods, Category Management |
| `energy-utilities` | Oil & Gas, Renewables, Energy Trading, Utilities |

Roles outside these sectors are still screened using the core protocol alone, with a note that sector calibration was not applied.

All modules share the evaluation framework in [SCREENING_PROTOCOL.md](skills/cv-screener/references/SCREENING_PROTOCOL.md): same scoring methodology, same ATS logic, comparable verdicts — a 7/10 in consulting means the same rigor as a 7/10 in finance.

---

## What This Skill Does NOT Do

- It does not tell you "here's how to rewrite your CV"
- It does not give you a list of improvements to work on
- It does not soften the verdict with "however, you have some strong points"
- It does not add a friendly note after the verdict. The verdict is the message
- It is not a career coach

Its job is to tell you **whether your CV passes the bar** for a specific role and company type. If it doesn't, you'll know exactly why — the same reasons a real recruiter would silently think and never tell you.

---

## Privacy

Your CV never leaves your conversation with Claude. The skill is a set of instruction files — it has **no backend, no analytics, no storage**, and sends nothing to the authors or to any third party. Processing happens entirely inside your Claude chat, under [Anthropic's privacy policy](https://www.anthropic.com/legal/privacy).

If you choose to [share an example](examples/README.md) with this repository, anonymize it first: no names, no contacts, no identifying details.

---

## Honest Disclaimers

In the spirit of the project, two things you should know:

- **The ATS simulation is a heuristic.** Claude does not run a real ATS parser. The keyword analysis is rigorous, but if you paste your CV as plain text, layout problems (two-column designs, tables, headers) cannot be detected — upload the original PDF for the most realistic screen.
- **The criteria mirror the market as it is, not as it should be.** Some real-world screening signals (employment gaps, employer prestige, target schools) are blunt and arguably unfair. The skill replicates how recruiters actually filter, because that is what you are up against — it is not an endorsement of those practices.

---

## Contributing

Want to add a new sector module, sharpen an existing one, or [share a screening example](examples/README.md)? See [CONTRIBUTING.md](CONTRIBUTING.md) for the structure, the tone standard, and the validation script.

---

## If It Hurt, It Worked

A real rejection costs you a silent inbox and three weeks of waiting. This one costs you nothing and tells you why. If it saved you from sending that CV one more time — the star is free too. ⭐

---

## License

[MIT](LICENSE) — use freely, fork freely, deploy in your own Claude environments.

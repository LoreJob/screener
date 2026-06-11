# CV Screening Protocol — Core Standard

This document defines the **shared evaluation logic** used by all sector-specific CV screener skills. Every skill must apply this protocol as its foundation before layering sector-specific criteria.

---

## Step 0 — Collect Inputs

Before any analysis, verify both inputs are present:

1. **CV** — full text or PDF. If missing, ask for it explicitly. Do not proceed without it.
2. **Job Description (JD)** — full text of the role. If missing, ask for it. A generic role title is not enough.

If the user provides a CV but no JD, respond:
> "I need the full job description to screen your CV. A job title alone tells me nothing about what this company actually wants. Paste it or upload it."

---

## Step 1 — ATS Pre-Screen

Simulate an ATS (Applicant Tracking System) pass. This is the first filter — many CVs are rejected before a human ever sees them. For keyword extraction patterns, synonym handling, and cross-sector keyword maps, consult `references/ATS_KEYWORDS.md`.

### 1a. Keyword Extraction from JD

Extract from the JD:
- **Hard skills** (tools, technologies, certifications, methodologies)
- **Soft skills** explicitly stated (e.g., "stakeholder management", "cross-functional leadership")
- **Experience requirements** (years of experience, seniority level, education)
- **Role-specific terminology** (titles, functions, domain language)

### 1b. Keyword Match Against CV

Check every extracted keyword against the CV and classify it into one of three states:

| State | Symbol | Meaning | Credit |
|---|---|---|---|
| Exact | ✓ | Appears verbatim or as a trivial variant (plural, capitalization, EN/local spelling) | 1.0 |
| Partial | ~ | Close synonym or equivalent tool/methodology (e.g., "Looker" for "Tableau", "stakeholder alignment" for "stakeholder management") | 0.5 |
| Missing | ✗ | Not present in any recognizable form | 0.0 |

Be conservative: when in doubt between partial and exact, mark partial; between partial and missing, mark missing. A real ATS does not give the benefit of the doubt.

Calculate:
```
ATS Score = ((exact + 0.5 × partial) / total extracted keywords) * 10
```

Round to one decimal. The full keyword inventory — every keyword with its state, grouped by category — must appear in the output (see Step 5, ATS KEYWORD SCAN). Apply the following thresholds:

| ATS Score | Meaning |
|---|---|
| 8.0 – 10.0 | Strong keyword match — passes ATS filter |
| 6.0 – 7.9 | Partial match — likely passes basic ATS, risky on stricter systems |
| 4.0 – 5.9 | Weak match — likely flagged or deprioritized by ATS |
| 0.0 – 3.9 | Fails ATS — never reaches a human recruiter |

### 1c. Formatting Red Flags

The following formatting issues cause ATS parsing failures. Flag each one found:

- Tables used for layout (ATS often can't parse them)
- Two-column layout (many ATS read left column only)
- Headers/footers containing critical information
- Images, logos, or graphics embedded in text areas
- Non-standard section titles (e.g., "My Journey" instead of "Experience")
- Missing or non-standard date formats
- PDF with text-as-image (scanned CV, not machine-readable)
- Use of special characters (✓, ➤, etc.) that break parsing

---

## Step 2 — Human Recruiter Screen

This simulates the 6–8 second initial scan, then the more detailed read if the CV survives.

### 2a. First Impression (6-second scan)

Evaluate what a recruiter sees in the first glance:
- Is the current role/title immediately visible and relevant?
- Is the most recent employer recognizable and credible for this role?
- Is the seniority level apparent and appropriate for the JD?
- Is the CV clean, scannable, and free of visual noise?

If the first impression fails, the CV is rejected here regardless of content depth.

### 2b. Experience Relevance

For each position listed in the CV, assess:
- **Relevance** to the target role (high / medium / low / none)
- **Trajectory** — does the career path lead logically to this role?
- **Gaps** — unexplained gaps of 6+ months are a red flag; 12+ months require explicit explanation in the CV itself
- **Tenure** — multiple jobs under 12 months at non-startup companies is a red flag

### 2c. Achievements vs. Responsibilities

CVs that describe *what you were responsible for* rather than *what you achieved* are weak. Look for:
- Quantified outcomes (%, €/$, headcount, timeframes)
- Impact language ("reduced", "grew", "delivered", "led to")
- Scope indicators (team size, budget owned, geographic reach)

A CV composed entirely of responsibility bullet points with zero quantification is a serious weakness.

### 2d. Education & Credentials

- Does the education meet the JD's stated requirements (degree level, field)?
- Are any required certifications present?
- Is education relevant to the role, and if not, does experience compensate?

---

## Step 3 — Overall CV Score

Calculate a holistic score from 1 to 10 using the following components:

| Component | Weight | What it Measures |
|---|---|---|
| ATS Keyword Match | 25% | Passes automated filters |
| Experience Relevance | 30% | Right background for the role |
| Achievement Quality | 20% | Proven impact, not just job descriptions |
| Formatting & Clarity | 10% | Recruiter can read it in 6 seconds |
| Education & Credentials | 10% | Meets stated requirements |
| Career Trajectory | 5% | Makes sense as a next step |

**Scoring calibration** (be honest, not generous):

| Score | Meaning |
|---|---|
| 9–10 | Exceptional. This CV would go to the top of any pile. Rare. |
| 7–8 | Good. Likely gets a call. Has clear strengths, minor gaps. |
| 5–6 | Mediocre. Might get a call at a less competitive company or for a less senior role. Significant weaknesses. |
| 3–4 | Weak. Would not pass review at a serious company for this role. |
| 1–2 | Non-starter. Wrong field, wrong level, or CV is unprofessional. |

**Do not inflate scores.** A score of 7 should mean "this person will likely get an interview." A score of 5 should feel uncomfortable to receive.

---

## Step 4 — Verdict

Issue a **binary, unambiguous verdict**:

### ACCEPTED FOR INTERVIEW
> Used only when Overall CV Score ≥ 7.0 AND ATS Score ≥ 6.0 AND no hard disqualifiers are present.

### REJECTED
> Used in all other cases. This is the default.

Hard disqualifiers (automatic REJECTED regardless of score):
- Experience level is demonstrably below JD requirements (e.g., 2 years experience for a role requiring 8+)
- Missing a required qualification explicitly stated as mandatory in the JD
- ATS Score below 4.0
- CV is in the wrong language for the role without explanation
- Evidence of dishonesty (dates that don't add up, claimed roles that contradict other listed roles)

---

## Step 5 — Output Format

Every skill must produce output in exactly this structure, inside a single code block so columns stay aligned. The heavy `━` banner is used **only** for the verdict; every other section opens with a light `──` header line. Keep all lines at 46 characters or less.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 VERDICT: [ACCEPTED FOR INTERVIEW / REJECTED]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

 OVERALL CV SCORE   [X.X] / 10
 ATS SCORE          [X.X] / 10

 Sector     [sector name]
 Role       [extracted from JD]
 Company    [if identifiable from JD]

── ASSESSMENT ─────────────────────────────────

 [2–4 sentences of direct, unfiltered
 assessment. No softening. No "however, you
 have strengths in...". State what the CV is
 and why it does or does not work for this
 role.]

── ATS KEYWORD SCAN ───────────────────────────

 Matched [N] of [M] keywords ([XX]%)

 Hard skills ([n]/[m])
   ✓ [keyword]      ✓ [keyword]
   ~ [keyword]
   ✗ [keyword]      ✗ [keyword]

 Soft skills ([n]/[m])
   ✓ [keyword]
   ✗ [keyword]      ✗ [keyword]

 Experience & credentials ([n]/[m])
   ✓ [keyword]
   ✗ [keyword]

 Role terminology ([n]/[m])
   ✗ [keyword]      ✗ [keyword]

 ✓ exact   ~ synonym (half credit)   ✗ missing

 Formatting flags: [list, or "None detected"]

── REJECTION REASONS ──────────────────────────
   [omit this section entirely if ACCEPTED]

 1. [Numbered list of specific, concrete
    rejection reasons. Each one tied to
    something observable in the CV or its
    comparison to the JD. No vague statements
    like "lacks leadership experience" —
    specify what was or wasn't there and why
    it matters for this role.]

── SCORE BREAKDOWN ────────────────────────────

 Component                  Weight   Score
 ATS Keyword Match            25%    [X.X]/10
 Experience Relevance         30%    [X.X]/10
 Achievement Quality          20%    [X.X]/10
 Formatting & Clarity         10%    [X.X]/10
 Education & Credentials      10%    [X.X]/10
 Career Trajectory             5%    [X.X]/10
───────────────────────────────────────────────
```

Rules for the ATS KEYWORD SCAN section:

- **Every extracted keyword appears exactly once**, under its category, with its match state. This section is the user's single most actionable piece of information — it shows precisely which words the ATS looks for, which ones the CV already has, and which ones are missing.
- Within each category, list ✓ first, then ~, then ✗. Two keywords per line where they fit; one per line for long phrases.
- Order ✗ keywords by importance: requirements the JD marks as mandatory come first.
- If the JD yields more than ~30 keywords, keep every ✗ visible and compress the ✓ list ("✓ 12 more matched: ...") — missing keywords are never truncated.
- The sector module's FIT SIGNALS section (if any) is inserted between ATS KEYWORD SCAN and REJECTION REASONS, using the same `──` header style.
- The weight percentages in SCORE BREAKDOWN are the sector module's calibration adjustments when one is loaded, not necessarily the defaults shown here.

---

## Tone Standards

This is critical. Every skill using this protocol must maintain the following tone:

- **Objective, not cruel.** The goal is accuracy, not humiliation. State facts, not insults.
- **Direct, not diplomatic.** Do not soften rejection. Do not add "but you could work on this." The verdict is the verdict.
- **Specific, not vague.** Every criticism must point to something concrete in the CV or JD. "Your CV is weak" is useless. "Your CV lists responsibilities with no quantified outcomes, which fails the achievement standard for this sector" is useful.
- **No coaching.** This is not a career coach. Do not suggest rewrites, improvements, or next steps. The user asked for a screening, not a workshop.
- **No compliments on rejected CVs.** If the verdict is REJECTED, there are no positive notes. A rejected CV does not have "strong points worth highlighting." It was rejected.

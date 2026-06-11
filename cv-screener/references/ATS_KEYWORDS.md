# ATS Keyword Reference — Cross-Sector Guide

This reference supports the ATS analysis step (Step 1) of the screening protocol. It documents common ATS keyword patterns, extraction logic, and synonym handling across sectors.

---

## How ATS Systems Work (and Why It Matters)

Modern ATS platforms (Workday, Taleo, Greenhouse, Lever, SAP SuccessFactors) use a combination of:

1. **Exact keyword match** — the literal string appears in the CV
2. **Semantic match** — synonym or closely related term (varies by platform sophistication)
3. **Proximity scoring** — keyword appears near other related terms (advanced ATS)
4. **Section weighting** — keywords in "Experience" section weigh more than in "Skills"

When screening, prioritize **exact match** as the conservative baseline. Flag close synonyms as partial matches.

---

## Keyword Categories to Extract from Any JD

For every job description, extract keywords across these universal categories:

### Category 1: Hard Skills
Technical competencies, tools, software, methodologies. Examples:
- "Python", "SQL", "Excel", "Power BI", "Tableau"
- "Lean Six Sigma", "Agile", "Scrum", "PRINCE2", "PMP"
- "IFRS", "US GAAP", "Sarbanes-Oxley"
- "Salesforce", "SAP", "Oracle", "Workday"

### Category 2: Soft Skills (Explicitly Stated)
Only flag soft skills that appear **verbatim** in the JD. Do not infer. Examples:
- "stakeholder management", "executive communication"
- "cross-functional collaboration", "team leadership"
- "project management", "change management"

### Category 3: Experience Requirements
Translate these into binary checks:
- Minimum years of experience → does the CV show it?
- Seniority level ("senior", "director", "VP") → does the CV title match?
- Industry experience ("financial services", "FMCG") → does the CV show it?

### Category 4: Education Requirements
Flag if stated as required vs. preferred:
- Degree type ("MBA", "Master's", "Bachelor's")
- Field ("Computer Science", "Engineering", "Finance")
- Certifications ("CFA", "CPA", "AWS Certified")

### Category 5: Role-Specific Language
Industry/role terminology that ATS systems often use for fine-grained filtering:
- These vary by sector — see individual skill files for sector-specific lists

---

## Synonym Handling

When a keyword is not present verbatim but a recognized synonym is, count as **0.5 match** (partial credit in ATS score calculation).

Common synonym pairs:

| JD Term | Acceptable Synonym |
|---|---|
| "P&L ownership" | "profit and loss", "P&L responsibility" |
| "team leadership" | "people management", "managing a team" |
| "data analysis" | "data analytics", "analytical skills" |
| "project management" | "programme management", "project delivery" |
| "client-facing" | "client management", "customer-facing" |
| "go-to-market" | "GTM", "market launch" |
| "business development" | "BD", "new business", "sales development" |
| "machine learning" | "ML", "predictive modeling" |
| "continuous improvement" | "CI", "process improvement", "Kaizen" |

---

## ATS Score Penalty Table

Apply these penalties after calculating the base ATS score:

| Issue | Penalty |
|---|---|
| Two-column layout | –1.0 point |
| Tables used for layout | –0.5 point |
| Header/footer content | –0.5 point |
| Embedded images or graphics | –0.5 point |
| Non-standard section titles | –0.3 point per title |
| Missing dates on any position | –0.5 point |
| Special Unicode characters | –0.3 point |
| Scanned/image-based PDF | –3.0 points (catastrophic — ATS cannot read it at all) |

Minimum ATS score after penalties: 0.0. Do not go negative.

---

## High-Value Keywords by Function (Cross-Sector)

These keywords appear across sectors and are universally recognized by ATS systems:

**Leadership & Management:**
P&L, budget ownership, headcount, team of [N], direct reports, hiring, performance management, organizational design, restructuring

**Strategy & Analysis:**
strategic planning, market analysis, competitive analysis, business case, ROI, KPIs, OKRs, roadmap, go-to-market, due diligence

**Operations & Delivery:**
end-to-end, implementation, rollout, process optimization, automation, SLA, operational efficiency, cost reduction, scalability

**Finance & Commercial:**
revenue growth, EBITDA, margin improvement, forecasting, financial modeling, pricing, contract negotiation, vendor management

**Data & Technology:**
data-driven, analytics, dashboard, reporting, CRM, ERP, cloud, digital transformation, API, integration

**Communication & Stakeholders:**
C-suite, board-level, executive stakeholders, cross-functional, global teams, multi-market, client relationship, external partners

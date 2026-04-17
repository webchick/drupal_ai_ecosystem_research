# zivtech-a11y-meta-skills — Tier 2 LITE Analysis

**Tier**: 2 LITE (Q1-4, 7, 8, 11, 13 only)
**Repo**: https://github.com/zivtech/a11y-meta-skills
**Last commit**: 2026-04-13 (feat: add known anti-patterns from Zenyth kickbacks)
**License**: Apache-2.0
**SKILL.md count**: 4
**Analyzer note**: Landscape page flagged this as "the ONLY accessibility skills in the ecosystem" — unique gap-filler.

---

## Q1. Problem solved

Accessibility failures that **pass automated checks but fail real assistive-technology users**: wrong interaction patterns, focus that technically moves but makes no sense to keyboard users, loading/error/success states that are visible but unannounced, and semantics that satisfy axe-core while confusing screen readers. The bundle fills the upstream design gap that axe/Pa11y/Lighthouse cannot reach — it treats accessibility as a **design activity**, not a compliance sweep. Positioning statement from the README: "Most accessibility failures are not just missing attributes. They come from design decisions."

Scope covers the **full a11y lifecycle**: plan → critique plan → perspective audit → revise → implement → test → critique implementation → perspective audit → fix → re-test.

## Q2. Primary artefact type

**4 SKILL.md files** (Claude Code skill-bundle format), plus 2 companion `.claude/agents/*.md` standalone-agent prompts, plus `templates/` with base protocols, plus `evals/suites/` fixture harness. Supporting artefacts: `docs/EXTERNAL-SKILLS-INVENTORY.md` (landscape scan of 13 external a11y skills) and `docs/PERSPECTIVE-AGENTS-PLAN.md` (v2.1 architecture plan, 3-critic reviewed). 152 yaml + 126 md files. No PHP, no Drupal module code.

## Q3. Distribution model

**npm-based skill bundle** — not Composer, not a Drupal module.

```
npx skills add zivtech/a11y-meta-skills
```

Manual fallback: `git clone && cp -r a11y-meta-skills/.claude/skills/* ~/.claude/skills/`. No `composer.json`, no `package.json`, no `skills.yaml` manifest. Installation places skills at `~/.claude/skills/` (user-global) or project-root `.claude/skills/`. Standalone repo extracted from `zivtech-meta-skills` (sibling Drupal-focused bundle); CLAUDE.md explicitly warns to "sync intentionally rather than drift silently" from the canonical upstream.

## Q4. Standards conformance + skill-unit convention (independently detected)

**YAML front-matter** on each SKILL.md — conforms to Claude Code skill convention with these fields:

```yaml
---
name: a11y-planner
description: "Use when..."
license: Apache-2.0
compatibility: Designed for Claude Code
metadata:
  author: zivtech
  version: "1.1.0"
---
```

`perspective-audit` additionally declares `disallowedTools: [Write, Edit, NotebookEdit]` — read-only enforcement for audit role.

**Independent detection of skill-unit convention**:
- Location: `.claude/skills/<name>/SKILL.md` (NOT root-level `skills/`)
- One directory per skill; no nesting; optional `references/` subdir for supporting content (e.g., `perspective-audit/references/perspectives.md`, `arrm-perspective-mapping.md`, `external-skills-manifest.yaml`)
- SKILL.md structure: front-matter → H1 title → **JTBD block** (Primary Job / Secondary Jobs / Job Layers / Is For / Is NOT For / Paired With / Resolution Paths / When to Escalate) → Purpose → Use_When → numbered Steps / Phases
- Name convention: kebab-case with **no gerund prefix** (`a11y-planner`, `a11y-critic`, `a11y-test`, `perspective-audit`). Names are noun-phrase or role-based, matching the Claude Code convention, **not** the gerund-prefix style chosen by ai_best_practices.

Standards referenced inside the skills: **WCAG 2.2 AA**, **WAI-ARIA Authoring Practices Guide (APG)**, **W3C WAI ARRM** (Accessibility Roles & Responsibilities Mapping), **CivicActions personas**. `a11y-test` explicitly names WCAG 2.2 new criteria: 2.4.11, 2.4.13, 2.5.7, 2.5.8, 3.3.7, 3.3.8.

## Q7. Coverage — 4 skills enumerated + universality check

| # | Skill | File path | Topic |
|---|-------|-----------|-------|
| 1 | `a11y-planner` | `/home/pointblank/research/repos/zivtech-a11y-meta-skills/.claude/skills/a11y-planner/SKILL.md` | Pre-implementation design (WCAG 2.2 + WAI-ARIA APG patterns, 9-phase protocol: scope → semantic structure → interaction pattern → focus → state comms → visual a11y → content a11y → testing strategy → tasks) |
| 2 | `a11y-critic` | `/home/pointblank/research/repos/zivtech-a11y-meta-skills/.claude/skills/a11y-critic/SKILL.md` | Design critique at 2 checkpoints (post-plan, post-test); 8-phase review protocol with evidence-backed severity + mandatory multi-perspective pass (screen-reader / keyboard-only / low-vision / cognitive) |
| 3 | `a11y-test` | `/home/pointblank/research/repos/zivtech-a11y-meta-skills/.claude/skills/a11y-test/SKILL.md` | Measurement layer — Playwright **real keyboard events** (not synthetic dispatchEvent), axe-core via Playwright injection, eslint-plugin-jsx-a11y, visual regression (Playwright screenshots + optional BackstopJS), WCAG 2.2 compliance. Includes routing table: codified CI → `npx playwright test`; interactive reconnaissance → `agent-browser` CLI (snapshot+ref pattern `@e1`/`@e2`, CDP direct); Playwright MCP explicitly banned (`browser_press_key` silently dropped) |
| 4 | `perspective-audit` | `/home/pointblank/research/repos/zivtech-a11y-meta-skills/.claude/skills/perspective-audit/SKILL.md` | Layer-2 escalation audit for 7 perspectives (Magnification & Reflow, Environmental Contrast, Vestibular & Motion, Auditory Access, Keyboard & Motor, Screen Reader & Semantic, Cognitive & Neurodivergent). Fires only when planner/critic flags MEDIUM/HIGH; LOW rated perspectives are NOT audited (evidence-over-assertion gating). Grounded in CivicActions personas + W3C WAI ARRM role routing. Read-only (`disallowedTools: Write, Edit, NotebookEdit`) |

**Universality check — is this Drupal-specific or tool-agnostic?**

**Tool-agnostic.** Independent detection:
- Only **15 Drupal/drupal mentions across the entire repo**, concentrated in 3 files: `templates/planner-base-protocol.md` (13), `INDEX.md` (1), and `.claude/skills/a11y-test/SKILL.md` (1). The a11y-planner and a11y-critic SKILL.md files contain **zero** Drupal references.
- Test stack is **React/Vue/JSX + Playwright** (eslint-plugin-jsx-a11y explicitly named), not Drupal Behat or Nightwatch.
- No Drupal hook patterns, no Drush, no Twig guidance, no render-array a11y notes. Framework-neutral WCAG/ARIA design surface.
- Templates directory includes `critic-base-protocol.md` and `planner-base-protocol.md` that appear reusable across any framework.

**"Only a11y skills in the ecosystem" claim — verified.** The repo's own `docs/EXTERNAL-SKILLS-INVENTORY.md` scans 13 external a11y skills across skills.sh (90,352+ skills indexed), tessl.io, and GitHub curated lists, and explicitly concludes: "No external skill implements a planner-critic pair. All are either auditors (scan + report), guideline guardrails (coding standards), or single-criterion analyzers. Our planner-critic architecture is unique in the ecosystem." Within the Drupal corpus surveyed in Phase 1/2, no other repo addresses a11y at all — zivtech-a11y-meta-skills is the ecosystem's sole a11y contribution.

## Q8. Quality signals

**Strong**:
- Active development: last commit **2026-04-13** with the meaningful subject `feat: add known anti-patterns from 2026-04-10 Zenyth kickbacks` — real-world feedback loop from Zenyth (a11y consultancy) integrated within 3 days.
- **Architecture v2.1, 3-critic reviewed** (per `docs/PERSPECTIVE-AGENTS-PLAN.md` reference in CLAUDE.md) — meta-critique applied to own design.
- `evals/suites/` present with per-skill sub-suites (a11y-critic / a11y-planner / perspectives) and a harness — evidence of **measurement discipline**, not just prose.
- **CivicActions persona + W3C WAI ARRM grounding** — skills cite real disability-research artefacts, not AI-improvised guidance.
- **Severity calibration is explicit**: CRITICAL / MAJOR / MINOR / ENHANCEMENT with concrete thresholds (e.g., "contrast below 3:1 = MAJOR"; "AAA criterion = ENHANCEMENT, do not escalate").
- Escalation gating prevents checklist-bloat: `perspective-audit` only fires for MEDIUM/HIGH flagged perspectives; LOW is explicitly skipped ("Evidence over assertion — this skill only fires where the risk signal exists").
- **Explicit non-goals** in the bundle — clear scope boundaries.
- Browser-tooling routing table is battle-tested: CDP `Input.dispatchKeyEvent` verified end-to-end on both vanilla-JS disclosure and React state-driven modal; Playwright MCP explicitly blacklisted after failure detection.
- JTBD section on every skill — structured Jobs-to-be-Done framing with Primary Job, Secondary Jobs, Is For / Is NOT For, Paired With, Resolution Paths, When to Escalate.
- Companion standalone agents (`.claude/agents/a11y-planner.md`, `.claude/agents/a11y-critic.md`) for both skill-mode and agent-mode invocation.
- **Landscape scan documented**: `EXTERNAL-SKILLS-INVENTORY.md` catalogs 13 competitors and adoption recommendations.
- License: Apache-2.0 (permissive, compatible with absorption).
- `.claudeignore` present.
- Visual explainer site: https://zivtech.github.io/a11y-meta-skills/ (GitHub Pages), plus `docs/index.html`.
- Descriptions are second-person imperative and specific.

**Gaps**:
- No `composer.json`, no `package.json` — npm install flow depends on an external `skills add` CLI not versioned in-repo.
- No `drupal-version` metadata field; no `status` field. Metadata block only carries `author` + `version`.
- Name convention is **not gerund-prefix**.
- Skills live at `.claude/skills/` not project-root `skills/`.
- 4 skills × 152 YAML files suggests heavy reference material — may bloat token footprint on load.

## Q11. Compatibility with ai_best_practices LOCKED decisions

| Decision | Compatibility | Notes |
|---|---|---|
| **Gerund-prefix naming** | mismatch | Skills are `a11y-planner`, `a11y-critic`, `a11y-test`, `perspective-audit` — noun/role phrases, no gerunds. Would require renames: `planning-accessibility`, `critiquing-accessibility`, `testing-accessibility`, `auditing-perspectives` (or similar). Mechanical rename; no behavioural change. |
| **`skills/` at project root** | mismatch | Lives at `.claude/skills/*/SKILL.md`. Move is a directory shuffle; zero content changes. CLAUDE.md notes "Skills and agents live at root `.claude/` for Claude Code discovery" — moving to root `skills/` breaks Claude Code auto-discovery unless a symlink or dual-location strategy is adopted. |
| **Minimal metadata (`drupal-version` + `status`)** | mismatch + trivial fix | Currently `metadata.author` + `metadata.version` only. Adding `drupal-version: universal` and `status: stable` is a 2-line YAML patch per SKILL.md. |
| **Composer-installable** | mismatch | No `composer.json`. Install is npm-based (`npx skills add`). Wrapping in a Composer package is non-trivial for pure-prompt content but possible. |
| **Universal Drupal guidance** | aligned by default | Content is already framework-neutral (WCAG/ARIA/Playwright — no version-coupled Drupal code). Universal guidance is the **natural fit**; the 14 Drupal mentions in `templates/planner-base-protocol.md` + `a11y-test` can be kept as universal-referenced or generalised in <30 min of editing. |

**Net**: all 4 mismatches are **mechanical, cosmetic, or metadata-level**. Zero redesign required. Gerund rename + path move + 2-line metadata patch + Composer wrapper = estimated 2-4 hours to fully conform.

## Q13. Verdict — gap-filler justification

**ABSORB (unconditional).** The gap-filler status makes this the **strongest** absorb candidate, not a borderline one. Evidence:

1. **Exclusive coverage** — this is the only a11y skillset surveyed in the entire Drupal ecosystem and, per the repo's own 13-skill external landscape scan, the only **planner-critic-tester-auditor quartet** in the wider Claude Code ecosystem. Rejecting it means shipping an a11y-shaped hole that cannot be backfilled from another survey source.

2. **Tool-agnostic content aligns naturally with universal Drupal guidance** — a locked ai_best_practices decision. WCAG 2.2 + WAI-ARIA APG are version-invariant across Drupal 9/10/11. No drupal-version gating needed.

3. **Mechanical conformance cost is trivial** (gerund rename, path move, metadata patch, optional Composer wrapper). No content rewrite, no behaviour change, no architectural refactor.

4. **Quality signals are strong on every axis**: active maintenance (4 days old at analysis time), eval harness, severity calibration, escalation gating, battle-tested browser tooling routing, permissive Apache-2.0 license, companion agents, external landscape scan documented, consultancy-feedback loop evident (Zenyth kickbacks).

5. **Architectural match** with sibling `drupal-meta-skills` (planner → critic pattern) — aligns with ecosystem convention already present in ai_best_practices corpus. This is not a foreign grafting; it's the **same author's** established pattern extended to a new domain.

6. **Optional-load pattern is intrinsic** — `perspective-audit` is escalation-gated (LOW → skip). Absorbers get a 7-perspective deep-audit library that only loads when planner/critic explicitly flags risk, avoiding token bloat.

7. **Risk of rejection is asymmetric**: absorbing costs ~2-4 hours of mechanical conformance work; rejecting costs permanent a11y blind-spot in the synthesis. For a Drupal AI best-practices corpus aimed at production sites, shipping without a11y coverage fails the WCAG 2.2 AA legal/regulatory baseline most clients need.

**Recommended absorb actions**:
- Rename skills to gerund form (`planning-accessibility`, `critiquing-accessibility`, `testing-accessibility`, `auditing-accessibility-perspectives`).
- Move to `skills/` at project root; add Claude Code discovery shim if needed.
- Add `drupal-version: universal`, `status: stable` metadata.
- Wrap in Composer package with `type: drupal-custom-skill-bundle` (or equivalent absorber convention).
- Preserve `templates/` base protocols, `evals/suites/` harness, and `docs/EXTERNAL-SKILLS-INVENTORY.md` (the landscape scan is reusable intelligence for the synthesis phase).
- Retain Apache-2.0 attribution to zivtech and link upstream canonical source (`zivtech-meta-skills`).

# zivtech-a11y-meta-skills — Structural Index

**Source URL**: https://github.com/zivtech/a11y-meta-skills
**Clone URL used**: https://github.com/zivtech/a11y-meta-skills
**Last commit**: 2026-04-13 17:39:12 -0400
**Last commit subject**: feat: add known anti-patterns from 2026-04-10 Zenyth kickbacks
**License**: LICENSE (present)
**Default branch**: refs/heads/main

## File type counts

```
    152 yaml
    126 md
      2 py
      1 yml
      1 /LICENSE
      1 html
      1 gitignore
      1 claudeignore
```

## Presence of key files/dirs

- CLAUDE.md: ✓ present
- AGENTS.md: ✓ present
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✓ present
- .claude/skills/ : ✓ present
- agents/ : ✗ absent (note: `.claude/agents/` is present)
- commands/ : ✗ absent
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✓ present
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✓ present

## SKILL.md count

Number of SKILL.md files (case-sensitive): **4**

Lowercase `skill.md` count: 0 (none — not flagged)

Paths:
- `./.claude/skills/perspective-audit/SKILL.md`
- `./.claude/skills/a11y-critic/SKILL.md`
- `./.claude/skills/a11y-test/SKILL.md`
- `./.claude/skills/a11y-planner/SKILL.md`

## File tree (depth 3)

```
.
./AGENTS.md
./.claude
./.claude/agents
./.claude/agents/a11y-critic.md
./.claude/agents/a11y-planner.md
./.claudeignore
./CLAUDE.md
./.claude/skills
./.claude/skills/a11y-critic
./.claude/skills/a11y-planner
./.claude/skills/a11y-test
./.claude/skills/perspective-audit
./CONTRIBUTING.md
./docs
./docs/a11y-critic
./docs/a11y-critic/AGENTS.md
./docs/a11y-critic/CLAUDE.md
./docs/a11y-planner
./docs/a11y-planner/AGENTS.md
./docs/a11y-planner/CLAUDE.md
./docs/EXTERNAL-SKILLS-INVENTORY.md
./docs/index.html
./docs/PERSPECTIVE-AGENTS-PLAN.md
./evals
./evals/harness
./evals/harness/README.md
./evals/suites
./evals/suites/a11y-critic
./evals/suites/a11y-planner
./evals/suites/perspectives
./LICENSE
./README.md
./templates
./templates/critic-base-protocol.md
./templates/planner-base-protocol.md
```

## README first 200 lines

Source: README.md

```
# a11y-meta-skills

Accessibility skill bundle for [Claude Code](https://claude.ai/code) — plan, test, review, and audit from real perspectives.

```bash
npx skills add zivtech/a11y-meta-skills
```

**[Visual Explainer](https://zivtech.github.io/a11y-meta-skills/)**

This bundle packages four companion skills that cover the full accessibility development lifecycle:

- `a11y-planner`: designs accessible implementations before coding (WCAG 2.2, WAI-ARIA APG patterns)
- `a11y-critic`: reviews plans before implementation AND implementations after testing
- `a11y-test`: runs real Playwright keyboard tests, axe-core scans, static analysis, and visual regression
- `perspective-audit`: deep review from 7 disability and situational access perspectives, escalated by the planner or critic when specific perspectives reach MEDIUM or HIGH alarm levels

## Why this bundle exists

Most accessibility failures are not just missing attributes. They come from design decisions:

- the wrong interaction pattern chosen for the job
- focus that technically moves but makes no sense to keyboard users
- loading, error, and success states that are visible but not announced
- semantics that pass automated checks while still confusing screen readers

This repo combines four skills that cover the full lifecycle:

1. **Plan first** so semantic structure, keyboard behavior, APG pattern mapping, and testing strategy are explicit before coding.
2. **Critique the plan** so gaps (missing focus traps, incomplete state communication) are caught before any code is written.
3. **Review after testing** so passing automated checks do not hide broken accessibility design.
4. **Audit from real perspectives** so the planner and critic can escalate specific disability or situational access concerns for deep review by perspective agents grounded in CivicActions personas and the W3C WAI ARRM framework.

## What’s in the bundle

### `a11y-planner`

`a11y-planner` is the pre-implementation design surface. It produces plans for:

- semantic HTML structure and landmark strategy
- APG pattern choice for interactive components
- keyboard behavior and focus management
- state communication for assistive technology
- visual accessibility concerns like contrast, motion, and resize behavior
- testing strategy for automated and manual checks

The planner uses a 9-phase protocol:

1. Scope and context
2. Semantic structure plan
3. Interaction pattern plan
4. Focus management
5. State communication
6. Visual accessibility
7. Content accessibility
8. Testing strategy
9. Implementation tasks

### `a11y-critic`

`a11y-critic` reviews accessibility design decisions at two points: **after planning** (to catch gaps before code is written) and **after testing** (to verify the implementation). It looks for:

- semantic mismatches between UI intent and HTML structure
- incomplete or incorrect ARIA pattern implementations
- broken focus traps, restoration, or tab order
- missing live regions or state announcements
- low-vision and cognitive accessibility friction
- gaps that pass axe-core but still fail real users

The critic uses an 8-phase review protocol with evidence-backed severity and a mandatory multi-perspective pass:

- screen reader user
- keyboard-only user
- low-vision user
- cognitive accessibility lens

### `a11y-test`

`a11y-test` is the measurement layer. It runs real tests and produces evidence that feeds into the critic's review:

- Playwright keyboard interaction tests (Tab, Enter, Escape, arrow keys — real key presses, not attribute checks)
- axe-core scanning via Playwright injection for automated WCAG violation detection
- eslint-plugin-jsx-a11y static analysis for React/Vue/JSX projects
- Visual regression testing with Playwright screenshots and optional BackstopJS
- WCAG 2.2 compliance checks including new criteria (2.4.11, 2.4.13, 2.5.7, 2.5.8, 3.3.7, 3.3.8)
- Dynamic test prioritization based on automated scan findings

### `perspective-audit`

`perspective-audit` provides deep accessibility review from 7 disability and situational access perspectives. It is activated by escalation — when the planner or critic flags one or more perspectives at MEDIUM or HIGH alarm level, those perspectives get a focused deep review.

The 7 perspectives:

- **Magnification & Reflow** — zoom users, reflow at 320px, touch target sizing
- **Environmental Contrast** — outdoor use, low-light, color vision deficiency
- **Vestibular & Motion** — motion sensitivity, parallax, auto-playing animation
- **Auditory Access** — deaf/hard-of-hearing, captions, visual alternatives to audio
- **Keyboard & Motor** — switch users, voice control, limited dexterity, one-handed use
- **Screen Reader & Semantic** — NVDA/JAWS/VoiceOver users, semantic structure, live regions
- **Cognitive & Neurodivergent** — reading level, information density, consistent navigation

Each perspective uses a Jobs-to-be-Done checklist derived from CivicActions accessibility personas with ARRM role-responsibility mapping for team assignment.

## Lifecycle

```
plan → critique plan → [perspective audit] → revise → implement → test → critique implementation → [perspective audit] → fix → re-test
```

1. Run `/a11y-planner` to design the feature before implementation.
2. Run `/a11y-critic` on the plan to catch gaps before coding.
3. If the critic escalates perspectives at MEDIUM/HIGH, run `/perspective-audit` for deep review.
4. Revise the plan based on critic and audit findings.
5. Build the feature.
6. Run `/a11y-test` (Playwright keyboard tests, axe-core scans, visual regression).
7. Run `/a11y-critic` on the implementation after tests pass.
8. If the critic escalates perspectives, run `/perspective-audit` again.
9. Fix findings, re-test.

## Commands

- `/a11y-planner` — design accessibility before coding
- `/a11y-critic` — review plans or implementations
- `/a11y-test` — run keyboard, axe-core, and visual regression tests
- `/perspective-audit` — deep review from escalated disability/situational access perspectives

## Install

```bash
npx skills add zivtech/a11y-meta-skills
```

Manual install:

```bash
git clone https://github.com/zivtech/a11y-meta-skills.git
cp -r a11y-meta-skills/.claude/skills/* ~/.claude/skills/
cp drupal-meta-skills/.claude/agents/*.md ~/.claude/agents/
```

## Repository Layout

```text
.claude/
  agents/                              # Standalone agent prompts
  skills/
    a11y-critic/
      SKILL.md                         # Skill definition
      references/
        external-skills-manifest.yaml  # External skill references
    a11y-planner/
      SKILL.md
      references/
        external-skills-manifest.yaml
    a11y-test/
      SKILL.md
    perspective-audit/
      SKILL.md                         # Escalation-based perspective auditor
      references/
        perspectives.md                # 7 JTBD checklists (CivicActions personas)
        arrm-perspective-mapping.md    # W3C WAI ARRM role routing
docs/
  EXTERNAL-SKILLS-INVENTORY.md         # Landscape scan of 13 external a11y skills
  PERSPECTIVE-AGENTS-PLAN.md           # Architecture plan (v2.1, 3-critic reviewed)
  a11y-planner/
  a11y-critic/
templates/
evals/
  suites/
  harness/
```

Skills and agents live at root `.claude/` for Claude Code discovery. Per-skill documentation lives under `docs/`.

## Testing & Contributing
```

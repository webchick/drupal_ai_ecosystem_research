# zivtech-drupal-critic — Phase 2 LITE Analysis

**Tier**: 2 LITE
**Source**: https://github.com/zivtech/drupal-critic
**Last commit**: 2026-03-27 (repo archived — consolidated into `zivtech/drupal-meta-skills`)
**License**: present (LICENSE file)
**Analyst scope**: Q1, Q2, Q3, Q4, Q7, Q8, Q11, Q13

---

## Q1 — Problem Solved

Generic code reviewers miss Drupal-specific failure modes: cache tags that don't invalidate, config exports that break on deploy, contrib modules reimplemented as custom code, non-idempotent update hooks, migrations that can't replay, editorial workflows that create friction. drupal-critic layers a **Drupal-aware harsh-review protocol** on top of the generic `harsh-critic` engine, adding:

- A 9-dimension Drupal rubric (security, architecture, open-source, site builder, content editor, ops, caching, testing, confidence)
- Context-driven audience activation (3 always-on + 3 conditional perspectives)
- A **Realist Check** with a Drupal-specific **Security Exploitability Gate** that refuses to label admin-only surfaces as CRITICAL (admins already own the site)
- Evidence-mandatory findings (file:line) with pre-commitment predictions + mandatory self-audit

It is a **review orchestrator**, not a skill library — it coordinates 24 upstream specialist skills by reference rather than vendoring content.

## Q2 — Primary Artefact Type

**Claude Code Skill + companion Agent** (two artefacts, one behaviour):

1. **Skill** — `.claude/skills/drupal-critic/SKILL.md` — invoked via `/drupal-critic`. YAML frontmatter has only `name` + `description` (Anthropic canonical schema).
2. **Agent** — `.claude/agents/drupal-critic.md` — model `claude-opus-4-6`, frontmatter declares `disallowedTools: Write, Edit` (read-only reviewer enforcement).

The critic hypothesis "code-review agent" is **confirmed in dual form**: the skill is the protocol definition; the agent is the read-only executor that delegates to the skill. Supporting references (`references/*.md`, `external-skills-manifest.yaml`) are non-invocable knowledge files loaded by the skill.

## Q3 — Distribution Model

**Git-clone only**, no package manager:

- No `composer.json`, no `package.json`, no `skills.yaml` registry
- No install script or Makefile
- README directs users to clone into `.claude/` or (preferred, newer) to consume via the **consolidated** `zivtech/drupal-meta-skills` repo
- CI (`.github/workflows/validate.yml`) runs `verify_no_copied_skills.py` + `refresh_external_skills.py --check` on push/PR
- External skills are **not vendored** — they are listed in `external-skills-manifest.yaml` with pinned 40-char SHAs, `skills_url`, `repo_url`, `categories`, `audiences_supported`, `priority`, `status`
- Supply-chain posture: `TRUSTED_OWNERS` allowlist, SHA-256 `content_hash` per external skill, audit log at `research/drupal-skills/reports/refresh-audit.log`, prompt-injection scan on refresh (10 patterns)

Distribution is "check it in next to your other `.claude/` assets, pin the upstream manifest, refresh via script."

## Q4 — Standards Conformance + Skill-Unit Convention

**SKILL.md frontmatter** — YAML, Anthropic canonical two-field form:

```yaml
---
name: drupal-critic
description: Drupal-specific harsh review orchestration...
---
```

No `drupal-version`, no `status`, no custom metadata. Conforms to the vanilla Claude Code skill spec.

**Independently-detected skill-unit convention** (read from this repo, not provided by caller):

- Unit = **one directory per skill** at `.claude/skills/<kebab-case-name>/`
- Required file: `SKILL.md` with YAML frontmatter `{name, description}`
- Optional sibling directory: `references/` — plain `.md` + `.yaml` knowledge files the skill body links to with relative markdown links
- Optional sibling directory: `agents/` — per-platform interface metadata (here: `openai.yaml`)
- The **companion agent** (`.claude/agents/<name>.md`) sits at the repo's top-level `.claude/agents/`, **not** inside the skill directory — skills and agents are separate peer concepts
- **Naming**: kebab-case, **noun-phrase-prefix** (`drupal-critic`, `drupal-update`, `drupal-cache-tags`) — NOT gerund-prefixed
- Skill IDs in the manifest mirror the directory name
- File references inside SKILL.md use **relative markdown links** (`[rubric](references/drupal-review-rubric.md)`), enabling both human-readable navigation and runtime file loading

## Q7 — Coverage (Drupal topics + file paths)

Directly-authored Drupal coverage (the only content this repo "owns" — everything else is referenced):

| Topic | File path |
|---|---|
| Review protocol, 9-dim rubric trigger, Realist Check, Security Exploitability Gate, Drupal privilege model, severity calibration | `.claude/skills/drupal-critic/SKILL.md` |
| Read-only critic agent prompt with full Realist Check, severity scale, 3 calibration examples (downgrade, upgrade, holds) | `.claude/agents/drupal-critic.md` |
| 9-dimension Drupal rubric checklist | `.claude/skills/drupal-critic/references/drupal-review-rubric.md` |
| Audience activation matrix — which content triggers which perspective | `.claude/skills/drupal-critic/references/audience-activation-matrix.md` |
| Skill routing map with JTBD-based selection, max 2-3 skills per run | `.claude/skills/drupal-critic/references/skill-routing-map.md` |
| External skill manifest — 24 pinned specialists across 6 categories: core-review, security, operations, contrib, cache, canvas, tooling | `.claude/skills/drupal-critic/references/external-skills-manifest.yaml` |
| OpenAI interface metadata | `.claude/skills/drupal-critic/agents/openai.yaml` |
| Supply-chain refresh script with injection scanner | `scripts/refresh_external_skills.py` |
| No-copy / allowlist enforcement | `scripts/verify_no_copied_skills.py` |
| Repo-level orientation | `README.md`, `CLAUDE.md`, `CONTRIBUTING.md` |
| Visual explainer | `docs/index.html` |
| CI policy enforcement | `.github/workflows/validate.yml` |

**Topic coverage by reference** (via manifest — not stored locally): cache contexts/tags/max-age/debugging/lazy-builders/dynamic-cache (SparkFabrik), Drupal 10/11 core development + security (madsnorgaard), module updates (bethamil), issue-queue research + contribution workflow (scottfalconer, Kanopi), Drupal Canvas components (7 skills), DDEV + Drush tooling (grasmash, Omedia).

Topics this repo **does not** cover in owned content: entity API, service DI, hook patterns, Twig templating, coding standards, accessibility, testing how-tos, migration how-tos — all delegated to external skills.

## Q8 — Quality Signals

**High-quality signals**:

- Explicit non-goal statement ("does **not** vendor or copy external skill content")
- Evidence requirement baked into output contract (CRITICAL/MAJOR **must** include `file:line`)
- Self-audit + Realist Check are **mandatory** phases, not suggestions
- Security Exploitability Gate is domain-calibrated: refuses to flag admin-only issues as CRITICAL when Drupal admins already have arbitrary-PHP execution — unusually self-aware for a security-review prompt
- Severity calibration provides 3 worked examples (downgrade, upgrade, holds) — shows, doesn't tell
- Supply-chain hygiene is first-class: allowlist, SHA pins, content hashes, injection scan gate, audit log
- JTBD selection for external skills (situation-motivation-outcome) rather than priority-only routing
- Read-only agent tool restriction (`disallowedTools: Write, Edit`) enforces the "reviewer" role at the harness level
- CI validates manifest integrity + no-copy policy on every push
- Visual architecture diagram (Mermaid) + runtime sequence diagram in README
- Clear delineation from companion `harsh-critic` with a comparison table
- Consolidation notice at top of README — repo is honest it has been superseded

**Quality concerns**:

- Repo is **archived/consolidated** into `zivtech/drupal-meta-skills`; direct use is deprecated path
- Scope is narrow: review-only, no authoring guidance
- Heavy dependency on 24 external pinned skills — stale manifest or deleted upstream breaks orchestration (graceful-degrade rule exists: "continue with local rubric fallback and state the limitation")
- No test suite for the skill itself (no eval harness, no regression corpus of reviews)
- Model pin `claude-opus-4-6` is a specific snapshot; will need refresh

## Q11 — Compatibility with ai_best_practices Locked Decisions

| ai_best_practices decision | zivtech-drupal-critic | Compatible? |
|---|---|---|
| Skill naming: **gerund-prefix, verb-in-ing** | Uses noun-phrase names (`drupal-critic`, `drupal-update`, `drupal-cache-tags`) | **No** — conventions diverge |
| Directory: **`skills/` at project root** | `.claude/skills/` (nested under `.claude/`) | **No** — would require relocation |
| Metadata: **minimal — `drupal-version` + `status` only** | Frontmatter has only `{name, description}`; no `drupal-version`; `status` exists **only** in external-skills manifest, not in SKILL.md | **Partial** — simpler than ai_best_practices; would need `drupal-version` added |
| Distribution: **Composer-installable** | Git-clone only, no `composer.json` | **No** — incompatible without adding Composer packaging |
| Scope: **universal Drupal guidance** | Narrow scope: review/critique only, not authoring | **No** — different scope shape |

**Net**: architecturally adjacent but structurally incompatible. Conventions would need translation (rename, relocate, re-metadata, re-package) before direct adoption.

**Valuable patterns worth porting anyway**:

- Two-artefact split (skill = protocol; agent = read-only executor with `disallowedTools`)
- Evidence-mandatory output contract (`file:line` required for CRITICAL/MAJOR)
- Realist Check + Security Exploitability Gate with Drupal privilege-model awareness
- JTBD-based routing for multi-skill selection
- Supply-chain hygiene for external references (allowlist, SHA pins, injection scan, audit log)
- No-copy policy with CI enforcement

## Q13 — Verdict

**REFERENCE + partial ABSORB of patterns.**

Do **not** absorb wholesale:
- Naming convention clashes (noun-prefix vs. gerund-prefix)
- Directory path clashes (`.claude/skills/` vs. `skills/`)
- Distribution clashes (git-clone vs. Composer)
- Scope clashes (review-only vs. universal guidance)
- Upstream is archived; direct dependency is a dead end — use `zivtech/drupal-meta-skills` instead

Do **absorb the patterns** where they align with ai_best_practices goals:

1. **Harsh-review protocol structure** (pre-commitment → verify → multi-perspective → gap → self-audit → Realist Check → verdict) — directly portable as a universal-scope `reviewing-drupal-changes` skill
2. **Evidence contract** (file:line required) — port verbatim into the review skill's output contract
3. **Security Exploitability Gate** with Drupal privilege-model awareness — port verbatim; this is domain knowledge that prevents a common AI-reviewer failure (manufactured admin-surface alarmism)
4. **Read-only agent companion pattern** (`disallowedTools: Write, Edit`) — use for any review-style skills we publish
5. **JTBD routing** — if ai_best_practices ever adds skill selection logic, this is the pattern to copy

**Collaborate?** Low priority — the repo is consolidated into `drupal-meta-skills` and maintained by another org. Attribution-and-port is cleaner than coordinating upstream.

**Ignore?** No — too much high-quality domain thinking to ignore.

**Final**: treat as **high-value reference corpus**; port the protocol, the evidence contract, and the Drupal privilege-model gate into a future ai_best_practices `reviewing-drupal-changes` skill. Cite upstream; do not vendor.

# zivtech-drupal-meta-skills — Tier 2 LITE Analysis

**Tier**: 2 (LITE)
**Source**: https://github.com/zivtech/drupal-meta-skills
**Last commit**: 2026-03-29 — `feat: add Canvas Code Component sub-planner and Experience Builder support`
**License**: GPL-3.0-or-later
**SKILL.md count**: 8
**Scope**: Drupal planner / critic / executor meta-skill bundle

---

## Q1. Problem Solved

Drupal work breaks when **planning, implementation, and review are disconnected**. Entity models are expensive to reverse post-content; cache tags are easy to get "mostly right"; config workflows fail on deploy; teams reimplement contrib as custom code because evaluation happened too late. This bundle closes the loop with a three-stage workflow:

1. **Plan** architecture before implementation (`drupal-planner` + 5 focused sub-planners).
2. **Generate** deterministic config YAML from planner spec (`drupal-config-executor`).
3. **Review** with Drupal-specific rigor (`drupal-critic`).

Canonical workflow:

```
drupal-planner.* -> drupal-config-executor -> drupal-critic
```

This is explicitly the **consolidated successor** to the earlier `zivtech/drupal-planner` and `zivtech/drupal-critic` repos (drupal-critic repo now archived). The consolidation added the executor stage and five dot-notation sub-planners.

---

## Q2. Primary Artefact Type

**Skills + companion subagents + reference rubrics + validation scripts.** Not a code library — prompt-only repository. Each of the 8 skills pairs a `SKILL.md` with a matching agent prompt under `.claude/agents/*.md` (e.g., `drupal-planner.md`, `drupal-critic.md`, `drupal-config-executor.md`). The planner and critic skills ship curated reference files (rubrics, routing maps, manifests) loaded on demand. Supporting assets: three `templates/*-base-protocol.md` master contracts, `research/` ecosystem analysis, and `scripts/` for manifest supply-chain validation.

---

## Q3. Distribution Model

- **Primary**: `npx claude-skills add https://github.com/zivtech/drupal-meta-skills` (agentskills.io-style installer).
- **Manual**: `git clone` then `cp -r .claude/skills/* ~/.claude/skills/` and `cp .claude/agents/*.md ~/.claude/agents/`.
- **Layout**: `.claude/skills/` + `.claude/agents/` at repo root — installable verbatim to `~/.claude/`.
- **No `composer.json`**, **no `package.json`**, **no `skills.yaml`**. Pure prompt-asset repo.
- GPL-3.0-or-later licensed.

---

## Q4. Standards Conformance + Independently Detected Skill Convention

**Convention detected** (independently, not from zivtech-landscape claims):

- Directory: `.claude/skills/<skill-name>/SKILL.md` (Anthropic Agent Skills location; NOT the agentskills.io `skills/` root convention).
- 8/8 SKILL.md files begin with YAML frontmatter containing `name` + `description`. One (`drupal-config-executor`) adds `type: executor` and `model: claude-opus-4-6`. **No `drupal-version` field, no `status` field.**
- Body uses a partially-structured template: `## Overview`, `## Use_When` / `## Use When`, `## Do_Not_Use_When`, `## Companion_Skills`, `## Steps`, `## Tool_Usage`, `## References`, `## Final_Checklist` (planner family); `## Workflow`, `## Required Output Contract`, `## Perspectives`, `## Drupal-Specific Must-Check List`, `## Severity Calibration` (critic).
- **Dot-notation sub-skill naming**: `drupal-planner.content-model`, `drupal-planner.taxonomy`, `drupal-planner.theme`, `drupal-planner.canvas`, `drupal-planner.search`. Novel, repo-specific parent-skill namespacing.
- **Agent pairing**: every skill has a matching `.claude/agents/<name>.md` subagent prompt. The skill acts as dispatch/routing wrapper; the agent carries the heavy protocol.
- **Three base-protocol templates** in `templates/` define shared contracts for planner / critic / executor families — explicit meta-skill architecture.
- **No-copy policy for external skills**: `drupal-critic` references external skills via a pinned-commit manifest (`external-skills-manifest.yaml`) rather than vendoring bodies. `scripts/verify_no_copied_skills.py` enforces it.

**Conformance summary**:
- Anthropic Agent Skills frontmatter (`name` + `description`): YES.
- Gerund-prefix naming: NO — uses noun-phrase naming (`drupal-planner`, `drupal-critic`).
- `skills/` at project root (agentskills.io): NO — uses `.claude/skills/` (Claude Code convention).
- Minimal metadata (`drupal-version` + `status`): NO — absent.
- Composer-installable: NO — no `composer.json`.
- Universal Drupal guidance: PARTIAL — planner / critic content applies across Drupal 7/10/11/CMS; canvas sub-planner is Drupal-CMS / Canvas-specific.

---

## Q7. Coverage — 8 Skills Enumerated

| # | Skill | Path | Topic | Type |
|---|-------|------|-------|------|
| 1 | drupal-planner | `.claude/skills/drupal-planner/SKILL.md` | Full 10-phase Drupal architecture planning (entity, config schema, permissions, cache, migration, theme, tasks) | **Meta-orchestrating** (routes to sub-planners; delegates to `drupal-planner` agent) |
| 2 | drupal-planner.content-model | `.claude/skills/drupal-planner.content-model/SKILL.md` | Entity types, bundles, paragraphs, field architecture, composition, editorial workflows | **Content** (focused sub-planner) |
| 3 | drupal-planner.taxonomy | `.claude/skills/drupal-planner.taxonomy/SKILL.md` | Vocabularies, term hierarchies, Facets, Pathauto, term reference fields | **Content** |
| 4 | drupal-planner.theme | `.claude/skills/drupal-planner.theme/SKILL.md` | Base theme, SDC vs traditional, CSS methodology, preprocess, asset libraries, accessibility | **Content** |
| 5 | drupal-planner.canvas | `.claude/skills/drupal-planner.canvas/SKILL.md` | Canvas Code Component definition, props, data fetching, styling, composability, upload/deploy | **Content** (Drupal CMS / Experience Builder specific) |
| 6 | drupal-planner.search | `.claude/skills/drupal-planner.search/SKILL.md` | Search API, Solr/Elasticsearch, Facets, Views search, autocomplete, zero-result handling | **Content** |
| 7 | drupal-critic | `.claude/skills/drupal-critic/SKILL.md` | Harsh review with Drupal rubric, Realist Check, Security Exploitability Gate, multi-perspective, external-skill routing | **Meta-orchestrating** (loads external skills, routes perspectives, activates rubric) |
| 8 | drupal-config-executor | `.claude/skills/drupal-config-executor/SKILL.md` | Deterministic generation of `config/install/*.yml` from planner specs (content types, fields, displays, taxonomies, Search API) | **Content** (bridges planner→implementation) |

**Architecture pattern**: `drupal-planner` and `drupal-critic` are meta-orchestrators; the five dot-notation sub-planners and the executor are leaf content skills. Every skill has a paired agent under `.claude/agents/` — the skill is the thin dispatch surface, the agent is the heavy protocol.

---

## Q8. Quality Signals

- **Explicit severity calibration and downgrade rules** in `drupal-critic` — each downgrade requires a "Mitigated by: ..." rationale; no downgrade for data-loss/security-breach/financial impact.
- **Security Exploitability Gate**: mandatory privilege-model check before flagging. Drupal-aware (admins already own the site; `settings.php` access = effective admin). Unconfirmed findings go to `Open Questions (unscored)`.
- **Realist Check**: four-question framework (worst-case, blast-radius mitigation, detection time, severity inflation) applied per CRITICAL/MAJOR finding.
- **Required Output Contract** for critic: fixed top-level sections (`VERDICT:`, `Overall Assessment`, `Pre-commitment Predictions`, `Critical/Major/Minor Findings`, `What's Missing`, `Multi-Perspective Notes`, `Verdict Justification`, `Open Questions`).
- **Pre-commitment predictions** — critic must name 3–5 likely failure points before deep review (anti-hindsight bias).
- **Planner Final_Checklist**: 13 checkpoints covering scope, routing, version detection, entity relationships, contrib justification, permission model, config classification, cache strategy, migration idempotency, theme, tasks, review checkpoints.
- **Reference rubrics as first-class citizens**: `contrib-evaluation-rubric.md`, `drupal-planning-rubric.md`, `drupal-review-rubric.md`, `audience-activation-matrix.md`, `skill-routing-map.md`.
- **Supply-chain rigor**: no-copy policy, pinned-commit manifest, two validation scripts (`verify_no_copied_skills.py`, `refresh_external_skills.py --check`).
- **Visual explainer site** at zivtech.github.io/drupal-meta-skills/.
- **Three base-protocol templates** codify shared contracts across planner/critic/executor families.
- **Companion-skill cross-references** (obra/superpowers brainstorming, writing-plans, TDD; flonat code-archaeology; zivtech-claude-skills coding-standards) — ecosystem-aware.

---

## Q11. Compatibility with ai_best_practices LOCKED Decisions

| Decision | Status | Notes |
|----------|--------|-------|
| **Gerund-prefix naming** | NOT compatible | Uses `drupal-planner`, `drupal-critic`, `drupal-config-executor`. Rename to `planning-drupal-architecture`, `reviewing-drupal-code`, `executing-drupal-config` would break the published `/slash-command` surface and external-skills-manifest IDs. |
| **`skills/` at project root (agentskills.io)** | NOT compatible | Uses `.claude/skills/`. One-line layout change but breaks documented install command. |
| **Minimal metadata (`drupal-version` + `status`)** | NOT compatible | 8/8 SKILL.md have neither field. Adding two fields is trivial and non-breaking. |
| **Composer-installable** | NOT compatible | No `composer.json`. Distributed via npx/git clone. |
| **Universal Drupal guidance** | Largely compatible | Planner, critic, executor, content-model, taxonomy, theme, search all apply across Drupal 7/10/11/CMS. `drupal-planner.canvas` is Drupal-CMS + Canvas / Experience Builder scoped. |

**Verdict on fit**: the *content* is the highest-quality Drupal meta-skill content surveyed — but *packaging conventions* diverge from ai_best_practices on 4 of 5 dimensions. Absorption requires a packaging rewrite layer, not content changes.

---

## Q13. Verdict

**Confirm drupal-critic absorption**: YES, confirmed. README states: *"This repo consolidates the work that previously lived across `drupal-planner` and `drupal-critic`, plus the `drupal-config-executor` generation step."* The standalone `zivtech/drupal-critic` repo is archived per its own ANALYSIS.md; its full protocol (severity calibration, Realist Check, external-skills manifest, Security Exploitability Gate, audience activation matrix, no-copy policy) lives unchanged in `.claude/skills/drupal-critic/` with reference rubrics preserved verbatim.

**What's new beyond critic**:
1. **`drupal-planner` meta-skill** (10-phase architecture protocol with Final_Checklist) — from the archived `zivtech/drupal-planner` repo, now co-located.
2. **5 dot-notation sub-planners** (`content-model`, `taxonomy`, `theme`, `canvas`, `search`) with explicit routing rules.
3. **`drupal-config-executor`** — deterministic YAML generation stage bridging planner output → Drupal config YAML. Genuinely new: formalises the planner-to-implementation handoff for the deterministic slice (content types, fields, displays, vocabs, Search API).
4. **Three base-protocol templates** (planner/critic/executor) codify the meta-skill family contract.
5. **Paired subagents** for every skill (`.claude/agents/*.md`) — skills as routers, agents as protocol bodies.
6. **Canvas Code Component planner** (added 2026-03-29) — Drupal CMS / Experience Builder forward-looking coverage.

**Recommendation on absorbing specific skills**:

- **ABSORB CONTENT (with repackaging) — HIGH PRIORITY**:
  - `drupal-critic` — strongest critic protocol in the landscape (Realist Check + Security Exploitability Gate + no-copy manifest are unique). Repackage as `reviewing-drupal-code` (gerund), move to `skills/` root, add `drupal-version: 10|11` + `status: active` frontmatter, add `composer.json`. Preserve reference files verbatim. Keep the manifest supply-chain pattern.
  - `drupal-planner` — most complete planner rubric surveyed (10 phases, Final_Checklist, contrib-first framing). Repackage as `planning-drupal-architecture`. Preserve `contrib-evaluation-rubric.md` and `drupal-planning-rubric.md`.
  - `drupal-config-executor` — uniquely covers the deterministic planner→YAML generation stage; no competing skill in the landscape. Repackage as `executing-drupal-config-generation`.

- **ABSORB SELECTIVELY**:
  - `drupal-planner.content-model`, `drupal-planner.taxonomy`, `drupal-planner.search` — high-value focused planners. Absorb as `planning-drupal-content-model`, `planning-drupal-taxonomy`, `planning-drupal-search`. Drop dot-notation in favour of flat gerund names.
  - `drupal-planner.theme` — absorb as `planning-drupal-theming`.

- **ABSORB WITH CAVEATS**:
  - `drupal-planner.canvas` — narrow Drupal CMS / Canvas Code Component scope. Absorb only if Canvas/Experience Builder is in the ai_best_practices charter. Otherwise mark as optional extension.

- **ABSORB PATTERNS (not skills)**:
  - Paired-agent pattern (skill = router, agent = protocol body) — architectural choice worth evaluating.
  - No-copy manifest + pinned-commit supply-chain validation — worth adopting for external-skill references.
  - Three base-protocol templates (`planner-base-protocol.md`, `critic-base-protocol.md`, `executor-base-protocol.md`) — strong family-contract pattern.

**Bottom line**: this repo is the **single most important Drupal meta-skill source** for the ai_best_practices charter. Content quality is top-of-class; packaging conventions diverge on 4/5 LOCKED decisions but are trivially re-dressable. Absorb all 8 skills as the core Drupal meta-skill family, repackaged to conform.

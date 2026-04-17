# Drupal AI Tooling Landscape — Phase 3 Cross-Repo Synthesis

Synthesised from 25 Phase 2 ANALYSIS.md files plus `tier3.md`. Evidence is Phase-2-only; no re-derivation from raw repos. All references cite Phase-2-documented paths.

Context anchor — `ai_best_practices` locked decisions (do not re-litigate): gerund-prefix verb-in-ing naming; `skills/` at project root; minimal metadata (`drupal-version` + `status` only); Composer-installable distribution; universal Drupal guidance scope.

---

## 1. Landscape map

"Skills" = count of canonical SKILL.md units authored in the repo (not rendered copies). `✓` = present. `—` = absent. `°` = trace/peripheral.

| Repo | Skills | Agents | Commands | Hooks | Prompts | Evals | Module | Aggregator | Installer |
|---|---:|---:|---:|---:|---:|---:|:-:|:-:|:-:|
| surge | 0 | — | — | — | — | — | — | ✓ | ✓ (Composer plugin) |
| aidev | 0 | — | — | — | — | — | ✓ | — | — |
| drupaltools-skills | 27 | 10 | — | — | — | — | — | ° | ° (npx skills) |
| ablerz-claude-skill-drupal-module | 1 | — | — | — | — | — | — | — | ✓ (Composer) |
| gxleano-drupal-agentic-workflow | 20 | — | — | 3 | — | — | — | — | ✓ (bash) |
| madsnorgaard-drupal-agent-resources | 5 | 1 | 5 | — | — | — | — | — | ° (agr CLI) |
| gkastanis-drupal-workflow | 19 | 4 | 10 | 10 | — | ✓ (3 eval scripts + behavioral + session-replay) | — | — | — (plugin marketplace.json) |
| grasmash-drupal-claude-skills | 9 | 8 | — | — | — | — | — | ° (sync scripts) | ✓ (4 paths) |
| drupal_devkit | 37 | 1 | — | ✓ | — | ✓ (3-layer Gemma/Haiku/Opus) | — | ✓ (marketplace of marketplaces) | ✓ (curl+uv+DDEV) |
| edutrul-drupal-ai | 35 | 10 | 9 | 2 | — | — | — | — | ° (skills.sh) |
| scottfalconer-drupal-intent-testing | 1 | — | — | — | — | ° (Python pytest) | — | — | — |
| scottfalconer-drupal-contribute-fix | 1 | — | — | — | — | ° (pytest) | — | — | — |
| Simply007-ckeditor-ai-playground | 1 | — | — | — | 1 (PROMPT.md) | — | ✓ (demo) | — | — |
| Lullabot-prompt_library | 6 | 6 | — | — | 3 | — | — | ° (11ty site) | — |
| ivanboring-drupal-issue-hygiene-helper | 0 | — | — | — | — | — | — | — | — |
| ronaldtebrake-drupal-coding-standards-skill | 1 | — | — | — | — | — | — | — | ✓ (Composer) |
| zivtech-drupal-critic | 1 | 1 | — | — | — | — | — | ° (manifest) | — |
| zivtech-drupal-meta-skills | 8 | 8 | — | — | — | — | — | ° (manifest) | ° (npx) |
| zivtech-a11y-meta-skills | 4 | 2 | — | — | — | ✓ (suites) | — | — | ° (npx) |
| jamieaa64-Drupal-DDEV-Setup | 1 | — | — | — | — | — | — | — | ° (zip) |
| drupal-canvas-skills | 9 | — | — | — | — | — | — | — | ° (npx) |
| Omedia-drupal-skill | 3 | — | — | — | — | — | — | ° (plugin marketplace) | ° |
| aldunchev-ai-fe-skills | 1 | — | — | — | — | — | — | — | — |
| ai_skills | 3 | — | — | — | — | — | — | — | ✓ (Composer library) |
| nonzod-drupaldev-claude-skill | 1 | — | 2 | — | — | — | — | — | ° (bash install.sh) |

Totals: **193 authored SKILL.md units** across 25 repos. Surge and aidev contribute zero content; ivanboring contributes zero skills. Three repos (gkastanis, drupal_devkit, zivtech-a11y) ship eval harnesses; only drupal_devkit ships a 3-tier LLM-evaluator. Four repos (surge, ablerz, ronaldtebrake, ai_skills) offer Composer distribution of skill content.

---

## 2. Standards conformance map

| Repo | Skill filename | Skill location | Frontmatter | Multi-tool? | Mergeability with `ai_best_practices` |
|---|---|---|---|---|---|
| surge | `SKILL.md` (validator) | N/A (aggregates `skills/`, `.claude/skills/`, `.agents/skills/`) | enforces `name, description, license, allowed-tools, metadata, compatibility` | yes | **Collaborate** — validator conflicts with flat `drupal-version`/`status` (must nest under `metadata:`) |
| aidev | — | — | — | N/A | Ignore |
| drupaltools-skills | `SKILL.md` | `skills/<name>/` at root | `name, description, allowed-tools` | skills.sh + Claude Code | Reference + partial absorb (vendor prefix blocks direct merge) |
| ablerz | `SKILL.md` | repo root (single-skill repo) | 8 keys incl. `php_version, symfony_version, last_updated, api_reference` | Claude Code only | Reference + selective absorb |
| gxleano | `SKILL.md` | `.claude/skills/<name>/` | `name, description, version` (inconsistent) | Claude Code only | Reference + selectively absorb (hooks + agent-dispatch pattern) |
| madsnorgaard | `SKILL.md` | `.claude/skills/<name>/` | `name, description` only (CI-enforced) | Claude Code only | Reference (paraphrase only — no license) |
| gkastanis | `SKILL.md` | `skills/<name>/` at root | `name, description, metadata.{status, drupal-version, last-reviewed}` (nested) | Claude Code plugin | Reference + selective content absorb |
| grasmash | `SKILL.md` | `skills/<name>/` at root | `name, description` only | Claude Code; 4 install paths | Absorb content + reference distribution |
| drupal_devkit | `SKILL.md` | `plugins/drupal-core/skills/<name>/` | `name, description, license, metadata.drupal.{plugin, version}` | 8 harnesses (Claude, Copilot, Codex, Cursor, Gemini, Kiro, OpenCode, Hermes) | Collaborate (self-declared reference implementation of ai_best_practices) |
| edutrul | `SKILL.md` | `.claude/skills/<name>/` | `name, description` only | Claude Code + Codex symlink + Cursor symlink + Copilot concat | Absorb content + reference tooling |
| scottfalconer-intent-testing | `SKILL.md` | repo root (single) | `name, description, license, compatibility, metadata.{author, version}, allowed-tools` | Claude Code + Codex | Reference |
| scottfalconer-contribute-fix | `SKILL.md` | repo root (single) | `name, description, license, metadata.{author, version}` | Claude Code + Codex | Reference (absorb patterns + hack-patterns content) |
| Simply007 | `SKILL.md` | repo root (single) | **no frontmatter** | N/A | Reference content nugget only |
| Lullabot | generated `SKILL.md` at build | `<discipline>/skills/<slug>.md` (11ty source) | double-frontmatter (11ty outer + Claude inner) | Claude + Cursor + GPT | Content quarry only — paradigm mismatch |
| ivanboring | — | — | — | — | Ignore |
| ronaldtebrake | `SKILL.md` | `.claude/skills/<slug>/` | `name, description, metadata.{author, version}` | Claude Code | Absorb pattern (Composer-VCS trick + routing-index); author redirects to ai_best_practices |
| zivtech-drupal-critic | `SKILL.md` | `.claude/skills/<slug>/` | `name, description` only | Claude Code | Reference + absorb patterns (consolidated upstream) |
| zivtech-drupal-meta-skills | `SKILL.md` | `.claude/skills/<slug>/` | `name, description` (+ `type, model` on executor) | Claude Code | Absorb content (highest-quality meta-skills in corpus) |
| zivtech-a11y-meta-skills | `SKILL.md` | `.claude/skills/<slug>/` | `name, description, license, compatibility, metadata.{author, version}, disallowedTools` | Claude Code | **Absorb unconditionally** (only a11y source) |
| jamieaa64 | `skill.md` (lowercase) | `.claude/skills/<slug>/` | `name, description` | Claude Code | Ignore (broken-casing + install) |
| drupal-canvas-skills | `SKILL.md` | `skills/<name>/` at root | `name, description` only | Claude Code + generic agent | Reference pattern; content is project-specific, not universal |
| Omedia | `SKILL.md` | repo-root flat (`drupal-frontend/` etc.) | `name, description` only; plugin marketplace.json adds `version, license, author, keywords, category` | Claude Code plugin | Reference content only |
| aldunchev | `SKILL.md` | `drupal-figma-to-canvas-sdc/` | `name, description, argument-hint, disable-model-invocation` | Claude + Codex + Gemini + Cursor + Windsurf (claimed) | Harvest rules & patterns only |
| ai_skills | `SKILL.md` | `skills/<name>/` at root | inconsistent: `{name, description, license?, metadata.{author, version}?}` | Composer + npx | Absorb selectively (crown-jewel: `drupal-contribute-fix`) |
| nonzod | `SKILL.md` | `.claude/skills/<slug>/` | `name, description` only | Claude Code | Ignore — strictly inferior to ronaldtebrake |

**Filename split**: 23 repos use uppercase `SKILL.md`; 1 uses lowercase `skill.md` (jamieaa64 — silent-fail risk on strict loaders); Lullabot generates `SKILL.md` at build time from 11ty sources. Simply007 has `SKILL.md` with no frontmatter.

**Skill location split**: 9 repos use `skills/` at root (drupaltools, gkastanis, grasmash, drupal_devkit under `plugins/drupal-core/`, ai_skills, drupal-canvas-skills, scottfalconer singles, plus Simply007 / ablerz single-skill-at-root). 9 repos use `.claude/skills/` (gxleano, madsnorgaard, edutrul, zivtech-critic, zivtech-meta, zivtech-a11y, jamieaa64, aldunchev, nonzod, ronaldtebrake). Omedia uses flat plugin-at-root. Lullabot uses 11ty-namespaced.

**AGENTS.md presence**: surge generates, grasmash symlinks to CLAUDE.md, madsnorgaard documents, drupal_devkit emits per-harness. No universal adoption.

**Gerund-prefix conformance**: essentially nobody. `gkastanis/writing-plans` is the only strict match out of ~193 skills. `twig-templating`, `drupal-caching`, `drupal-testing`, `resolve-composer-conflicts` have gerunds as second-token. All other repos use `<domain>-<noun>` or `drupal-<topic>`. ai_best_practices' naming decision is ecosystem-anomalous and will cost every absorbee a mass rename.

---

## 3. Pattern clusters

Six clusters emerge from the evidence. Each repo is placed in the dominant cluster; some have secondary membership.

### Cluster A — Flat skill content libraries (authored prose, minimal tooling)
Members: `drupaltools-skills` (27), `ablerz` (1), `grasmash` (9 + 8 agents), `edutrul` (35), `drupal-canvas-skills` (9), `Omedia` (3), `aldunchev` (1), `ai_skills` (3), `nonzod` (1), `Simply007` (1), `jamieaa64` (1), scottfalconer × 2 (1 each), `ronaldtebrake` (1).
Pattern: one-or-more SKILL.md files, YAML frontmatter, progressive `references/` disclosure, optional scripts. Distribution = git clone / `cp -r` / `npx skills add` / Composer. No hooks, no live policy.
Rationale: the dominant and simplest form; defined by skills-in, skills-out with no executing infrastructure.

### Cluster B — Harness bundles (skills + agents + commands + hooks + rules)
Members: `gxleano-drupal-agentic-workflow`, `gkastanis-drupal-workflow`, `edutrul-drupal-ai`, `madsnorgaard`.
Pattern: skills PLUS commands PLUS subagents PLUS hooks wired in `settings.json` or `hooks/hooks.json`, with session-lifecycle scripts, lint-feedback loops, and persona agents. Delivered as a Claude Code plugin or `cp -r .claude/` pack. Builds a working coding-partner harness, not a content library.
Rationale: these repos bundle behavioural enforcement (pre-bash-guard, post-generation-lint, plan-mode-inject, teammate-quality-gate) alongside content — a different product category from A.

### Cluster C — Aggregators / distribution mechanics
Members: `surge` (Composer plugin, Drupal-native), `drupal_devkit` (Python CLI, 8 harnesses, marketplace-of-marketplaces), `Lullabot-prompt_library` (11ty static site + raw-markdown URL API).
Pattern: scan-discover-validate-emit. Own no content (surge), or own content but lead with distribution infrastructure (devkit, Lullabot).
Rationale: these are the "delivery substrate" layer — ai_best_practices must choose which to align with.

### Cluster D — Meta-orchestration (planner / critic / executor)
Members: `zivtech-drupal-critic` (archived into meta), `zivtech-drupal-meta-skills` (8 skills, 3 templates, paired agents), `zivtech-a11y-meta-skills` (4 skills, planner+critic+tester+auditor).
Pattern: plan → critique → execute → re-critique with severity calibration, Realist Check, Security Exploitability Gate, evidence-mandatory output contracts, pinned-commit external-skill manifests, no-copy policy. Skills act as dispatch wrappers; paired `.claude/agents/*.md` carry heavy protocol.
Rationale: architecturally distinct from A and B — oriented around *reasoning roles* rather than task topics. Only cluster with base-protocol templates and systematic severity taxonomy.

### Cluster E — Single-purpose CLI tools (not skill libraries)
Members: `ivanboring-drupal-issue-hygiene-helper` (Symfony Console app), `aidev` (Drupal contrib module).
Pattern: PHP CLI application. No SKILL.md files; CLAUDE.md (where present) is design notes, not reusable skill. Author explicitly labels `ivanboring` as "vibe-coded".
Rationale: occupy the research set because the caller swept broadly; contribute no skill assets.

### Cluster F — Abandoned / out-of-scope / deferred
Members: `aidev` (2024-04, abandoned), `ai_skills` (alpha3, unsupported — but Composer dep of surge), `ronaldtebrake` (unmaintained, self-redirects), `zivtech-drupal-critic` (archived, consolidated), `drupal_ai` (empty placeholder per tier3.md), `nonzod` (stale + broken install + strictly inferior).
Rationale: these repos come with explicit or effective signals telling absorbers not to fork them — either the author deferred to ai_best_practices (ronaldtebrake), consolidated upstream (critic → meta-skills), or abandoned altogether.

---

## 4. Coverage matrix

Abbreviations: **drpt** drupaltools-skills, **abl** ablerz, **gxl** gxleano, **mns** madsnorgaard, **gkt** gkastanis, **grs** grasmash, **dvk** drupal_devkit, **edt** edutrul, **om** Omedia, **ai_sk** ai_skills, **dcan** drupal-canvas-skills, **zvm** zivtech-meta, **za11y** zivtech-a11y, **zvc** zivtech-critic, **sca** scottfalconer-contribute-fix, **sci** scottfalconer-intent-testing, **sim** Simply007, **lul** Lullabot (Drupal subset), **ron** ronaldtebrake, **non** nonzod, **jam** jamieaa64, **ald** aldunchev, **abl** ablerz, **surge**, **aidev**, **iv** ivanboring. `✓` = direct first-class coverage (dedicated skill/reference). `°` = partial or embedded mention. Blank = not covered.

| Topic | drpt | abl | gxl | mns | gkt | grs | dvk | edt | om | ai_sk | dcan | zvm | za11y | zvc | sca | sci | sim | lul | ron | non | jam | ald |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Entity API | ° | ✓ | ✓ | ✓ | ✓ | | ✓ | ✓ | ✓ | | | ° | | | | | | ° | | | | |
| Field system | | | | | | | ✓ | ✓ | | | | ✓ | | | | | | | | | | |
| Form API | | ✓ | | ✓ | ✓ | | | ✓✓✓✓ (4) | ✓ | | | | | | | | | | | | | |
| Render API / render arrays | | ✓ | | ✓ | | | | ✓ | | | | | | | | | | | | | | |
| Twig / theming | | ✓ | ✓ | ✓ | ✓ | | ✓ | ✓ | ✓ | | | ° | | | | | | ° | | | | |
| SDC | | | ✓ | | | | ✓ | ° | | | | | | | | | | | | | | ✓ |
| Hooks (OOP + procedural) | ✓ | ✓ | ✓ | ✓ | ✓ | | ✓ | ✓ | ✓ | | | | | | | | | | | | | |
| Services / DI | | ✓ | ° | ✓ | ✓ | | ✓ | ✓ | ✓ | | | | | | | | | ° | | | | |
| Plugin system | | ✓ | | ✓ | | | | ✓ | ✓ | | | | | | | | | | | | | |
| Routes / controllers | | ✓ | | ✓ | | | | ✓ | ✓ | | | | | | | | | | | | | |
| Access control | | ✓ | | ✓ | | | | ✓ | ✓ | | | | | | | | | | | | | |
| Caching / cache metadata | | ✓ | ✓ | ° | ✓ | | ✓ | ✓ | | | | | | ✓ (ext) | | | | | | | | |
| Config management | | ✓ | ✓ | | ✓ | ✓ | ✓ | ✓ | | | | | | | | | | | | | | |
| Migrations | | | ✓ | ✓ | | | ✓ | ✓ | | | | | | | | | | | | | | |
| Testing (unit/kernel) | | ✓ | | | ✓ | | ✓ | ✓ | | | | | | | | | | | | | | |
| Testing (DTT / ExistingSite / functional) | | | | | ✓ | ✓ | ✓ | ✓ | | | | | | | | | | | | | | |
| Testing (E2E / intent / browser) | | | | | | | ✓ | | | | | | ✓ | | | ✓ | | | | | | |
| Security / OWASP | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ° | | | | | ✓ | ° | | | ° | | | | |
| Performance | | | ✓ | | ° | | ✓ | ° | | | | | | | | | | | | | | |
| Coding standards (PHPCS/PHPStan) | ✓ | ✓ | ° | ° | ✓ | | ✓✓ (incl. -rt) | ° | | ✓ | | | | | | | | ✓ | ✓ | ✓ | | |
| DDEV | | ✓ (cmds) | ✓ | ✓ | | ✓ | ✓ | ✓ | ✓ | | | | | | | | | | | | ✓ | |
| Drush | | ✓ (cmds) | ✓ | ✓ (cmd) | | | ✓ | ✓ | ✓ | | | | | | | | | | | | | |
| Composer / contrib update | ✓ (patch) | | ✓ (update-module) | | | ✓ | ✓ | ✓ | | | | | | | | | | ✓ | | | | |
| Contribution workflow (d.o issues) | ✓ | | | | | | ✓ | | | ✓ | | | | | ✓ | | | | | | | |
| Issue triage / hygiene | ✓ | | | | | | | | | ✓ | | | | | ✓ | | | | | | | |
| Code review | | | ✓ | ° (cmd) | ° | ✓✓ (quality-gate + done-gate) | ° | ✓ | | | | ✓ (critic) | ✓ (critic) | ✓ | | | | | | | | |
| CKEditor / content authoring | | | | | | | | | | | | | | | | | ✓ | | | | | |
| Accessibility / WCAG | ° | | ✓ | | | | ✓ | ° (in rules) | ° | | | | ✓✓✓✓ (4) | | | | | | | | | ° |
| Search API | | | | | | ✓ | ✓ | ✓ | | | | ✓ (planner.search) | | | | | | | | | | |
| Views / Layout Builder | | | | | | | ✓ | | | | | | | | | | | ° | | | | |
| Paragraphs | | | | | | | | ✓ | | | | ° | | | | | | | | | | |
| Taxonomy | | | | | | | | ✓ | | | | ✓ (planner.taxonomy) | | | | | | | | | | |
| Queries / DB API | | ✓ | | | | | | ✓ | ✓ | | | | | | | | | | | | | |
| State API | | | | | | | | ✓ | | | | | | | | | | | | | | |
| Events | | ✓ | | | | | | ✓ | | | | | | | | | | | | | | |
| Menus | | | | | | | | ✓ | | | | | | | | | | | | | | |
| JavaScript / Drupal.behaviors | | | | | | | | ✓ | | | | | | | | | | | | | | |
| Batch / queue / AJAX | | | | | | | | ✓ (ajax) | | | | | | | | | | | | | | |
| Planner / architecture | | | | | | | | | | | | ✓✓✓✓✓ (planner family) | ✓ (a11y-planner) | | | | | | | | | |
| Generator / scaffolder | ✓ (clone, module) | | ✓ (scaffold) | ✓ (cmd) | | | | | ✓ (templates) | | | ✓ (config-executor) | | | | | | | | | ✓ (setup) | ✓ (figma→SDC) |
| CKEditor 5 plugin authoring | | | | | | | | | | | | | | | | | ✓ | | | | | |
| Canvas Code Components | | | | | | ✓ (drupal-canvas) | ✓ (via canvas-plugin) | | | | ✓ (9) | ✓ (planner.canvas) | | | | | | | | | | ✓ |

**Topics no one covers (or covered only by a single marginal repo)** — prime gaps `ai_best_practices` can fill:
- **Menus** (edt only)
- **State API** (edt only)
- **Batch / queue API** (edt only; surge's AGENTS.md section template alone)
- **Cron** (no first-class skill anywhere)
- **JSON:API / REST / decoupled** (only drupal_devkit via `drupal-json-api`; edt rules have scattered mention)
- **Webform** — not covered
- **Media / image styles / files beyond entity-API** — not covered
- **Recipes** (config-management adjacent; only tangential mentions in grs, dvk)
- **Workflow / content-moderation** (only dvk has `drupal-content-moderation`)
- **Multilingual / translations** (drpt `drupaltools-translations` only; no zivtech/dvk skill)
- **OOP hooks uniformly (D11 `#[Hook]` attribute)** — most repos mention, only `drpt`, `abl`, `edt`, `gkt`, `dvk` go deep
- **Upgrade-status / Drupal 11 readiness** — only grs `drupal-contrib-mgmt`

**Topics everyone covers** — candidates for absorb-and-consolidate (coverage ≥7 repos):
- **Security / OWASP** — 12 repos, massive duplication (see §5)
- **Coding standards** — 9 repos (ai_skills, non, ron, drpt, dvk, gkt, edt, lul, abl)
- **Hooks** — 8 repos
- **DDEV** — 8 repos
- **Twig/theming** — 7 repos
- **Entity API** — 7 repos
- **Services/DI** — 7 repos

---

## 5. Overlap and conflict analysis

### 5.1 Coding-standards multiplicity
Files covering essentially the same Drupal.org `drupal/coding_standards` upstream:
- `ai_skills/skills/drupal-coding-standards/SKILL.md` + `assets/standards/` (10 subject dirs, 27 files) — v0.1, Composer+VCS-pull of upstream
- `ronaldtebrake-drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/SKILL.md` + `assets/standards/` — unmaintained, self-redirects to ai_best_practices
- `nonzod-drupaldev-claude-skill/.claude/skills/drupal-standards/SKILL.md` + project-root `coding_standards/` — broken install (SKILL.md references paths outside the skill dir)
- `drupaltools-skills/skills/drupaltools-coding-standards/SKILL.md`
- `gkastanis-drupal-workflow/skills/drupal-coding-standards/SKILL.md` — plus `drupal-rules/SKILL.md` mega-skill that partially duplicates
- `drupal_devkit/plugins/drupal-core/skills/drupal-coding-standards/SKILL.md` (and a `-rt` review-time variant)
- `edutrul-drupal-ai/.claude/rules/phpcs.md` + `docblocks.md` (rules, not skill)
- `Lullabot-prompt_library/development/rules/drupal-standards.md` (bullet list)

**Conflict surface**: multiple routing strategies — ronaldtebrake uses a lightweight `standards-index.md` routing file; nonzod inlines always-load into SKILL.md body; ai_skills mirrors the routing pattern; drpt and dvk body-embed content. Only ronaldtebrake's pattern is clean and small; every other is either broken (nonzod) or bloated (nonzod + direct-inline). `drupal-rules` (gkt) specifically bundles coding standards into a multi-topic mega-skill, conflicting with ai_best_practices' one-skill-one-topic decision.

**Absorb verdict**: pull upstream `drupal/coding_standards` directly (as ai_skills and ronaldtebrake both do via Composer VCS-repository), adopt ronaldtebrake's `standards-index.md` routing pattern, name the result in gerund form.

### 5.2 Security / OWASP multiplicity
- `edutrul-drupal-ai/.claude/skills/drupal-security/SKILL.md` (160 lines, VULNERABLE vs SAFE framing, production-earned)
- `grasmash-drupal-claude-skills/skills/ivangrynenko-cursorrules-drupal/references/authentication-security.md` (full OWASP A01-A10 rule bodies, sync'd from ivangrynenko)
- `madsnorgaard-drupal-agent-resources/.claude/skills/drupal-security/SKILL.md`
- `drupaltools-skills/skills/drupaltools-best-practices/SKILL.md` (security as subsection)
- `drupal_devkit/plugins/drupal-core/skills/drupal-security-patterns/SKILL.md` + separate `drupal-security-audit/SKILL.md`
- `gkastanis-drupal-workflow/skills/drupal-security-patterns/SKILL.md`
- `gxleano/.claude/skills/drupal-security/SKILL.md` + security-perf grep scan in `post-generation-lint.sh`
- `zivtech-drupal-critic/.claude/skills/drupal-critic/SKILL.md` — **Security Exploitability Gate** with Drupal privilege-model awareness (refuses to flag admin-only issues as CRITICAL)

**Conflict surface**: two opposing philosophies. Most repos take a "catalog-all-OWASP-and-check" posture; zivtech-drupal-critic explicitly calibrates severity against the Drupal privilege model ("admins already own the site") and refuses to inflate admin-surface findings. ai_best_practices must pick a stance — the default "more is better" position creates AI false-positive storms, which zivtech flags as a known failure mode.

**Absorb verdict**: content from `edutrul/drupal-security` (VULNERABLE/SAFE framing + production-earned specifics), calibration gate from `zivtech-drupal-critic`, OWASP mapping from grasmash's ivangrynenko body.

### 5.3 OOP hooks (`#[Hook]`) multiplicity
All present with largely identical advice: `ablerz/references/hooks.md`, `drpt/drupaltools-oop-hooks/SKILL.md`, `gkt/skills/drupal-hook-patterns/SKILL.md`, `dvk/plugins/drupal-core/skills/drupal-hook-patterns/SKILL.md`, `edt/.claude/skills/drupal-hooks/SKILL.md`, `mns/drupal-expert/SKILL.md` (hooks section), `grs` (implicit via fingertips stub), `Omedia/drupal-backend/SKILL.md`. Duplication risk: same `final class` + `readonly` + `#[Hook('...')]` pattern printed ~8 times.

**Absorb verdict**: pick one canonical body (edutrul's `drupal-hooks/SKILL.md` is tight at 138 lines with D11.1 idioms) and reference upstream Drupal docs for the full hook inventory.

### 5.4 Config management multiplicity
- `grs/drupal-config-mgmt/SKILL.md` (570 lines — over the 500-line rule the author sets elsewhere)
- `gkt/skills/drupal-config-management/SKILL.md` (install vs optional vs sync distinction)
- `dvk/plugins/drupal-core/skills/drupal-config-management/SKILL.md`
- `edt/.claude/skills/drupal-config/SKILL.md` + `references/full-guide.md`
- `abl/references/configuration-api.md`
- `gxl/.claude/skills/config-management/SKILL.md`

Content is close; grs + gkt go deepest on Config Split + readonly; gkt's `install/optional/sync` distinction is the cleanest articulation.

### 5.5 Hooks `gkastanis/drupal-rules` ↔ other skills
`drupal-rules/SKILL.md` (gkt, 183 lines, "ALWAYS consult") bundles services + security + code quality + testing. Fights the one-topic skill-router principle; conflicts conceptually with edutrul's per-topic `.claude/rules/*.md` split into 8 single-purpose files. Both are "rules" but at different granularities.

### 5.6 Meta-skill naming / scope conflicts
`zivtech-drupal-critic/drupal-critic/SKILL.md` vs `zivtech-drupal-meta-skills/.claude/skills/drupal-critic/SKILL.md` — same protocol, consolidated; old repo archived. No live conflict after consolidation.

### 5.7 Distribution mechanism conflicts
Composer channel (surge, ablerz, ronaldtebrake, ai_skills) vs npx/skills.sh (drpt, grs option, dcan, mns via agr, za11y, zvm) vs Python-tool (dvk) vs bash install (gxl, non, jam) vs Claude-plugin marketplace (gkt, Omedia). Four repos attempt dual channels (grs: 4 paths). Aggregator conflict: surge hard-requires `drupal/ai_skills` (alpha+unsupported); drupal_devkit registers `ai_best_practices` as a default source; both will aggregate ai_best_practices but under incompatible tool runtimes.

---

## 6. Best-in-class picks per dimension

### Best structural / routing pattern — `ronaldtebrake-drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/standards-index.md`
Thin SKILL.md (~60 lines) + sibling `standards-index.md` routing table mapping file extension → specific standards files to load on demand. Minimal token cost at activation; deep content only loads on relevance. Independently reinvented by `ai_skills/skills/drupal-coding-standards/standards-index.md` (identical approach). Better than the always-load pattern in `nonzod/.claude/skills/drupal-standards/SKILL.md` (189 lines enumerating every standard). Better than `drupaltools-contrib-validator/SKILL.md:13-18` sub-skill prose orchestration (no machine contract). Pick is defensible on Phase-2 evidence (Q10 of ronaldtebrake, Q10 of nonzod head-to-head).

### Best eval / testing approach — `drupal_devkit` 3-layer harness (`src/drupal_devkit/eval_runner/` + `evals/<skill>/evals.json`)
Three-tier deterministic grading (Gemma 3 4B on Ollama for L1 OSS floor; Haiku 4.5 L2; Opus 4.6 L3) with 4 assertion types (`must_contain_any`, `must_not_contain`, `syntax_check`, `check_markdown_structure`) invoked via `drupal-devkit eval <skill> [--layer all|l1|l2|l3]`. Beats the alternative approaches on measurability and CI-friendliness:
- `gkastanis-drupal-workflow/eval/*.py` (static + behavioral + session-replay, 48 static checks + 23 behavioral cases) is richer but less portable (plugin-scoped)
- `zivtech-a11y-meta-skills/evals/suites/` is suite-structured but content-only, not LLM-graded
- `scottfalconer-drupal-contribute-fix/tests/test_*.py` are pytest tests of the Python tooling, not skill-output evals
- `ablerz/.github/workflows/check-versions.yml` is a staleness monitor, not a quality eval.

For a Composer-distributed library, devkit's assertion-file pattern is most portable.

### Best per-topic skill content to absorb verbatim (top 10)

1. **`edutrul-drupal-ai/.claude/skills/drupal-hooks/SKILL.md`** — 138 lines, Drupal 11.1 `#[Hook]` attribute pattern, `final class` + `readonly` + constructor DI, auto-discovery from `src/Hook/`. Tightest per-line density of D11 idioms in the corpus. Rename to `writing-drupal-hooks`.

2. **`edutrul-drupal-ai/.claude/skills/drupal-security/SKILL.md`** — 160 lines, VULNERABLE vs SAFE framing, explicit anti-patterns. Production-earned per Q8 (edutrul). Rename to `hardening-drupal-security`. Pair with zivtech's Security Exploitability Gate (below).

3. **`grasmash-drupal-claude-skills/skills/drupal-simple-oauth/SKILL.md`** — cites exact file paths and line numbers in `docroot/modules/contrib/simple_oauth/src/Authentication/TokenAuthUser.php`, double-intersection of scopes/roles, token-decorator pitfalls. Q9 #5 (grasmash) calls this "among the strongest skill bodies in the entire Drupal AI ecosystem surveyed". Rename to `securing-drupal-oauth`.

4. **`grasmash-drupal-claude-skills/skills/drupal-search-api/SKILL.md`** — boolean vs integer boost distinction, custom boost processors, field-typing specifics. Unique vertical depth not found elsewhere. Rename to `tuning-drupal-search-api`.

5. **`zivtech-drupal-meta-skills/.claude/skills/drupal-critic/SKILL.md`** + companion agent — Security Exploitability Gate, Realist Check, pre-commitment predictions, severity calibration with 3 worked examples (downgrade/upgrade/hold). Strongest critic protocol in the corpus (Q13 zvm). Rename to `reviewing-drupal-changes`.

6. **`zivtech-drupal-meta-skills/.claude/skills/drupal-planner/SKILL.md`** with its 10-phase Final_Checklist — contrib-first evaluation rubric, permission model, cache strategy, migration idempotency. Most complete planner in the corpus. Rename to `planning-drupal-architecture`.

7. **`zivtech-a11y-meta-skills/.claude/skills/a11y-planner/SKILL.md`** and siblings (`a11y-critic`, `a11y-test`, `perspective-audit`) — only a11y content in the ecosystem (verified against 13-skill external inventory in `docs/EXTERNAL-SKILLS-INVENTORY.md`). Framework-agnostic WCAG 2.2 + WAI-ARIA APG. Rename to `planning-accessibility`, `critiquing-accessibility`, `testing-accessibility`, `auditing-accessibility-perspectives`.

8. **`ai_skills/skills/drupal-contribute-fix/SKILL.md` + `scripts/contribute_fix.py` + `lib/`** (= `scottfalconer-drupal-contribute-fix` upstream) — crown-jewel gatekeeper pattern (search-drupal.org-before-patching, exit-code state machine 0/10/20/30/40/50, security-issue auto-stop). v1.4.0, most mature in the repo. Rename to `contributing-upstream-fixes`. Absorb Python tooling as-is (stdlib-only).

9. **`ai_skills/skills/drupal-issue-queue/SKILL.md` + `scripts/dorg.py`** — read-only drupal.org API wrapper with rate-limit/cache hygiene. Complements contribute-fix as preflight search. Rename to `searching-drupal-issues`.

10. **`gkastanis-drupal-workflow/skills/verification-before-completion/SKILL.md`** — 5-step gate (IDENTIFY/RUN/READ/VERIFY/THEN) with completion-report template. Unique in the corpus. Rename to `verifying-before-declaring-done`.

Honourable mentions (11–15 if absorbed): `gkt/drupal-caching`, `gkt/drupal-config-management`, `grs/drupal-config-mgmt`, `grs/drupal-contrib-mgmt`, `edt/drupal-search-api` (largest at 295 lines).

### Best agent definitions to reuse
- **`grasmash-drupal-claude-skills/.claude/agents/quality-gate.md`** and **`done-gate.md`** — the quality-gate/done-gate split (quality = code review; done = actually works). The `quality-gate.md` "Drupal data integrity" checklist (`hook_update_N` vs standalone scripts, direct-DB vs entity API for large updates) is hard-won production knowledge per Q9 grs #4.
- **`edutrul-drupal-ai/.claude/agents/done-gate.md`** — adversarial stance ("Assume work is incomplete until proven otherwise"), runs drush cr + PHPCS + PHPStan + PHPUnit on changed files, checks bug-fix regression test presence.
- **`zivtech-drupal-meta-skills/.claude/agents/drupal-critic.md`** — `disallowedTools: Write, Edit` (read-only reviewer enforcement), `claude-opus-4-6` model pin. Paired with the critic skill as router→protocol.
- Skip `drupaltools-skills/agents/*.md` (10 personas) — overlap with Kanopi/other persona packs per Q10 drpt #8.

### Best hooks / quality gates
- **`gxleano/.claude/hooks/post-generation-lint.sh`** — phpcbf first (auto-fix what's fixable) → phpcs → local grep for `eval()`, `shell_exec()`, `unserialize()`, `\Drupal::` in `src/`, missing `accessCheck()` — exit 2 feeds errors back to Claude for self-correction. Tightest "ship code Claude can verify" loop in the corpus (Q9 gxl #1).
- **`gxleano/.claude/hooks/pre-bash-guard.sh`** — destructive-command blocklist (`git reset --hard`, `DROP TABLE`, `ddev delete`, etc.). Minimal and universally useful.
- **`gkastanis-drupal-workflow/hooks/hooks.json`** + `scripts/autopilot-monitor.sh` — session-state weighted drift scoring (plan=0.3, delegate=0.3, skill=0.2, verify=0.2), 3-level escalation (hint→command→suppress) with `MAX_FIRES_PER_TYPE=2` and `flock -w 1`. More sophisticated but plugin-coupled; the `project-state-check.sh` SessionStart hook with `; exit 0` + timeout rules (see gkt CLAUDE.md) is the critical learning.
- **`grasmash/.claude/settings.json`** destructive-drush `ask` patterns (`cim`, `sql-drop`, `site:install`) — adopt verbatim as ai_best_practices recommended settings baseline.

### Best distribution / install story
**`surge`** for the Drupal-native-Composer side (Composer plugin, auto-registers `post-install-cmd` hooks, hardened PathSecurity, 1,615 lines of tests — Q8 surge). Its metadata requirement — flatten ai_best_practices' `drupal-version`/`status` into a nested `metadata:` map — is a 1-line fix.

Runner-up: **`drupal_devkit`** for the cross-harness side (8 Tier-1 harness emitters, per-harness Claude-syntax stripping, `drupal-marketplace.json` conformance ladder L0-L3, curl-bash universal installer). Not Composer but necessary for non-Claude harnesses. These two are complementary, not competing (Q12 dvk).

Worst: **`nonzod/install.sh`** (broken — copies skill dir but references content outside it, per Q8 non); **`jamieaa64`** (lowercase `skill.md`, silent-fail on strict loaders, per Q10 jam).

### Best multi-tool compatibility approach
**`drupal_devkit`** outright: dedicated emitter per harness (`src/drupal_devkit/generator/emitters/{claude,codex,copilot,cursor,gemini,hermes,kiro,opencode}.py`) + per-harness context file generation (`contextfiles.py` auto-composes AGENTS.md, GEMINI.md, `.cursor/rules/*.mdc`) + portability audit (`scripts/portability-audit.py`) that checks for Claude-only syntax leakage (`${CLAUDE_SKILL_DIR}`, backtick-exec, `$N` substitution) — the only repo in the corpus that systematically enforces the multi-tool contract. `edutrul-drupal-ai` documents 4 manual integrations but has no enforcement; `aldunchev` claims multi-tool but ships only a "single-pass fallback mode" annotation.

---

## 7. Meta-observations

### The self-deference chain
ai_best_practices sits at the centre of an unusual governance topology. Four repos explicitly defer to it as canonical:
1. `ronaldtebrake-drupal-coding-standards-skill` — README line 1 redirects users to ai_best_practices.
2. `drupal_devkit/AGENTS.md:43-49` — "ai_best_practices is authoritative. If a skill in devkit disagrees with a guidance document in ai_best_practices, the guidance wins — flag the divergence as a bug to fix."
3. `drupal_devkit/install.sh:95-100` — ai_best_practices is registered as a default marketplace source on every install.
4. `ai_skills` README — drupal.org page flags UNSUPPORTED and redirects users to ai_best_practices.

Simultaneously, `surge` hard-depends on `drupal/ai_skills` (not ai_best_practices) via Composer, so as surge-installed projects do `composer update` they continue pulling the alpha-frozen ai_skills content. This creates a transition problem: ai_best_practices cannot simply replace ai_skills in Composer because surge's dep is hard-pinned. Either (a) ai_best_practices publishes as `drupal/ai_skills` (namespace squat, politically awkward), (b) surge repoints its dep at ai_best_practices, or (c) ai_skills becomes a thin meta-package that re-exposes ai_best_practices content. The Phase-2 evidence supports (b) as the cleanest path — ai_skills is flagged unsupported on drupal.org, and its crown-jewel content (`drupal-contribute-fix`) lives live at `scottfalconer/drupal-contribute-fix`.

### Naming-drift epidemic
Of ~193 authored SKILL.md files across 25 repos, exactly **one** strictly matches ai_best_practices' gerund-prefix decision: `gkastanis/writing-plans`. This means every absorption step entails a rename. The decision is defensible on router-activation grounds (verbs trigger better than nouns) but is ecosystem-contrarian. A rename-translation layer at the aggregator level (surge or drupal_devkit) could eliminate the migration cost for external contributors — worth flagging for the SPEC phase.

### License-missing epidemic
Explicit "License: none" reported in INDEX.md for: `gxleano`, `grasmash` (has MIT but no LICENSE file — per Q8 grs but also INDEX), `gkastanis` (MIT in plugin.json but no LICENSE file), `madsnorgaard`, `edutrul-drupal-ai` ships MIT, `nonzod`, `ronaldtebrake`, `Omedia` (README claims MIT, LICENSE absent), `aldunchev` (README claims MIT, LICENSE absent), `drupaltools-skills` (GPL v2 declared, LICENSE file present). Roughly half the corpus has a license gap. For a GPL-compatible absorber like ai_best_practices, this is a real verbatim-reuse blocker — Phase 4 should budget for paraphrase instead of direct lift where no license is declared, and flag explicit ask-author work for the repos worth collaborating with.

### Skill / agent / command / hook hierarchy
An emergent four-tier taxonomy appears across the corpus but is under-formalised:
- **Rules** — always-on, session-persistent context (edutrul's 8 `.claude/rules/*.md`, Lullabot's `.mdc` rules). No activation cost, full token cost.
- **Skills** — on-demand, description-matched (all 25 repos). Small activation cost, variable token cost.
- **Commands** — user-explicit slash (gkt 10, edt 9, mns 5, non 2). Zero auto-activation; full user control.
- **Agents** — isolated Task-dispatch with scoped tools (grs 8, edt 10, drpt 10). Paired with skills in zivtech-meta + zivtech-a11y (skill=router, agent=protocol body).
- **Hooks** — harness-level policy enforcement (gxl 3, gkt 10, edt 2). Cannot be migrated to Composer-only distribution without a tool runtime.

ai_best_practices' scope decision (skills-only, universal guidance) implies leaving commands/hooks to companion packages — a clean positioning, but the harness-bundle repos (Cluster B) conclusively demonstrate these layers reinforce each other in production.

### Eval scarcity
Only 3 repos ship any skill-output eval: `drupal_devkit` (3-tier, 2 skills covered of 36), `gkastanis-drupal-workflow` (23 behavioral cases, 48 static checks, session replay; plugin-coupled), `zivtech-a11y-meta-skills` (fixture suites). Everyone else measures either prose quality via CI lint (madsnorgaard, surge, ablerz) or not at all. For a universal-guidance library aiming at community authority, ai_best_practices should adopt devkit's assertion-file pattern as a minimum bar — it is portable, deterministic, and runs on an OSS model floor (Gemma-on-Ollama) so contributors without API keys can still land tested skills.

### Drupal-version metadata: still unsolved at ecosystem level
Zero repos in the corpus consistently carry a flat `drupal-version:` field at the SKILL.md frontmatter level. `gkastanis` nests it (`metadata.drupal-version`); `drupal_devkit` nests differently (`metadata.drupal.version`); most repos omit entirely; version claims live in prose. ai_best_practices' locked minimal metadata (`drupal-version` + `status` only) is both necessary and novel — the whole ecosystem would benefit from converging on it.

---

## Appendix — repo-by-repo absorb/reference/ignore tally

For quick lookup. Based on Phase-2 Q13 verdicts.

| Repo | Verdict |
|---|---|
| surge | Collaborate (distribution substrate) |
| aidev | Ignore |
| drupaltools-skills | Reference + partial absorb |
| ablerz | Reference + selective absorb |
| gxleano | Reference + selective absorb (hooks, agent-dispatch) |
| madsnorgaard | Reference (paraphrase only — no license) |
| gkastanis | Reference + selective content absorb |
| grasmash | Absorb content + reference distribution |
| drupal_devkit | Collaborate (reference-implementation role) |
| edutrul | Absorb content + reference tooling |
| scottfalconer-intent-testing | Reference |
| scottfalconer-contribute-fix | Reference + absorb patterns |
| Simply007 | Reference content nugget only (DLL/UMD gotcha) |
| Lullabot | Content quarry only |
| ivanboring | Skip for skill extraction |
| ronaldtebrake | Absorb pattern; author already redirects |
| zivtech-drupal-critic | Reference + absorb patterns (consolidated upstream) |
| zivtech-drupal-meta-skills | Absorb content (highest-quality meta-skills) |
| zivtech-a11y-meta-skills | **Absorb unconditionally** (gap-filler) |
| jamieaa64 | Ignore (broken) |
| drupal-canvas-skills | Reference pattern; content is project-specific |
| Omedia | Reference content only |
| aldunchev | Harvest rules only |
| ai_skills | Absorb selectively (drupal-contribute-fix is crown jewel) |
| nonzod | Ignore (strictly inferior to ronaldtebrake) |

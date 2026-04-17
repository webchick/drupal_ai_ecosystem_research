# gkastanis-drupal-workflow — Phase 2 Semantic Analysis

**Source**: https://github.com/gkastanis/drupal-workflow
**Version**: 2.0.1 (2026-04-15)
**License**: MIT (per plugin.json); INDEX.md reports "none" — likely missing LICENSE file at root
**Author**: Zorz (gkastanis)

Evaluated against ai_best_practices locked decisions: gerund-prefix naming, `skills/` at root, `drupal-version`+`status` metadata, Composer-installable, universal scope.

---

## Q0. Primary Mode

**(g) mixed — skill content + agent suite + command suite + live hook/autopilot system + doc-generation toolchain + eval harness.**

Not reducible to one category. This is a full Claude Code **plugin** (per `.claude-plugin/plugin.json`) that bundles: 19 skills, 4 agents, 10 commands, 10 hook entries across 7 event types, ~39 bash scripts, ~26 Python scripts (eval + session-analysis), behavioral + static evals, and the "Magic Loop Autopilot" — a live policy engine. Skill content is one component among many, not the whole.

---

## Q1. Problem Solved (Author's Framing)

Per README.md:1-3 and CLAUDE.md:5: *"A Claude Code plugin for Drupal development with live workflow optimization."* Drives agent behavior on real Drupal 10/11 projects by (a) giving Claude Drupal-specific domain knowledge, (b) generating a three-layer documentation pyramid (raw → structural → semantic) to collapse discovery cost, and (c) enforcing process discipline (plan → delegate → verify) via hooks that detect drift and inject interventions. The eval table (README.md:294-312) frames the measurable problem as *agent speed/cost/quality on Drupal codebase questions* — the headline claim is +61% faster / +19% cheaper with the CLAUDE.md semantic hint.

---

## Q2. Primary Artefact Type

Multi-artefact plugin package. By sophistication:

1. **Hook scripts + policy engine** (`scripts/autopilot-monitor.sh`, `scripts/task-classifier.sh`, `scripts/policies/*.json`) — the "Magic Loop Autopilot"
2. **Generator toolchain** (`skills/structural-index/scripts/` — 13 bash generators parsing Drupal YAML/PHP into structured markdown)
3. **Agents** (4 `.md` files under `agents/` with frontmatter referencing skills)
4. **Slash commands** (10 `.md` files under `commands/`)
5. **SKILL.md library** (19 files) — domain-focused; some are routing/query interfaces rather than pure content
6. **Eval harness** (`eval/eval-skills.py`, `eval/eval-agents.py`, `eval/eval-hooks.py`, behavioral runners, session-replay scoring)

Skills are neither the bulk nor the most novel piece. The autopilot + structural-index generator chain is the distinctive artefact.

---

## Q3. Distribution Model

**Claude Code plugin via `marketplace.json` + `plugin.json`.** Not Composer-installable. Not npm-installable (README mentions npm "future"). Installation is `claude --plugin-dir ./drupal-workflow` or via `~/.claude/plugins/marketplaces/drupal-workflow/`. Per CLAUDE.md:50-58, runtime lives in `~/.claude/plugins/cache/drupal-workflow/drupal-workflow/VERSION/`.

Not compatible with ai_best_practices' locked Composer-install decision — to distribute through Drupal's Composer channel, content would need re-packaging or excerption.

---

## Q4. Standards Conformance — Independently Detected Skill-Unit Convention

**Detected convention**: `skills/<skill-name>/SKILL.md` (one file per skill, named `SKILL.md` exactly, lowercase-kebab-case directory names). Matches agentskills.io / Anthropic convention.

**Frontmatter pattern** (all 19 skills): YAML with `name:`, `description:`, and a nested `metadata:` block containing `status`, `drupal-version`, `last-reviewed`. Example from `skills/drupal-rules/SKILL.md:1-8`:

```yaml
---
name: drupal-rules
description: Core Drupal development rules covering code quality, security, services, and testing verification. ALWAYS consult when writing Drupal code.
metadata:
  status: stable
  drupal-version: "10+"
  last-reviewed: 2026-04
---
```

**Conformance verdict**: Matches ai_best_practices on directory layout and on requiring `drupal-version` + `status`. **Diverges** by adding `last-reviewed` (harmless, useful) and by nesting metadata under a `metadata:` key rather than flat root-level keys. Cosmetic wrapper, not a structural conflict.

---

## Q5. Architectural Pattern — How Guidance Loads at Runtime

Most distinctive aspect. Guidance loads through **five parallel mechanisms**:

### 1. Skill auto-invocation (standard)
Claude Code picks skills via description-matching. Agents in `agents/*.md` declare a `skills:` list in frontmatter (e.g., `agents/drupal-builder.md:19` lists 16 skills) to ensure specific skills are loaded when the agent is spawned.

### 2. Three-layer documentation pyramid (the core innovation)
```
Layer 3: Semantic docs       (AI-generated tech specs, business "why")
Layer 2: Structural index    (script-generated, Drupal-aware "what")
Layer 1: Raw codebase        (Glob/Grep/Read)
```
- **Layer 2** (`skills/structural-index/scripts/generate-all.sh`): 13 bash generators parse `*.services.yml`, `*.routing.yml`, `*.module`, `#[Hook]` attributes, `@Block`/`@ContentEntityType` annotations, `baseFieldDefinitions()`, `*.permissions.yml`, and output 9 structured markdown files + per-bundle JSON schemas + `DEPENDENCY_GRAPH.md` + `FEATURE_MAP.md` into `docs/semantic/structural/`. No AI, no Python, no `yq` — grep/sed state machines.
- **Layer 3** (`@semantic-architect` agent + `/drupal-semantic init`): per-feature tech specs with Logic IDs (`AUTH-L1`, `ACCS-L3`) mapping business logic → `file:line`. Business index (`00_BUSINESS_INDEX.md`) aggregates.
- **CLAUDE.md hint injection** (`scripts/inject-claude-md.sh`): writes a compact `## Codebase` block into the project's CLAUDE.md listing feature counts + Logic ID totals + CODE:Name pairs. Per README.md:305-312 this hint drives the measured +61% speed / +19% cost improvement.

### 3. Routing/query skills (`discover`, `semantic-docs`)
Instead of embedding content, these skills expose **prefix-query scripts**:
- `discover service:entity_type.manager`
- `discover deps:AUTH` (blast radius)
- `discover hook:node_presave`

The skill body (e.g., `skills/discover/SKILL.md`) is a thin wrapper directing the agent to call `$SKILL_DIR/scripts/discover.sh` against generated markdown. Skills act as query interfaces to structured data, not content stores.

### 4. Hook-driven live interventions ("Magic Loop Autopilot")
`hooks/hooks.json` registers 10 hook entries across 7 events. On every `PostToolUse`, `scripts/autopilot-monitor.sh` runs, maintains session state (edits, delegations, skill uses, phase), computes weighted drift score (plan=0.3, delegate=0.3, skill=0.2, verify=0.2 per CHANGELOG.md:7), and fires 3-level escalated interventions (hint → command → suppress, capped at `MAX_FIRES_PER_TYPE=2` with `flock -w 1` serialization). `SessionStart` runs `task-classifier.sh` which classifies the prompt into one of 6 types (implementation/maintenance/debugging/investigation/refactoring/documentation) and loads a matching `scripts/policies/<type>.json`.

### 5. Sensitive-file blocklist + lint gate
`PreToolUse` on Read/Grep/Edit/Write blocks `settings.php`, `.env`, credentials. `PostToolUse` runs `php -l` on edited PHP and staleness-checks structural source files.

**Summary**: Guidance is (a) **pre-built** into a queryable structural graph, (b) **injected** via a CLAUDE.md hint generated per-project, (c) **enforced** via policy-driven hook interventions, and (d) **loaded** via conventional skill auto-invocation. The novelty is (a)-(c) treating Drupal's declarative YAML/annotations as a free knowledge graph, then running a live policy engine on top.

---

## Q6. Naming Convention vs. Gerund-Prefix

Locked convention: **gerund-prefix, verb-in-ing** (e.g., `writing-automated-tests`).

**Audit of 19 skills:**

| Skill | Gerund-prefix? |
|-------|----------------|
| `autopilot-tuner` | No — noun-ish |
| `discover` | No — bare verb |
| `drupal-brainstorming` | 2nd-slot gerund |
| `drupal-caching` | 2nd-slot gerund |
| `drupal-coding-standards` | "coding" used as adjective |
| `drupal-config-management` | No — noun phrase |
| `drupal-conventions` | No — noun |
| `drupal-delegation` | No — noun |
| `drupal-entity-api` | No — noun phrase |
| `drupal-hook-patterns` | No — noun phrase |
| `drupal-rules` | No — noun |
| `drupal-security-patterns` | No — noun phrase |
| `drupal-service-di` | No — noun phrase |
| `drupal-testing` | 2nd-slot gerund |
| `semantic-docs` | No — noun |
| `structural-index` | No — noun |
| `twig-templating` | 2nd-slot gerund |
| `verification-before-completion` | No — noun phrase |
| `writing-plans` | **Yes — strict gerund-prefix match** |

**Verdict**: Only 1/19 (`writing-plans`) matches strictly. 4 more have a gerund as 2nd token (topic-prefix model). 14 are noun phrases. Absorbing content wholesale means renaming ~95%. Significant incompatibility.

The in-repo convention is coherent: `drupal-*` topic prefix for the 13 Drupal-specific content skills, plus 6 verb/noun names for cross-cutting tools. Works internally; just doesn't match the ai_best_practices choice.

---

## Q7. Coverage — 19 Skills (one line each)

| # | Skill | Path | Topic |
|---|-------|------|-------|
| 1 | drupal-rules | `skills/drupal-rules/SKILL.md` | Consolidated mega-skill: services/security/code quality/testing — the "ALWAYS consult" entry |
| 2 | drupal-service-di | `skills/drupal-service-di/SKILL.md` | Service definitions, constructor DI, interface type-hints |
| 3 | drupal-entity-api | `skills/drupal-entity-api/SKILL.md` | Field-type selection matrix, CRUD, view modes, access handlers |
| 4 | drupal-hook-patterns | `skills/drupal-hook-patterns/SKILL.md` | `#[Hook]` attribute pattern (D11), form alters, entity hooks, legacy bridges |
| 5 | drupal-caching | `skills/drupal-caching/SKILL.md` | `#cache` metadata, tags/contexts/bins, `CacheableMetadata`, lazy builders |
| 6 | drupal-security-patterns | `skills/drupal-security-patterns/SKILL.md` | SQLi/XSS prevention, `Xss::filter`, access control, CSRF |
| 7 | drupal-coding-standards | `skills/drupal-coding-standards/SKILL.md` | PHPCS/PHPStan/drupal-check, `declare(strict_types=1)`, `final` classes |
| 8 | drupal-conventions | `skills/drupal-conventions/SKILL.md` | `t()`/TranslatableMarkup, BEM CSS, exception-handling patterns |
| 9 | drupal-config-management | `skills/drupal-config-management/SKILL.md` | `config/sync` vs `install` vs `optional`, config split, readonly, environments |
| 10 | twig-templating | `skills/twig-templating/SKILL.md` | Theme suggestions, `attach_library`, no `\|raw` on user input |
| 11 | drupal-testing | `skills/drupal-testing/SKILL.md` | DDEV/Lando auto-detect, curl smoke tests, `drush eval`, test-script structure |
| 12 | verification-before-completion | `skills/verification-before-completion/SKILL.md` | 5-step gate: IDENTIFY/RUN/READ/VERIFY/THEN with completion-report template |
| 13 | drupal-brainstorming | `skills/drupal-brainstorming/SKILL.md` | 4-step exploration: intent → entity design → architecture sketch → plan |
| 14 | drupal-delegation | `skills/drupal-delegation/SKILL.md` | Agent-dispatch pattern, parallel vs sequential, `@drupal-builder/-reviewer/-verifier` |
| 15 | writing-plans | `skills/writing-plans/SKILL.md` | Implementation-plan template for sub-agents (files table, exact code, verification) |
| 16 | structural-index | `skills/structural-index/SKILL.md` | Layer 2 generator interface — `generate-all.sh`, staleness check, query syntax |
| 17 | semantic-docs | `skills/semantic-docs/SKILL.md` | Navigator for `docs/semantic/` — find-by-Logic-ID, by-feature, by-entity |
| 18 | discover | `skills/discover/SKILL.md` | Prefix-query API (`service:`, `route:`, `hook:`, `deps:`, `impact:`) over structural + semantic docs |
| 19 | autopilot-tuner | `skills/autopilot-tuner/SKILL.md` | Self-improvement — reads intervention logs, proposes policy/threshold changes |

**Coverage assessment**: Strong on Drupal core. Missing/weak: accessibility, migrations (mentioned in `drupal-builder` scope but no dedicated skill), JS/Drupal.behaviors, JSON:API/REST, decoupled/headless, Views/Layout Builder/Paragraphs. 13 content skills + 6 process/tooling skills; boundary is cleaner than most Drupal skill libraries.

---

## Q8. Quality Signals

### Strong
- **Static evals**: `eval/eval-skills.py`, `eval/eval-agents.py`, `eval/eval-hooks.py`. CHANGELOG.md:41 mentions 48 static checks + 23 behavioral eval cases.
- **Behavioral evals**: `eval/behavioral/` has cases per skill (caching, entity-api, hook-patterns, rules, security, service-di, workflow-patterns). `run-behavioral.py` runs across 4 providers.
- **Live empirical evaluation**: README.md:279-366 documents a 9-question × 3-variant × 6-project × 2-run benchmark (54 agent calls) with Sonnet + Opus manual side-by-side review. Published: +61% speed, +19% cost, +0.11 quality. Bias controls listed (randomized variant order, caching disabled).
- **Session replay**: `eval/session-replay/` extracts cases from real session JSONL logs, scores sessions against "magic-era" benchmarks.
- **Changelog discipline**: CHANGELOG.md has bug-fix attribution ("Found by Codex review"), specific numerical parameter changes, root-cause notes. 2.0.1 release specifically calls out 30 bug fixes from 3-way review.
- **Critical-rules doc**: CLAUDE.md captures gotchas with date-of-discovery — SessionStart exit-code requirement (2026-03-14 after weeks of silent failure), hook-timeout kills registry (2026-03-19).
- **Content specificity**: `drupal-rules/SKILL.md:42-46` catches a real trap (*"module prefix may be singular `group_permission` even when module name suggests plural `group_permissions`"*). Not generic.
- **Cross-skill coherence**: Agent `skills:` frontmatter lists are correctly populated; `drupal-delegation` documents composition with `writing-plans` and `drupal-brainstorming`.
- **Self-diagnostic loop**: `autopilot-tuner` reads its own intervention logs. Actually closes the feedback loop.

### Weak
- **LICENSE file missing at repo root** (INDEX.md "License: none"), though plugin.json declares MIT. Real compliance gap.
- **No composer.json / package.json** — undistributable outside the Claude Code plugin ecosystem.
- **Testing against exactly one project** (CLAUDE.md:123 references `/home/zorz/sites/timan` as default). Generators may over-fit to one codebase's YAML style (the "~95% case" admission in README.md:261).
- **No `AGENTS.md`** — diverges from the agentskills.io convention.
- **Tight coupling to DDEV** as primary (drupal-testing does auto-detect Lando/native as fallback).

---

## Q9. Notable Innovations (Concrete)

1. **Three-layer doc pyramid with script-generated Layer 2**: Uses Drupal's declarative architecture as a free knowledge graph. `skills/structural-index/scripts/generate-all.sh` calls 13 generators (services, routes, hooks, plugins, entities, schemas, base-fields, permissions, methods, dependency-graph, feature-map). No Python or `yq` dep — grep/sed state machines. Covers ~80% of structural graph per README.md:205.
2. **Measured context efficiency**: `/discover --prime` outputs ~2,500 tokens (~190 lines) covering 26 features + 433 Logic IDs for an 85k-LOC codebase (README.md:381-385) — "~34 lines of code awareness per token spent." Measured, not claimed.
3. **CLAUDE.md hint beats invisible docs**: README.md:332-337 — *"docs without hint are nearly useless"*. Semantic docs alone get +12% speed; the CLAUDE.md pointer does the heavy lifting (+61%). Transferable lesson about prompt-level pointers.
4. **Live policy engine** with weighted drift scoring, 3-level escalation, `MAX_FIRES_PER_TYPE=2` cap, `flock -w 1` serialization for concurrent-tool-call race, policy files per task-type. Well beyond the typical "hook that echoes a reminder."
5. **Self-tuning**: `autopilot-tuner` skill + `diagnose.py` + `analyze-replays.py --compare` measures before/after effectiveness of plugin changes. Actually uses the data the plugin generates.
6. **Prefix-query DSL over generated markdown** (`discover service:`, `deps:`, `impact:`) — treats markdown as a queryable DB, avoids re-embedding content into LLM prompts.
7. **Minimal-dep generator stack**: 13 generators in pure bash. Portable to any DDEV/plain host.
8. **Gotcha-driven docs**: CLAUDE.md records specific production bugs with dates and fixes (SessionStart exit-code, hook-timeout kills registry, plugin cache desync). Institutional memory, not generic advice.
9. **Session replay scoring** (`eval/session-replay/pattern-score.py`): scores real session JSONL against benchmark patterns. Rare.
10. **Multi-provider behavioral eval runner** (Claude/Codex/Gemini/Mistral per CHANGELOG.md:40).

---

## Q10. Weaknesses / Gaps (Direct)

1. **Fundamentally a plugin, not a library.** Non-trivial to extract content for use elsewhere. Skills lean on `$SKILL_DIR/scripts/*.sh` interpolation that only resolves inside the Claude Code plugin runtime.
2. **Naming convention mismatch**: 18/19 skills don't match gerund-prefix. Absorbing content wholesale means renaming.
3. **`drupal-rules/SKILL.md` is 183 lines** of mixed-topic content (services + security + code quality + testing) — violates one-skill-per-topic principle. Compare to ai_best_practices' intended granular split. The "ALWAYS consult" mega-skill is convenient but fights auto-invocation.
4. **Autopilot-specific verbiage pollutes content skills.** `drupal-rules/SKILL.md:14-16` has an "Autopilot Interventions (MANDATORY)" section only meaningful if the hook system is loaded. Coupling leaks into guidance.
5. **Scope: Drupal 10/11 + DDEV + PHP 8.2+ + custom-module focus.** Site-builders, decoupled/headless, JS Drupal.behaviors, Layout Builder, Views, Paragraphs get zero direct coverage.
6. **Plugin-cache drift** is a recurring operational issue (CLAUDE.md:46-58, CHANGELOG.md:21).
7. **LICENSE file missing** at repo root per INDEX.md.
8. **Assumes `docs/semantic/` exists.** For projects that haven't run bootstrap, `discover` / `semantic-docs` are largely inert. `structural-index` is mandatory to unlock most value.
9. **Eval benchmarked on one team's projects** (technocan/elvial/candia-b2b/hellasfin/istolab/timan — apparently all Greek-hosting/SME Drupal codebases). Generalization unproven.
10. **No migration, accessibility, or JSON:API skills.** Notable for a "complete Drupal workflow" plugin.
11. **`description:` frontmatter on some skills packs trigger phrases** (`autopilot-tuner/SKILL.md:3-9` lists literal trigger strings like *"tune autopilot", "autopilot stats", "self-improve"*). Prompt-engineered the auto-invocation matcher — may not survive matcher changes.
12. **Coupling between skills and policies**: `drupal-rules` pre-refers to autopilot interventions; agent skill lists reference skills that only make sense together. Extracting one means pulling 3-5 others.

---

## Q11. Compatibility With ai_best_practices Decisions

| Decision | Status | Notes |
|----------|--------|-------|
| Skill naming: gerund-prefix, verb-in-ing | **Incompatible** — 1/19 match strictly, 14/19 are noun phrases, 4 have gerund as 2nd token |
| Directory: `skills/` at root | **Compatible** — 19 files under `skills/`, none under `.claude/skills/` |
| Metadata: minimal `drupal-version` + `status` only | **Mostly compatible** — has both, adds `last-reviewed` (harmless), nests under `metadata:` key (cosmetic divergence from flat layout) |
| Distribution: Composer-installable | **Incompatible** — distributed as Claude Code plugin via `.claude-plugin/marketplace.json`, no composer.json |
| Scope: universal Drupal guidance | **Partially compatible** — 13 Drupal content skills are universal, but 6 skills (discover, semantic-docs, structural-index, drupal-delegation, autopilot-tuner, verification-before-completion) are specific to this plugin's generated-doc pipeline and hook runtime |

**Net**: Content is largely universal-reusable; packaging and naming are not. To absorb into ai_best_practices, skills would need renaming, `metadata:` flattening, and decoupling from `$SKILL_DIR/scripts/*.sh` paths.

---

## Q12. Relationship to Surge

**Uncertain — flag for Phase 3 synthesis.** Surge has not been provided directly in this task; inference only.

Likely relationship axes:
- **Surge** (per typical characterization) is a large cross-domain skill library with gerund-prefix naming and Composer distribution. If so, drupal-workflow shares **~50% content surface** (security, testing, caching, coding standards, hooks, entities, services, twig, config) but at **different granularity**: drupal-workflow consolidates into `drupal-rules` + topic skills; Surge presumably splits by action (`writing-entity-crud`, `adding-cache-tags`).
- Surge likely does not have: the structural-index generator pipeline, the autopilot live-policy engine, the session-replay eval framework, the CLAUDE.md hint injector, or the prefix-query DSL. These are drupal-workflow's distinctive contributions.
- Surge likely does better: packaging (Composer), naming consistency, universal scope, skill granularity.

**Pending** confirmation against Surge once that repo is in the analysis context. Speculative — do not treat as final.

---

## Q13. Verdict

**Reference — with selective absorption.**

Breakdown:
- **Absorb** (content for ai_best_practices): after renaming and decoupling from plugin runtime, the Drupal-specific content skills. Specifically: `drupal-caching`, `drupal-security-patterns`, `drupal-hook-patterns` (D11 `#[Hook]` pattern), `drupal-config-management` (install vs optional distinction), `drupal-service-di`, `drupal-entity-api` field-type matrix, `twig-templating`, `drupal-testing` curl-smoke-test patterns, `verification-before-completion` gate. Content quality is high and often catches real traps (singular-vs-plural service prefixes, auto-escape rules, cache-metadata requirements on render arrays). Estimated 6-8 high-value absorbable skills after rewriting.
- **Reference** (design inspiration, not absorption): the three-layer doc pyramid, the structural-index generator approach, the CLAUDE.md hint injection, the prefix-query DSL. Design patterns that demonstrate "declarative codebases are queryable graphs" — cite and benchmark, don't vendor.
- **Collaborate** (potentially): author has demonstrated engineering rigor — measured evals, changelog discipline, bug-fix attribution, self-diagnostic loops. Worth inviting into ai_best_practices conversations, particularly on measurement methodology.
- **Ignore**: the plugin/hook/autopilot runtime itself. Not appropriate for a Composer-distributed universal library. Different delivery mechanism.

**Key constraints for absorption**:
1. Must rename per gerund-prefix locked convention.
2. Must remove `$SKILL_DIR/scripts/*.sh` references and autopilot-specific language.
3. Must break up `drupal-rules` into topic-specific skills that auto-invoke cleanly.
4. Must flatten metadata from nested `metadata:` to root keys.
5. Must drop `last-reviewed` unless ai_best_practices wants to add it as an approved extension.

This repo is the most sophisticated Drupal-agent tooling seen in the batch. Content is good, infrastructure around it is impressive but project-specific, and the naming/packaging mismatch is real. Extract the jewels, leave the setting.

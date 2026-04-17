# drupal_devkit — Phase 2 Tier 1 Semantic Analysis

**Repo**: `/home/pointblank/research/repos/drupal_devkit/`
**Source**: https://git.drupalcode.org/project/drupal_devkit
**Last commit**: 2026-04-17 (actively live-developed)
**Maintainer**: FreelyGive (hello@freelygive.org); contributor AJV009 (DDEV add-on subtree)
**License**: GPL-2.0-or-later
**Self-framing** (README.md:3-5): "Cross-harness Drupal AI coding toolkit. A marketplace of marketplaces for Drupal AI skills, built as the reference implementation of `ai_best_practices`."

---

## Q0. Primary mode

**Mixed (b) distribution tool + (a) skill library + (c) spec author**, with (b) dominant.

- (a) Skill library: ships 36 canonical `drupal-core` skills + 1 `using-drupal-devkit` orientation skill
- (b) Distribution tool: Python CLI (`drupal-devkit` entry point, `src/drupal_devkit/cli.py`) that clones git-based marketplace sources, emits per-harness builds, and installs to 8 harnesses
- (c) Spec author: authors the `drupal-marketplace.json` v1 spec (`docs/source-spec-v1.md`) and its JSON Schema (`schemas/drupal-marketplace-v1.json`) — intended as a Drupal-community-generic standard

Per the Q5 re-framing: as (b) it aggregates by registering git URLs as marketplace sources (default: `drupal-devkit` + `ai_best_practices` + `drupal-canvas-plugin`, `install.sh:95-100`), cloning to `~/.cache/drupal-devkit/sources/<name>/`, reading each source's `drupal-marketplace.json` manifest (or heuristic fallback), and tracking enabled plugins in `~/.config/drupal-devkit/state.json`.

---

## Q1. Problem solved (author's framing)

README.md:3-5 (verbatim):
> "Cross-harness Drupal AI coding toolkit. A marketplace of marketplaces for Drupal AI skills, built as the reference implementation of `ai_best_practices`."

README.md:7-9:
> "Subscribe to multiple git-based skill sources, enable/disable plugins per harness, and install to 8 Tier 1 AI coding harnesses from a single CLI... Ships 36 bundled Drupal skills, a DDEV add-on, a universal curl-bash installer, and a 3-layer eval harness (Gemma / Haiku / Opus)."

AGENTS.md:43-49 (self-positioning re: ai_best_practices):
> "`drupal-devkit` implements the guidance in https://git.drupalcode.org/project/ai_best_practices as executable skills. When in doubt about what pattern to follow, `ai_best_practices` is authoritative. If a skill in devkit disagrees with a guidance document in ai_best_practices, the guidance wins — flag the divergence as a bug to fix."

Problem framing: a single project cannot be both the canonical-guidance-authoring body AND the cross-harness distribution mechanic AND the skill library — so `drupal_devkit` explicitly splits the roles and defers authorship-of-canon to `ai_best_practices`, keeping for itself the aggregator/distributor/reference-impl role.

---

## Q2. Primary artefact type

Three artefact types, layered:

1. **Python package** (primary artefact) — `pyproject.toml:6-28`, published as `drupal-devkit` via `uv tool install` from git. Entry point `drupal-devkit = "drupal_devkit.cli:main"` (pyproject.toml:38-39).
2. **SKILL.md files** (content artefact) — 37 canonical skills (36 in `plugins/drupal-core/skills/` + 1 in `skills/using-drupal-devkit/`), rendered into `build/<harness>/<plugin>/` by per-harness emitters (223 SKILL.md files total counting rendered copies).
3. **Spec + schema** (standard artefact) — `drupal-marketplace.json` manifest spec (`docs/source-spec-v1.md`) + JSON Schema (`schemas/drupal-marketplace-v1.json`) intended for adoption by any consuming tool.

---

## Q3. Distribution model

**NOT Composer.** Three distribution channels, none PHP-native:

1. **Universal curl-bash bootstrapper** (`install.sh`, README.md:254-258):
   ```
   curl -sSL https://git.drupalcode.org/project/drupal_devkit/-/raw/main/install.sh | bash
   ```
   Script detects env + installed harnesses (`install.sh:29-39`), installs `uv` if missing (L71-79), runs `uv tool install drupal-devkit --from "git+..."` (L83), then registers the 3 default marketplace sources via `drupal-devkit marketplace add` (L95-100).

2. **uv tool install** (direct, README.md:284):
   ```
   uv tool install drupal-devkit --from "git+https://git.drupalcode.org/project/drupal_devkit.git"
   ```

3. **DDEV add-on** (README.md:272-279, `ddev/install.yaml`):
   ```
   ddev add-on get AJV009/ddev-drupal-devkit
   ```
   Subtree-linked from `ddev/` in this repo to `github.com/AJV009/ddev-drupal-devkit` (CLAUDE.md:11-14). Installs `drupal-devkit` on the host, optionally bootstraps Claude Code inside the DDEV web container, registers host commands `ddev ai`, `ddev ai-devkit`, `ddev claude`.

**Install targets per harness** (README.md:418-428):

| Harness | Plugin dir (local) | Context file |
|---|---|---|
| Claude Code | `.claude/plugins/` | `AGENTS.md` |
| Copilot CLI | `.github/copilot/plugins/` | `AGENTS.md` |
| Codex | `.agents/plugins/` | `AGENTS.md` |
| Cursor | `.cursor/plugins/` | `.cursor/rules/drupal-devkit.mdc` |
| Gemini CLI | `.gemini/extensions/` | `GEMINI.md` |
| Kiro | `.kiro/plugins/` | `AGENTS.md` (+ `.kiro/skills/`) |
| OpenCode | `.opencode/plugins/` | `AGENTS.md` (+ `.opencode/skills/`) |
| Hermes | `.hermes/plugins/` | `AGENTS.md` (+ `.hermes/skills/drupal/`) |

Global (user-level) mode via `--global` flag; default is project-local. Kiro/OpenCode/Hermes also receive skills into native auto-discovery dirs.

State: `~/.config/drupal-devkit/state.json` (registered sources + enabled plugins); cache: `~/.cache/drupal-devkit/sources/<name>/` (pinned git clones).

---

## Q4. Standards conformance + skill-unit convention

**Skill unit**: `<skill-name>/SKILL.md` with YAML frontmatter, colocated `references/` allowed. Example (`plugins/drupal-core/skills/drupal-entity-api/SKILL.md:1-8`):

```yaml
---
name: drupal-entity-api
description: Field type selection, entity CRUD operations, view modes, and content modeling patterns for Drupal 10/11. Use when designing content types, selecting field types, or working with the Entity API.
license: GPL-2.0-or-later
metadata:
  drupal:
    plugin: drupal-core
    version: 11.0+
---
```

**Frontmatter schema observed**: `name`, `description`, `license`, `metadata.drupal.plugin`, `metadata.drupal.version`. Optional `version` (`accessibility/SKILL.md:4`). Richer than `ai_best_practices`'s locked minimal schema (`drupal-version` + `status`) — `plugin` field is added for marketplace grouping.

**Conformance to ai_best_practices LOCKED decisions** (user-supplied):

| Decision | ai_best_practices LOCKED | drupal_devkit implementation | Match? |
|---|---|---|---|
| Naming: gerund-prefix, verb-in-ing | `writing-automated-tests` | `drupal-entity-api`, `drupal-testing`, `migrate`, `debug`, `using-drupal-devkit`, `twig-templating` | **NO** — topic-noun + `drupal-` prefix pattern; only a few are gerund form |
| Directory: `skills/` at root | required | `skills/using-drupal-devkit/` (root) + `plugins/drupal-core/skills/` (nested under plugin) | **Partial** — root `skills/` exists with 1 skill; the 36 canonical skills live under `plugins/drupal-core/skills/` (explicit nested path, permitted by v1 spec §4 `paths.skills` override) |
| Metadata: minimal (`drupal-version` + `status` only) | required | `drupal-version` present (as `metadata.drupal.version`), `status` absent; adds `plugin` grouping + top-level `license` | **Divergent** — adds metadata, lacks `status` |
| Distribution: Composer-installable | required | uv/pip Python + curl-bash + DDEV (NO `composer.json`, INDEX.md:48) | **NO** — deliberately non-Composer |
| Scope: universal Drupal guidance | required | Yes, `drupal-core` = "36 Drupal 11+ skills" (universal) | **Yes** |

The mismatches are deliberate trade-offs (plugin grouping for marketplace, Python tooling for cross-harness emission). The divergence-as-bug policy (AGENTS.md:47-49) implies devkit should eventually converge toward ai_best_practices naming/metadata once those decisions land.

**Own spec**: `drupal-marketplace.json` (v1) with 4-level conformance ladder (`docs/source-spec-v1.md` §5):

- **L0 Heuristic** — no manifest required; auto-discover from `skills/`
- **L1 Manifest** — `drupal-marketplace.json` with `name`/`description`/`version` + optional plugin grouping
- **L2 Full Metadata** — adds `license`, `maintainer`, per-plugin descriptions
- **L3 Shared Eval** — evals runnable via installer's eval harness wrapper

---

## Q5. Architectural pattern — "marketplace of marketplaces"

**Three-level hierarchy** (README.md:376-380):

```
marketplace (git repo)
  -> plugin (group of related skills)
    -> skill (single SKILL.md + references/)
```

**Marketplace sources** (default, `install.sh:95-100`):

| Source | Git | Ref | Description |
|---|---|---|---|
| drupal-devkit | git.drupalcode.org/project/drupal_devkit | main | 36 bundled Drupal 11+ skills |
| ai_best_practices | git.drupalcode.org/project/ai_best_practices | 1.0.x | Community Drupal AI guidance |
| drupal-canvas-plugin | git.drupalcode.org/project/drupal_canvas_plugin | 1.x | Canvas + migration skills (3 plugins, 25 skills) |

**Aggregation flow**:

1. `drupal-devkit marketplace add <git-url> --ref <branch> --name <name>` — clones to `~/.cache/drupal-devkit/sources/<name>/`, pins to commit (docs/source-spec-v1.md:207-212).
2. Loader (`src/drupal_devkit/marketplace/loader.py`) reads `drupal-marketplace.json` manifest; falls back to heuristic L0 scan of `skills/`.
3. Plugins register in state (`~/.config/drupal-devkit/state.json`).
4. `drupal-devkit plugin enable <source>/<plugin>` activates for sync.
5. Generator (`src/drupal_devkit/generator/`) emits per-harness output into `build/<harness>/<plugin>/`.
6. Installer (`src/drupal_devkit/installer/targets/{claude_code,codex,copilot_cli,cursor,gemini_cli,hermes,kiro,opencode}.py`) copies output into each harness's plugin dir.

**Per-harness emitters** (`src/drupal_devkit/generator/emitters/`): `claude.py`, `codex.py`, `copilot.py`, `cursor.py`, `gemini.py`, `hermes.py`, `kiro.py`, `opencode.py`, plus `contextfiles.py` and `base.py`. Handle per-harness quirks (README.md:202-209):

- Codex lacks `agents`/`hooks`/`commands` → agents become `prompts/<name>-prompt.md`
- Gemini has no subagent support → agents as prompts + `GEMINI.md` `@-imports`
- Cursor uses `.cursor-plugin/plugin.json` + `hooks-cursor.json`
- Kiro/OpenCode/Hermes get Claude-only syntax stripped (`${CLAUDE_SKILL_DIR}`, backtick-exec, `$N` substitution)
- Hermes category-organizes under a `drupal/` subdirectory

**Conformance ladder** enables progressive adoption: L0 works without changes, L1 adds manifest, L2 adds metadata, L3 participates in shared eval runs.

**Eval harness** (`src/drupal_devkit/eval_runner/`, `evals/`, README.md:255-269): 3-tier deterministic grading with 4 assertion types (`must_contain_any`, `must_not_contain`, `syntax_check`, `check_markdown_structure`) — L1 Gemma 3 4B (Ollama, OSS floor), L2 Haiku 4.5 (daily use), L3 Opus 4.6 (ceiling). Sets live under `evals/<skill-name>/evals.json` (e.g. `evals/drupal-testing/evals.json` has 5 cases).

---

## Q6. Naming convention for bundled skills

Observed in `plugins/drupal-core/skills/`:

- **`drupal-<topic>`** dominant (~25 skills): `drupal-caching`, `drupal-coding-standards`, `drupal-config-management`, `drupal-content-moderation`, `drupal-contrib-mgmt`, `drupal-contribute-fix`, `drupal-conventions`, `drupal-ddev`, `drupal-docs-explorer`, `drupal-eca`, `drupal-entity-api`, `drupal-field-system`, `drupal-frontend-expert`, `drupal-hook-patterns`, `drupal-json-api`, `drupal-rules`, `drupal-sdc`, `drupal-search-api`, `drupal-security-audit`, `drupal-security-patterns`, `drupal-service-di`, `drupal-storybook`, `drupal-testing`, `drupal-views`, `drupal-visual-regression`, `drupal-at-your-fingertips`
- **Bare topic noun** — `accessibility`, `debug`, `drush`, `migrate`, `performance`, `refactor`, `twig-templating`, `custom-drupal-module`
- **`-rt` suffix variant** — `drupal-coding-standards-rt` (review-time)
- **`using-<plugin>` orientation** — `using-drupal-core`, `using-drupal-devkit`

**Compliance with ai_best_practices gerund-in-ing decision**: NOT followed. Only `twig-templating` and the `using-*` skills are gerund-adjacent. The rest are topic-noun form. This is a material divergence.

---

## Q7. Coverage — 36 bundled drupal-core skills

All in `plugins/drupal-core/skills/` (from `drupal-marketplace.json:18-53`, verified via `ls`). Grouped by topic:

**Architecture / APIs (8)**: `drupal-entity-api`, `drupal-field-system`, `drupal-hook-patterns`, `drupal-service-di`, `drupal-json-api`, `drupal-search-api`, `drupal-views`, `drupal-rules`

**Frontend / Theming (5)**: `drupal-sdc`, `drupal-storybook`, `twig-templating`, `drupal-frontend-expert`, `accessibility`

**Testing / QA (5)**: `drupal-testing`, `drupal-visual-regression`, `drupal-security-audit`, `debug`, `refactor`

**Config / Ops (5)**: `drupal-config-management`, `drupal-content-moderation`, `drupal-contrib-mgmt`, `drupal-contribute-fix`, `drupal-ddev`

**Conventions / Standards (4)**: `drupal-coding-standards`, `drupal-coding-standards-rt`, `drupal-conventions`, `drupal-at-your-fingertips`

**Security / Performance (3)**: `drupal-security-patterns`, `performance`, `drupal-caching`

**Tooling (3)**: `drush`, `migrate`, `drupal-eca`

**Meta / Orientation (3)**: `custom-drupal-module`, `drupal-docs-explorer`, `using-drupal-core`

**Plus shipped**: `plugins/drupal-core/agents/drupal-expert.md` (1 subagent) + `plugins/drupal-core/hooks/` (hooks.json, hooks-cursor.json, run-hook.cmd, session-start).

---

## Q8. Quality signals

Strong multi-axis quality infrastructure:

**Tests (230 pytest tests, CLAUDE.md:34-36, CHANGELOG.md:29)**:
- `tests/marketplace/` — 10 files: cache, cli_marketplace, cli_plugin, install, integration, loader, manifest, presets, state, sync
- `tests/generator/` — 13 files covering 8 emitters + build_integration + transformer + validator + loader + bumper + meta-plugin + smoke-install-parsing + generate_plugin
- `tests/installer/` — 12 files: cli_install, ddev, detector, doctor, flow, targets for 5 named harnesses + runtime
- `tests/eval_runner/` — 4 files: claude_cli_runner, grader, harness, runners_mock
- `tests/standardization/` — frontmatter migration + portability audit
- `tests/install_sh/test_install_sh.bats` — bats tests for curl-bash script

**Eval harness** (3-layer, README.md:255-269): L1 Gemma 3 4B (Ollama), L2 Haiku 4.5, L3 Opus 4.6; 4 deterministic assertion types; `drupal-devkit eval <skill> [--layer all|l1|l2|l3] [--trials N]`.

**CI**:
- `.github/workflows/sync-community-plugins.yml` — weekly Monday 06:00 UTC cron + on-push; validates community-registry.json
- `.github/workflows/validate-community-plugin-pr.yml` — PR validation for community plugin submissions

**Versioning**: `.version-bump.json` for lockstep manifest bumps (inspired by obra/superpowers, README.md:321); `drupal-devkit bump {major|minor|patch}`; `uv.lock` present.

**Commits**: last commit 2026-04-17, actively live-developed. CHANGELOG.md: 1.0.0 (2026-03-24) → 1.0.1 → 1.1.0 (2026-03-25) → 2.0.0 (2026-04-17, marketplace-of-marketplaces rewrite).

**Other**: `scripts/portability-audit.py` (Claude-syntax leakage check), `scripts/migrate-frontmatter.py`, `tests/standardization/audit-findings.md`, `docs/superpowers/plans/` + `docs/superpowers/specs/`, `.claude-plugin/marketplace.json` + `plugin.json`.

---

## Q9. Notable innovations

1. **8 Tier 1 harness emission** — widest harness coverage observed in this sweep. `src/drupal_devkit/generator/emitters/` has 9 files (8 harnesses + contextfiles) with Claude-only-syntax stripping.
2. **"Marketplace of marketplaces"** — three-tier `source → plugin → skill` with cache + state tracking, enable/disable per plugin, presets (`drupal-quickstart`, `canvas-dev`).
3. **`drupal-marketplace.json` spec v1 + conformance ladder** — published JSON Schema, versioned, explicitly Drupal-community-generic (§1: "any tool can consume it"). Complementary with Ronald's Composer approach (§3.1).
4. **Per-harness context file generation** — `contextfiles.py` auto-composes AGENTS.md / GEMINI.md / `.cursor/rules/drupal-devkit.mdc` from all enabled plugins' fragments.
5. **Curl-bash universal installer with env detection** — detects installed harnesses, transitively installs `uv`, registers 3 default sources non-interactively.
6. **3-layer eval harness with OSS floor** — Gemma-on-Ollama lets contributors eval without API keys; deterministic assertions avoid LLM-judge expense.
7. **DDEV add-on via git subtree** — `ddev/` subtree-linked to `github.com/AJV009/ddev-drupal-devkit`; host commands `ddev ai`, `ddev ai-devkit`, `ddev claude`; can bootstrap Claude Code inside the web container.
8. **Portability audit + frontmatter migration** — scripts + standardization tests enforce the syntax-stripping contract.
9. **Reference-implementation positioning** — explicit deference to `ai_best_practices` (AGENTS.md:43-49, README.md:238-240).
10. **Community plugin registry** — `community-registry.json` + `.claude-plugin/marketplace.json` (references `gkastanis/drupal-workflow` as GitHub-based community plugin) with automated weekly sync.

---

## Q10. Weaknesses / gaps

1. **Naming drift from ai_best_practices** — 36 drupal-core skills use `drupal-<topic>` / topic-noun form, not gerund-in-ing. "Divergence is a bug" policy implies mass rename debt.
2. **Metadata mismatch** — no `status`; adds `plugin`, `license`, `version` beyond ai_best_practices's minimal `drupal-version` + `status`. Schemas need reconciliation.
3. **Python-first install friction** — Drupal devs live in Composer; `uv tool install` and `curl | bash` are outside the normal Drupal dependency flow. DDEV add-on mitigates partially.
4. **No `composer.json`** (INDEX.md:48) — cannot be pulled into a Drupal project the Drupal way.
5. **Host-level cache + state** — `~/.cache/drupal-devkit/` and `~/.config/drupal-devkit/state.json` are user-global. Multi-project setups share cache; each project needs local install.
6. **No formal skill-name conflict resolution** when two sources expose same-named skills — not documented.
7. **Claude-centric frontmatter emission** — Claude is de-facto canonical; other harnesses get syntax-stripped builds.
8. **Eval coverage partial** — only 2 eval sets in `evals/` (drupal-testing, drupal-security-patterns); 34 of 36 drupal-core skills lack L3-runnable cases. L3 claim is aspirational for most skills.
9. **Single maintainer org** (FreelyGive + AJV009) — bus factor; no broad contributor ladder visible.
10. **Missing `status` lifecycle field** — no experimental / stable / deprecated distinction.

---

## Q11. Compatibility with ai_best_practices

**Direction of dependency**: drupal-devkit registers ai_best_practices as a default marketplace source (`install.sh:97-98`) → drupal-devkit is the consumer, ai_best_practices is the producer.

**What drupal-devkit expects from ai_best_practices at each level**:

| Level | ai_best_practices must ship | Gain |
|---|---|---|
| L0 Heuristic (min) | `skills/<name>/SKILL.md` at repo root; optional `agents/*.md` | Works out of box; 1 flat plugin named `ai_best_practices` (README.md:311: "2 skills, 4 agents") |
| L1 Manifest | Add `drupal-marketplace.json` at root with `name`, `description`, `version` | Explicit plugin grouping, better UX in `drupal-devkit plugin list` |
| L2 Full metadata | Add `license`, `maintainer`, per-plugin descriptions | Richer `plugin info` output |
| L3 Shared eval | Ship `evals/<skill>/evals.json` with 4-assertion vocabulary | `drupal-devkit eval ai_best_practices/<plugin>` works end-to-end |

**Minimum required for optimal integration**:

1. **Root `skills/` directory** with `skills/<name>/SKILL.md` per skill (matches ai_best_practices's LOCKED "skills/ at project root" decision — already aligned).
2. **SKILL.md frontmatter with `name` + `description`** — devkit loader reads these for enumeration. Already aligned with minimal schema.
3. **`drupal-marketplace.json` at root** (recommended L1+) for plugin grouping. Example (docs/source-spec-v1.md §6):
   ```json
   {
     "name": "ai-best-practices",
     "description": "Canonical Drupal AI guidance",
     "version": "1.0.x",
     "plugins": [{ "name": "canonical-guidance", "skills": ["writing-automated-tests", "how-to-write-documentation"] }]
   }
   ```
4. **Stable branch ref** — devkit pins to `1.0.x` (`install.sh:97`). Branch must exist + receive curated releases.
5. **License field** — already locked GPL-2.0-or-later (matches).

**What ai_best_practices should NOT ship** to stay independent:
- No Python tooling / pyproject.toml
- No per-harness emission (devkit does that)
- No eval runner (just `evals.json` files)

**Convergence work on drupal-devkit's side**:
1. Rename drupal-core skills to gerund-in-ing where sensible
2. Add `status` field to frontmatter
3. Align `metadata.drupal.version` → top-level `drupal-version`
4. Optionally publish `drupal-marketplace.json` for ai_best_practices itself (L1 is low-cost and unlocks UX; spec is Drupal-community-generic, not devkit-proprietary)

---

## Q12. Relationship to Surge

Both aggregators, structurally different, **complementary not competing** (with overlap).

| Axis | Surge | drupal_devkit |
|---|---|---|
| Distribution | Composer plugin (PHP-native) | uv/Python + curl-bash + DDEV |
| Discovery | Scans `vendor/*/*/skills/` post-install | Clones git URLs to `~/.cache/`, reads manifest |
| Source of truth | `composer.json require:` | `~/.config/drupal-devkit/state.json` |
| Harness coverage | Claude Code focus | 8 Tier 1 harnesses with emitters |
| Per-harness emission | Passthrough (skills in as-is) | Active transformation + Claude-syntax stripping |
| Scope | Project-local (vendor/) | Project-local default + `--global` |
| Drupal-native feel | Yes (lives in composer.json) | No (Python tool, out-of-band) |
| Eval integration | None documented | 3-layer eval harness |
| Spec authorship | None | Authors `drupal-marketplace.json` spec |
| Skill-author adoption | Composer package | Git repo + optional manifest |

**Compete / complement / conflict**:

- **Compete**: skill authors picking one distribution path lose the other audience.
- **Complement**: a skill repo can ship both `composer.json` (Surge) AND `drupal-marketplace.json` (devkit). ai_best_practices already uses `composer type:package + reference` internally (docs/source-spec-v1.md §3.1) — orthogonal to both.
- **Conflict**: not technical (different layers — Composer = build; devkit = user/CLI). But governance rivals for "the way to install Drupal AI skills." Surge is better-fit for existing Drupal workflow; devkit is better-fit for cross-harness portability (Composer can't do harness-agnostic emission without a tool runtime).

**Realistic endpoint**: Surge = canonical way to pull skills into a Drupal project for Claude Code specifically; devkit = canonical way to install those same skills into the other 7 harnesses. ai_best_practices publishes in a form consumable by both (root `skills/` + `drupal-marketplace.json` + optionally a Composer package descriptor).

---

## Q13. Verdict — **Collaborate** (strongly indicated)

Justification:

1. **Self-declared reference-implementation role** (README.md:3-5, AGENTS.md:43-49) — devkit positions itself as downstream of ai_best_practices; treats divergence as a bug. Collaborator posture, not competitor.
2. **Registers ai_best_practices as a default marketplace source** (`install.sh:97-98`, README.md:311, 386) — default install pulls ai_best_practices into every user's setup. ai_best_practices already has devkit-mediated distribution leverage.
3. **Spec is deliberately community-generic** (docs/source-spec-v1.md §1) — `drupal-marketplace.json` offered as community standard, not devkit-proprietary.
4. **Small technical surface to optimally integrate**: root `skills/`, SKILL.md frontmatter (already locked), optional `drupal-marketplace.json`.
5. **Harness reach**: reimplementing 8-harness emission would cost ai_best_practices months; collaborating gets it for free.
6. **Governance**: FreelyGive + webchick + Marcus Johansson cited as collaborators in ATTRIBUTION.md; pre-existing working relationship.
7. **Symmetric convergence**: ai_best_practices gets cross-harness distribution + eval harness + installer UX; devkit gets canonical naming/metadata + ownership of "what is a good Drupal AI skill."

**Concrete collaboration actions**:
- ai_best_practices ships `drupal-marketplace.json` L1+ (one-file change)
- ai_best_practices stays on `1.0.x` branch (already devkit's pinned ref)
- drupal-devkit commits to adopt ai_best_practices naming convention for drupal-core skills; adds `status` to frontmatter
- Joint agreement on minimal frontmatter schema; devkit's richer fields become advisory extensions
- drupal-devkit = canonical distribution layer; ai_best_practices = canonical content/standards layer; Composer path (Surge) preserved for Drupal-native users

**Against absorb**: ai_best_practices absorbing devkit means becoming a Python-tool maintainer with 8-harness engineering surface — outside its scope.
**Against reference-only**: too weak; devkit is already pulling ai_best_practices downstream. Formalize the value that's accruing anyway.
**Against ignore**: devkit is the most sophisticated Drupal AI skill distribution system observed. Ignoring leaves ai_best_practices content-only with no execution vehicle.

---

## Cross-cutting flags / uncertainties

- `drupal-marketplace.json` `skills[]` array (lines 18-53) lists 36 entries total matching `ls` of `plugins/drupal-core/skills/` = 36 dirs. Confirmed 36 drupal-core skills + 1 separate `using-drupal-devkit` under `/skills/` (total 37 canonical).
- `twig-templating` is the only drupal-core skill with gerund-in-ing form matching ai_best_practices naming.
- Plugin name collision risk: `drupal-devkit/drupal-core` + hypothetical `ai_best_practices/drupal-core` would collide at plugin level; namespacing is by source so probably OK, but worth formalizing.
- Hermes harness newest/least-documented; Hermes skills go under `.hermes/skills/drupal/` subdirectory implying Hermes expects category-namespaced skill trees.

---

## Key file paths

- `/home/pointblank/research/repos/drupal_devkit/README.md`
- `/home/pointblank/research/repos/drupal_devkit/AGENTS.md`
- `/home/pointblank/research/repos/drupal_devkit/CLAUDE.md`
- `/home/pointblank/research/repos/drupal_devkit/drupal-marketplace.json`
- `/home/pointblank/research/repos/drupal_devkit/schemas/drupal-marketplace-v1.json`
- `/home/pointblank/research/repos/drupal_devkit/docs/source-spec-v1.md`
- `/home/pointblank/research/repos/drupal_devkit/install.sh`
- `/home/pointblank/research/repos/drupal_devkit/pyproject.toml`
- `/home/pointblank/research/repos/drupal_devkit/src/drupal_devkit/generator/emitters/`
- `/home/pointblank/research/repos/drupal_devkit/src/drupal_devkit/installer/targets/`
- `/home/pointblank/research/repos/drupal_devkit/src/drupal_devkit/marketplace/`
- `/home/pointblank/research/repos/drupal_devkit/plugins/drupal-core/skills/`
- `/home/pointblank/research/repos/drupal_devkit/skills/using-drupal-devkit/SKILL.md`
- `/home/pointblank/research/repos/drupal_devkit/evals/drupal-testing/evals.json`
- `/home/pointblank/research/repos/drupal_devkit/CHANGELOG.md`
- `/home/pointblank/research/repos/drupal_devkit/.github/workflows/sync-community-plugins.yml`
- `/home/pointblank/research/repos/drupal_devkit/community-registry.json`
- `/home/pointblank/research/repos/drupal_devkit/ddev/install.yaml`

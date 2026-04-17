# Omedia-drupal-skill — Tier 2 LITE Analysis

**Source**: https://github.com/Omedia/drupal-skill
**Scope evaluated**: 3 SKILL.md (drupal-frontend, drupal-backend, drupal-tooling)
**Tier**: 2 LITE (Q1-4, 7, 8, 11, 13)
**Date**: 2026-04-17

---

## Q1 — Problem solved

Provides a Claude Code plugin marketplace bundling three universal Drupal specializations — frontend (theming/Twig), backend (modules/hooks/APIs), and tooling (DDEV/Drush) — covering Drupal 8, 9, 10, and 11+. The user-facing promise: install a split set of role-oriented skills so Claude Code auto-invokes the right one based on task context ("Create a Twig template" → `drupal-frontend`; "write hook_form_alter" → `drupal-backend`; "set up DDEV" → `drupal-tooling`). The three-skill split is the defining design choice — it trades a single monolithic skill for role-targeted triggering and narrower context footprint per invocation.

## Q2 — Primary artefact type

Claude Code **plugin marketplace** containing three SKILL.md plugins with supporting references and asset scaffolds. Not a library, not rules, not agents — plugins registered via `.claude-plugin/marketplace.json`. Each plugin ships:

- 1 SKILL.md (YAML frontmatter + prose body)
- `references/` — longer `.md` docs loaded on demand
- `assets/` (frontend + backend only) — file-scaffolds with `MODULENAME`/`THEMENAME` placeholders to be copied and renamed

File count mix: 11 md, 4 yml, 1 twig, 1 theme, 1 module, 1 php, 1 json, 1 js, 1 css.

## Q3 — Distribution model

**Claude Code `/plugin` marketplace** (git-based). Installation flow from README:

```
/plugin marketplace add Omedia/drupal-skill
/plugin install drupal-frontend   # and/or drupal-backend, drupal-tooling
```

Each plugin installable independently. Also supports local dir marketplace (`/plugin marketplace add /path/to/drupal-skill`). **No Composer, no npm, no manual copy to `.claude/skills/`** — only the plugin-manager path. `LICENSE` referenced in README but file not present in repo (INDEX says `License: none`). Per-plugin `license: MIT` declared inside marketplace.json.

## Q4 — Standards conformance + skill-unit convention (independently detected)

**Detected convention — Anthropic Claude Code plugin spec** (not the `.claude/skills/` or repo-root `skills/` conventions):

- Each plugin is a **top-level directory** at repo root (`drupal-frontend/`, `drupal-backend/`, `drupal-tooling/`), not nested under `skills/` or `.claude/skills/`.
- Registry at `.claude-plugin/marketplace.json` lists three `plugins[]` entries with `name`, `source: ./dir`, `description`, `version`, `author`, `license`, `keywords`, `category`, `tags`, `strict: false`.
- SKILL.md uses **minimal YAML frontmatter**: `name` + `description` only. No `drupal-version`, no `status`, no `allowed-tools`, no `version`.
- **Naming**: noun phrases — `drupal-frontend`, `drupal-backend`, `drupal-tooling`. **Not gerund-prefixed / verb-in-ing.**
- Internal structure: `SKILL.md` + `references/*.md` + `assets/<scaffold>/` (the Anthropic-documented "progressive disclosure" shape).
- Bodies follow a consistent template: Overview → When to Use → Core Capabilities (numbered) → Workflow → Best Practices → Common Patterns → Troubleshooting → Resources → Version Compatibility → See Also.

**Conformance**: High fidelity to the Anthropic plugin-marketplace spec and the progressive-disclosure SKILL.md pattern. Zero deviation from that spec.

## Q7 — Coverage (file paths + agency vs universal)

| Topic | File | Scope |
|---|---|---|
| Theme structure, `.info.yml`, `.libraries.yml`, `.breakpoints.yml` | `drupal-frontend/SKILL.md` §1, `drupal-frontend/references/theming.md` | Universal |
| Twig syntax + Drupal-specific filters (`t`, `attach_library`, `url`, `path`, `file_url`, `without`) | `drupal-frontend/SKILL.md` §2, `references/theming.md` | Universal |
| Preprocess functions + template suggestions | `drupal-frontend/SKILL.md` §3–4 | Universal |
| CSS/JS libraries + responsive breakpoints | `drupal-frontend/SKILL.md` §5–6 | Universal |
| Theme scaffold (`THEMENAME.info.yml`, `.libraries.yml`, `.theme`, page template, css/js starter) | `drupal-frontend/assets/theme-template/` | Universal |
| Module structure (`.info.yml`, `.module`, `.routing.yml`, `.services.yml`, `.permissions.yml`, `src/`) | `drupal-backend/SKILL.md` §1, `references/module_structure.md` | Universal |
| Hooks catalogue (entity, form, node, cron, install) | `drupal-backend/SKILL.md` §2, `references/hooks.md` | Universal |
| Controllers & routing, Forms API (ConfigFormBase), Entity API CRUD + entityQuery | `drupal-backend/SKILL.md` §3–5 | Universal |
| Plugin system (blocks), services.yml + DI, Database API, schema, event subscribers, custom access checks | `drupal-backend/SKILL.md` §6–8, patterns section | Universal |
| Module scaffold (`MODULENAME.info.yml`, `.module`, `.routing.yml`, `src/`) | `drupal-backend/assets/module-template/` | Universal |
| DDEV lifecycle (`start/stop/restart/ssh/launch/logs`, import/export-db, snapshots, pull @production) | `drupal-tooling/SKILL.md` §1, `references/ddev.md` | Universal |
| Drush commands (cache, config export/import, pm enable/uninstall, updatedb, user login/create, watchdog, `drush generate`) | `drupal-tooling/SKILL.md` §2–4, `references/drush.md` | Universal |
| Xdebug toggle, Mutagen/NFS perf, dev settings (services.yml, Twig debug) | `drupal-tooling/SKILL.md` §5 + perf section | Universal |

**Agency-specific content — none detected.** Grep for `Omedia` / `omedia` matches only repo metadata (INDEX title, source URL, README install string `Omedia/drupal-skill`). `marketplace.json` attributes generically to "Drupal Skills Team" / `drupal-skills@example.com` (placeholder email — not agency branding). No Omedia client, project, coding-style, deployment-target, or internal-tool references anywhere in SKILL.md, reference, or asset files.

**Gaps vs ai_best_practices topic scope**: no config management / Config Split, no migrations, no security deep-dive (CSRF/XSS/access), no testing (PHPUnit/Behat/Nightwatch), no performance/caching internals (cache tags/contexts), no SDC, no JSON:API / REST, no coding-standards tooling (PHPCS/PHPStan), no accessibility beyond a brief bullet list.

## Q8 — Quality signals

**Positive**:
- Consistent, well-structured SKILL.md template across all three plugins.
- YAML frontmatter is minimal and description-focused — aids triggering.
- Progressive disclosure via `references/` correctly used — heavy docs not inlined.
- Working scaffolds (`assets/*-template/`) with placeholder convention (`MODULENAME`, `THEMENAME`) — immediately actionable.
- Code examples are idiomatic modern Drupal 10/11 (`ControllerBase`, `ConfigFormBase`, entityQuery with `accessCheck(TRUE)`, services + DI, block plugins with annotation).
- "When to Use This Skill" + description both tuned for Claude auto-invocation.

**Negative / concerns**:
- **Single commit, dated 2025-10-19** ("Init") — no iteration history, no battle-testing visible.
- **No LICENSE file** (repo `License: none` per INDEX) despite `"license": "MIT"` in marketplace.json — inconsistency.
- **Placeholder author** (`drupal-skills@example.com`) suggests an experimental/first-cut release rather than a maintained agency product.
- **No tests, no evals, no CI.**
- **No Drupal version gating**: frontmatter has no `drupal-version` — all three claim "Drupal 8-11+" but ship one skill body. Idioms skew toward 10/11.
- No SDC (Single-Directory Components) despite being the D10.3+/11 standard — dates the frontend guidance.
- `drush generate` is mentioned but Drush generators moved to `drush/generators` in recent versions; not flagged.
- Frontend skill's "Searching References" block promotes `grep -r` inside references but doesn't state the runtime assumption.
- Scaffolds are thin (no example service, no example block plugin file despite SKILL.md showing them).

## Q11 — Compatibility with ai_best_practices locked decisions

| Decision | This repo | Match? |
|---|---|---|
| Skill naming: **gerund-prefix, verb-in-ing** | `drupal-frontend`, `drupal-backend`, `drupal-tooling` (noun phrases, role-based) | **No** |
| Directory: **`skills/` at project root** | Plugins at repo root (`drupal-frontend/` etc.), registered via `.claude-plugin/marketplace.json`. No `skills/` dir. | **No** |
| Metadata: **minimal — `drupal-version` + `status` only** | Frontmatter has `name` + `description` only. No `drupal-version`, no `status`. | **Partial** (same minimal spirit, different fields) |
| Distribution: **Composer-installable** | Claude Code plugin marketplace (`/plugin install`). No `composer.json`. | **No** |
| Scope: **universal Drupal, not project/agency-specific** | Content is universal Drupal 8-11+. No Omedia-specific guidance. | **Yes** |

**Adapting this repo to ai_best_practices would require**:
1. Rename the three skills to gerund form (e.g. `developing-drupal-backend`, `theming-drupal`, `managing-drupal-tooling`) or split into task-oriented gerund skills.
2. Relocate under `skills/` at project root.
3. Drop `.claude-plugin/marketplace.json`; add `composer.json` with custom installer type and distribute via Packagist.
4. Add `drupal-version` and `status` to each frontmatter.
5. Decide whether to preserve the three-skill split or consolidate toward task-scoped skills.

## Q13 — Verdict

**Moderate reference value for content, low structural reusability under ai_best_practices.** The universal Drupal guidance (hooks, Twig, DDEV/Drush command inventories, module/theme scaffolds) is solid, current-ish, and agency-neutral — worth mining for SPEC content. However, the distribution model (Claude Code plugin marketplace), directory layout (flat, no `skills/`), and naming convention (noun phrases) are **incompatible with three of the five locked decisions**. Treat as a **content source, not a structural template**: adopt the progressive-disclosure pattern (SKILL.md + references/ + assets/), the "When to Use" + numbered capabilities template, and the module/theme scaffolds with placeholder tokens; reject the marketplace distribution, flat layout, and role-based naming. The single "Init" commit, placeholder author email, and absent LICENSE suggest this is an exploratory drop — weight its authority accordingly.

**Recommendation**: Cite for scaffold pattern and SKILL.md template; do not adopt whole-cloth.

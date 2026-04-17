# ablerz-claude-skill-drupal-module — Tier 1 Semantic Analysis

**Source**: https://github.com/ablerz/claude-skill-drupal-module
**Last commit**: 2026-02-10 (recent, active)
**License**: GPL-2.0-or-later
**Branch**: `11.x` (default `main` tracks latest stable per `VERSIONS.md`)

---

## Q0. Primary Mode

**(a) skill content** — single-purpose Claude Code skill + supporting reference docs.

Evidence:
- 1 `SKILL.md` at repo root (`/home/pointblank/research/repos/ablerz-claude-skill-drupal-module/SKILL.md`).
- 13 subsystem reference files under `references/` (loaded on demand per SKILL.md Step 1).
- No PHP runtime code, no agents/, no hooks/, no prompts/ directories. `composer.json` type = `"claude-skill"` (installer metadata, not Drupal module code).
- 4 DDEV helper scripts under `ddev-commands/` are **tooling artefacts** distributed alongside the skill, not a separate mode — they exist because `SKILL.md` mandates `ddev phpcs|phpcbf|phpstan|phpunit` wrappers.

Not (b): it is the skill itself, not an aggregator of others. Not (e): `composer.json` declares a skill package, not a Drupal module.

## Q1. Problem Solved

Teaches Claude Code to generate **production-ready, installable Drupal 11 custom modules** with modern PHP 8.4+ syntax, attribute-based plugins/entities/hooks (not annotations), proper dependency injection, Drupal coding standards (2-space, PSR-4), cache metadata, entity access checks, and security review (XSS/SQLi/CSRF/access). It enforces a mandatory quality gate — `ddev phpcbf` → `ddev phpcs` → `ddev phpstan` → `ddev phpunit` — after every code change. Scope is narrow: Drupal 11 module authoring only; it does not attempt to cover migrations, multisite, theming-as-a-whole, or site-building. See `SKILL.md:1-15, 34-46, 197-244`.

## Q2. Primary Artefact Type

**`SKILL.md` with YAML frontmatter + `references/*.md` progressive-disclosure corpus.** One skill unit. Frontmatter has `name` + `description` (Anthropic skill schema) plus a `metadata:` block with Drupal/PHP/Symfony/PHPUnit/examples-branch version pins (`SKILL.md:1-15`).

## Q3. Distribution Model

Dual channel, explicit in `README.md:105-155`:
1. **Composer** — package `ablerz/claude-skill-drupal-module`, `type: claude-skill`, installs to `.claude/skills/custom-drupal-module/` via `composer/installers` + `oomphinc/composer-installers-extender`. Project `composer.json` must add `installer-paths` mapping for `type:claude-skill`. Version selected via `dev-11.x`.
2. **Git clone** — project-level (`.claude/skills/custom-drupal-module`) or global (`~/.claude/skills/custom-drupal-module`), branch-pinned (`-b 11.x`).

Branch strategy in `VERSIONS.md:8-17`: one branch per Drupal major (`11.x`, future `12.x`), `main` = latest stable.

Additional: `ddev-commands/*` are **manually copied** by the consumer into `.ddev/commands/web/` (`README.md:157-172`) — this is a second, non-automated sub-distribution step.

## Q4. Standards Conformance + Skill-Unit Convention

**Independently detected convention**: `SKILL.md` (uppercase) with YAML frontmatter, at repository root. Single unit, installs into `.claude/skills/<slug>/SKILL.md`.

- Frontmatter schema matches the Anthropic Agent Skills spec: required `name` (`custom-drupal-module`) and `description` are present (`SKILL.md:1-3`). A non-standard `metadata:` sub-map carries Drupal/PHP versioning.
- Progressive disclosure via `references/` is consistent with the agentskills.io pattern recommended by ai_best_practices.
- Directory placement **at repo root** (not under `skills/`) because this repo *is* a single skill unit — the `installer-name: "custom-drupal-module"` in `composer.json:11` causes the consumer's Composer to place the entire repo under `.claude/skills/custom-drupal-module/`. This is idiomatic for one-skill-per-repo distribution but **differs from a multi-skill repo that would place units under `skills/<name>/SKILL.md`**.

## Q5. Architectural Pattern — Runtime Loading

**Tier A (always in context)**: `SKILL.md` — Claude Code loads it when the skill is invoked (via `/custom-drupal-module` slash or a CLAUDE.md hint, `README.md:176-189`).

**Tier B (on-demand)**: `references/<subsystem>.md` — SKILL.md instructs Claude to *load the relevant reference file* when working on that subsystem (`SKILL.md:59-72, 258-280, 463-466`). Claude reads them itself via its Read tool; there is no pre-loading loader script.

**Tier C (live sources)**: SKILL.md tells Claude to `WebFetch` `api.drupal.org/api/drupal/11.x` and `drupal.org/list-changes/drupal?version=11.x` when verifying APIs or checking breaking changes (`SKILL.md:358-368`).

**Meta-loop (repo maintenance, not runtime)**: `.github/workflows/check-versions.yml` runs monthly, diffs drupal.org RSS against `last_updated` in frontmatter, and files a GitHub issue listing new change records.

This is a clean three-tier progressive-disclosure model: initial context stays light, deep docs load contextually, live sources of truth are explicit.

## Q6. Naming Convention vs. ai_best_practices Gerund-Prefix

**Non-conformant.** The sole skill is named `custom-drupal-module` — noun-phrase, not gerund/verb-in-ing.

ai_best_practices LOCKED convention would require something like `writing-drupal-modules` or `generating-drupal-11-modules`. Reference filenames are also noun-phrase (`entity-api.md`, `form-api.md`, `hooks.md`) — acceptable for *reference docs* (which are not skill units), but the skill's own name mismatches.

## Q7. Coverage (Drupal Topics)

All paths relative to `/home/pointblank/research/repos/ablerz-claude-skill-drupal-module/`:

- Skill workflow & quality gate → `SKILL.md`
- Entity API (content + config entities, handlers) → `references/entity-api.md`
- Plugin API (types, discovery, derivatives) → `references/plugin-api.md`
- Configuration API (schema, overrides, management) → `references/configuration-api.md`
- Cache API (bins, tags, contexts, max-age) → `references/cache-api.md`
- Routing system (routes, controllers, dynamic routes) → `references/routing-system.md`
- Form API (building, validation, AJAX) → `references/form-api.md`
- Database API (Query interface, transactions) → `references/database-api.md`
- Render & theming (render arrays, Twig, preprocess) → `references/render-theming.md`
- Event system (subscribers, kernel/routing events) → `references/event-system.md`
- Hooks (legacy hooks + Drupal 11 `#[Hook]` attributes) → `references/hooks.md`
- Dependency injection (service container patterns) → `references/dependency-injection.md`
- Security (XSS, SQLi, CSRF, access, Twig auto-escape) → `references/security.md`
- Testing (unit, kernel, functional PHPUnit) → `references/testing-quality.md`
- DDEV tooling (phpcs/phpcbf/phpstan/phpunit wrappers) → `ddev-commands/*`

**Not covered**: migrations, multisite, config split/environments, Views/search, theme-only workflows, frontend build, decoupled/JSON:API, composer recipes, update hooks beyond passing mention.

## Q8. Quality Signals

- **Last commit**: 2026-02-10 — fresh (~2 months old as of 2026-04-17). Not abandoned.
- **Commit history**: `INDEX.md` shows `"first init - drupal module code claude skill"` — effectively a single-commit initial release. Low longitudinal signal; cannot yet assess responsiveness.
- **Tests**: None for the skill itself. (Expected — skills are prose content; evals would be the appropriate mechanism and are absent.)
- **CI**: `.github/workflows/check-versions.yml` — automated **staleness monitor** (monthly cron, files issue when drupal.org publishes new change records past the skill's `last_updated` date). Creative and useful; does not test skill output quality.
- **Maintainer**: ablerz (single-author GitHub user, no org).
- **Docs**: `README.md`, `CHANGELOG.md`, `VERSIONS.md` present and coherent. Version matrix defined. Contribution steps documented.
- **License**: GPL-2.0-or-later — Drupal-ecosystem compatible.
- **Uncertainty**: single commit means community traction / issue responsiveness is unknown.

## Q9. Notable Innovations

1. **Monthly automated staleness detection** (`.github/workflows/check-versions.yml`) — parses drupal.org change-records RSS, compares to frontmatter `last_updated`, auto-opens a maintenance GitHub issue with a linked diff list. Novel and low-effort; transferable pattern.
2. **Explicit "live sources of truth" section** (`SKILL.md:358-368`) — directs Claude to `WebFetch` `api.drupal.org` + `drupal.org/list-changes` rather than trusting static reference files when in unfamiliar territory. Clean separation of "fast-path cache" vs. "authoritative source".
3. **Versioning branch strategy** (`VERSIONS.md`) — one branch per Drupal major, `main` auto-tracks latest stable. Composer `dev-11.x` pinning. Clean upgrade runway for Drupal 12.
4. **Mandatory DDEV wrapper enforcement** (`SKILL.md:42-43, 197-224`) — actively warns against `vendor/bin/phpcs` (wrong standard) and ships the scripts in `ddev-commands/` to make the enforcement actionable.
5. **PHP 8 attributes-first** (`SKILL.md:116-123, 387`) — including `#[Hook]` in tagged service classes (Drupal 11 OOP hooks) with explicit guidance on when procedural hooks are still required.
6. **"No `uuid` in generated config YAML"** rule (`SKILL.md:98-101`) — a subtle correctness trap rarely called out elsewhere.
7. **`type: claude-skill`** with `oomphinc/composer-installers-extender` — clean, DDEV-compatible Composer delivery into `.claude/skills/<name>/`.

## Q10. Weaknesses / Gaps

1. **Naming convention mismatch** with ai_best_practices (`custom-drupal-module`, not `writing-drupal-modules` — see Q6).
2. **Scope is single-skill, not universal Drupal guidance**. ai_best_practices aims to be universal; this repo is one focused unit. Not a weakness for this project, but it is not an ai_best_practices substitute.
3. **Metadata is richer than ai_best_practices prescribes** — frontmatter carries `php_version`, `symfony_version`, `phpunit_version`, `examples_branch`, `skill_version`, `last_updated`, `api_reference`, `breaking_changes`. ai_best_practices LOCKED `drupal-version` + `status` only. This repo would need to shed most metadata to conform.
4. **Naming inconsistency: `drupal_version` (underscore) vs. ai_best_practices `drupal-version` (kebab-case).** Trivial to fix.
5. **Single-contributor, single-commit history** — no track record yet for maintenance velocity or community engagement.
6. **No evals / no skill quality benchmarks** — common gap, but worth noting for Tier 1.
7. **Minor internal inconsistency**: SKILL.md says "PHP 8.2+" in some places (`SKILL.md:21, 356`) and "PHP 8.4+" in others (frontmatter, Core Principles `SKILL.md:41`). Frontmatter is authoritative; prose drift.
8. **PSR-12 reference is wrong/confusing**: `SKILL.md:107` says "2-space indentation, PSR-12 formatting" — PSR-12 mandates 4-space. Core Principles correctly says "2-space Drupal indentation (NOT PSR-12 4-space)" (`SKILL.md:42`). Contradiction.
9. **No license on reference files themselves** (only repo-level LICENSE.txt) — minor.
10. **`ddev-commands/` require manual copy + `chmod +x`** — no automation; easy to forget when updating the skill. A post-install composer script could handle this.

## Q11. Compatibility with ai_best_practices LOCKED Decisions

| Decision | This repo | Compat? |
|----------|-----------|---------|
| Skill naming (gerund, verb-in-ing) | `custom-drupal-module` (noun-phrase) | **No** — rename to e.g. `writing-drupal-modules` |
| Directory `skills/` at project root | Skill at repo root; installs to consumer's `.claude/skills/<name>/` | **Partial** — if re-packaged as one unit inside an ai_best_practices-style multi-skill repo it would live under `skills/writing-drupal-modules/SKILL.md`. Current layout is a single-skill repo. |
| Metadata: minimal (`drupal-version` + `status` only) | 8 metadata keys including `php_version`, `symfony_version`, `phpunit_version`, `examples_branch`, `skill_version`, `last_updated`, `api_reference`, `breaking_changes` | **No** — most would need to be stripped or moved out of frontmatter (e.g., into VERSIONS.md). `drupal_version` → `drupal-version` (kebab), add `status`. |
| Distribution: Composer-installable | `composer.json` type `claude-skill`, installer-name set | **Yes** |
| Scope: universal Drupal guidance | Narrow scope — Drupal 11 module authoring only | **Partial** — covers one slice well; does not pretend to be universal. Would slot cleanly into a universal repo as one of several skills. |

**Net**: mechanically compatible on distribution, incompatible on naming + metadata, scope-compatible as one component of a larger universal skillset.

## Q12. Relationship to Surge

Surge (tier 1, Batch 1) is a **multi-skill aggregator suite**; ablerz is a **single focused module-authoring skill**. No dependency either way. Conceptual overlap: both enforce modern Drupal 11 patterns (OOP hooks, attributes, DI, access checks, cache metadata). If Surge has a `writing-drupal-modules`-equivalent skill, ablerz is a narrower, deeper alternative with richer reference docs and a staleness-detection CI workflow Surge may lack. If not, ablerz could be absorbed into Surge (or ai_best_practices) as one unit.

Direction of knowledge transfer: the staleness-detection GitHub Actions workflow (Q9 #1) is a cleanly reusable artefact that ai_best_practices and Surge could both adopt.

## Q13. Verdict

**Reference + selective absorb.**

- **Absorb**:
  - `.github/workflows/check-versions.yml` — monthly staleness detector pattern (rename frontmatter keys to `drupal-version`, extend to also track PHP/Symfony changelogs if desired).
  - "Live sources of truth" pattern (`SKILL.md:358-368`) — explicit WebFetch instructions for `api.drupal.org` + change records.
  - Mandatory `ddev` wrapper enforcement with shipped `ddev-commands/*` scripts.
  - Two-tier references/ progressive-disclosure layout — already the agentskills.io default but this repo is a clean reference implementation.
  - "No UUID in generated config YAML" rule (`SKILL.md:98-101`).
  - PHP 8 attributes + `#[Hook]`-first posture.

- **Do not absorb wholesale**: the skill name, the metadata schema, or the single-skill-repo layout — these conflict with ai_best_practices LOCKED decisions.

- **Collaboration**: low cost. Single maintainer, GPL-2.0-or-later, Composer-ready. If ai_best_practices wants to vendor this skill as `writing-drupal-modules`, a single PR (rename + metadata shed + relocate to `skills/writing-drupal-modules/`) should suffice. Worth an opening-issue conversation with ablerz.

- **Uncertainty**: single-commit repo, so maintenance responsiveness unknown; the monthly CI workflow suggests intent to stay current.

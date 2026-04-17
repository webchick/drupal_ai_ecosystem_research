# ANALYSIS — ronaldtebrake-drupal-coding-standards-skill (Tier 2 LITE)

**Repo**: `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/`
**Source**: https://github.com/ronaldtebrake/drupal-coding-standards-skill
**Last commit**: 2026-04-06 ("Mark project as unmaintained and provide new resource")
**License**: none declared
**Status**: UNMAINTAINED — README top line redirects users to `drupal/ai_best_practices`
**Tier**: 2 LITE — direct topic overlap with ai_best_practices
**Questions covered**: Q1, Q2, Q3, Q4, Q7, Q8, Q11, Q13

---

## Q1. Problem solved

Wraps Drupal's official coding standards (from the canonical `drupal/coding_standards` Drupalcode repo at `https://git.drupalcode.org/project/coding_standards.git`) as a single Claude Code skill so an AI agent can review code against PHP, JS, CSS, Twig, YAML, SQL, Markup, Accessibility, Composer, and Spelling standards. Core value-add: **dynamic context discovery** — SKILL.md stays small (~60 lines) and a routing table (`standards-index.md`) maps a file extension to the specific standards markdown to load on demand, avoiding context bloat from loading every standard.

Maintenance thesis: maintain only the routing layer; pull content verbatim from the upstream Drupal.org project via Composer.

## Q2. Primary artefact type

Single Claude-style skill (one SKILL.md + routing index + bulk markdown assets).

- 1 `SKILL.md` at `.claude/skills/drupal-coding-standards/SKILL.md`
- 1 routing table `standards-index.md`
- 27 standards `.md` files under `assets/standards/` across 10 subject directories
- No agents, commands, hooks, prompts, evals, MCP servers, or tests
- `composer.json` + `AGENTS.md` + `CHANGELOG.md` + `README.md` at root

## Q3. Distribution model

Composer-installable (`composer require ronaldtebrake/drupal-coding-standards-skill --dev`). Installs with assets pre-scaffolded into `.claude/skills/drupal-coding-standards/`.

Mechanism:
- `drupal/coding_standards` declared as a **dev dependency with a VCS repository entry** pointing to `git.drupalcode.org/project/coding_standards.git` (not Packagist).
- Standards markdown is **manually copied** (NOT symlinked — see Q4) from `vendor/drupal/coding_standards/docs` into `.claude/skills/drupal-coding-standards/assets/standards/` at maintainer update time, then committed.
- End users pull the package via Composer and get standards pre-baked; they never need the `drupal/coding_standards` dev dependency themselves.
- README also namechecks `drupal/surge` as an aggregator.

No packagist.org listing confirmed from the repo itself.

## Q4. Standards conformance + independent skill-unit convention detection

**Skill unit (independently observed):**
- Directory: `.claude/skills/<skill-slug>/` — follows Anthropic's Claude Code convention of `.claude/skills/`, NOT `skills/` at project root.
- Slug is kebab-case noun form: `drupal-coding-standards` (NOT a gerund — no `-ing`).
- Frontmatter (YAML):
  - `name:` (matches directory slug)
  - `description:` (long, multi-sentence, includes trigger language "Uses dynamic context discovery...")
  - `metadata:` nested object with `author:` and `version:` (quoted string `"0.1"`)
- Body shape: `# <Human Title>` → `## When to Use` (bulleted triggers) → `## How It Works` → `## Review Workflow`
- Routing pattern: top-level `SKILL.md` is a thin entry pointing at a sibling `standards-index.md` (Markdown table mapping extension → primary file + additional files).
- Assets folder: `assets/standards/<category>/<topic>.md` — matches `assets/` convention from the Agent Skills spec.

**Conformance to declared standards:**
- README claims conformance with `agentskills.io` and "AGENTS.md compatible".
- AGENTS.md here is a **maintenance runbook** (for AI agents updating the skill), NOT a project-level AGENTS.md that points to project code.
- README claims "Standards directory (symlinked to vendor) following Agent Skills spec" — but AGENTS.md explicitly states the opposite: "Standards are manually copied (not symlinked) to ensure the skill is self-contained." README is internally inconsistent / outdated.

**Skill-unit convention — comparison to ai_best_practices LOCKED decisions:**
- Directory `.claude/skills/` vs locked `skills/` at project root — **DIVERGENT**
- Naming `drupal-coding-standards` (noun) vs locked gerund `-ing` verb — **DIVERGENT** (would need e.g. `reviewing-drupal-coding-standards`)
- Metadata (`author`, `version`) vs locked minimal (`drupal-version`, `status`) — **DIVERGENT** (no drupal-version; `status` absent though README effectively sets it to "unmaintained")
- Distribution via Composer — **ALIGNED**

## Q7. Coverage — Drupal topics with file paths

All paths relative to `.claude/skills/drupal-coding-standards/assets/standards/`:

| Topic | Files |
|-------|-------|
| PHP | `php/coding.md`, `php/documentation.md`, `php/documentation-examples.md`, `php/naming-services.md`, `php/namespaces.md`, `php/psr4.md`, `php/exceptions.md`, `php/e_all.md`, `php/placeholders-delimiters.md`, `php/index.md` |
| JavaScript | `javascript/coding.md`, `javascript/best-practice.md`, `javascript/documentation.md`, `javascript/eslint.md`, `javascript/jquery.md` |
| CSS | `css/coding.md`, `css/architecture.md`, `css/format.md`, `css/file-organization.md`, `css/csscomb.md`, `css/review.md` (plus `css/files/10.progress.png`) |
| Twig | `twig/coding.md` |
| YAML | `yaml/configuration-files.md` |
| SQL | `sql/conventions.md`, `sql/keywords.md`, `sql/select-from.md` |
| Markup / HTML | `markup/style.md` |
| Composer | `composer/package-name.md` |
| Accessibility (cross-cutting) | `accessibility/accessibility.md` |
| Spelling (cross-cutting) | `spelling/spelling.md` |
| Index | `index.md` (root of standards) |

**Coverage gaps** vs a "universal Drupal guidance" skill bundle: no entity API patterns, no service/DI, no hook patterns, no security, no caching, no testing, no config management, no migrations, no SDC, no Drush. Strictly *style and syntax* standards — not architectural or semantic best practices.

## Q8. Quality signals

- **Maintenance**: Marked unmaintained 2026-04-06. Author redirects to `drupal/ai_best_practices`. Strongest signal in the repo.
- **Upstream authority**: Content pulled from official `drupal/coding_standards` Drupalcode project — high authority for what it is.
- **Version discipline**: CHANGELOG.md follows Keep-a-Changelog, but only one entry `1.0.0 — 2025-01-XX` (date placeholder never filled in); SKILL.md frontmatter version is `"0.1"`, doesn't match changelog's `1.0.0`. Version drift already present.
- **License**: None declared — INDEX.md confirms `License: none`. Blocker for redistribution under ai_best_practices (which would want GPL-2.0-or-later to match Drupal.org).
- **Internal inconsistency**: README says standards are symlinked to vendor; AGENTS.md says manually copied. One document is wrong.
- **No tests / evals / CI**: no `evals/`, no `.github/`, no test harness.
- **Tiny surface**: 1 SKILL.md, 27 standards markdowns, 1 routing table — simple, auditable.
- **No secrets, no credentials, no code** — pure content + routing.

## Q11. Compatibility with ai_best_practices decisions

| Dimension | This repo | ai_best_practices locked | Compat |
|-----------|-----------|--------------------------|--------|
| Skill naming | Noun `drupal-coding-standards` | Gerund / `-ing` verb | No — rename required |
| Skill directory | `.claude/skills/<slug>/` | `skills/` at project root | No — move required |
| Metadata | `author`, `version` (quoted) | `drupal-version`, `status` | No — replace frontmatter |
| Distribution | Composer + VCS repo for `drupal/coding_standards` | Composer-installable | Yes — pattern fits, needs re-namespacing |
| Scope | Universal Drupal style/syntax standards | Universal Drupal guidance | Yes — narrower, fits as subset |
| License | None declared | (implied GPL-2.0+ to match Drupal.org) | Blocker — needs author re-licensing OR absorb-by-rewrite using upstream `drupal/coding_standards` directly |
| Content source | Upstream `drupal/coding_standards` copied verbatim | — | Neutral — ai_best_practices can reproduce the same upstream pull pattern under its own license |
| Maintenance | Unmaintained by author's own declaration | Actively maintained | Repo already redirects users to ai_best_practices |

## Q13. Verdict — ABSORB (pattern, not the repo)

**Recommendation: absorb the *pattern* into ai_best_practices; do NOT vendor the repo.**

Justification from evidence in this repo:

1. **The author has already told you to.** README line 1: "Best to use https://www.drupal.org/project/ai_best_practices/ instead, that is where I'll focus my efforts to make skills and best practices for the community." No conflict of intent.
2. **Direct topic overlap.** ai_best_practices owns "coding standards" as a topic; this skill IS that topic and nothing else. Keeping both is duplicative by definition.
3. **No license blocks a clean-room rewrite.** Repo has no license (blocks verbatim reuse) but the *upstream* content (`drupal/coding_standards` on Drupalcode) is the real source of truth — ai_best_practices can pull from upstream directly using the exact same Composer-VCS-repository pattern seen in `composer.json` lines 11–25. The pattern is the reusable artefact, not the markdown copies in this repo.
4. **Divergence on every naming/layout decision.** Name, directory, and frontmatter all differ from ai_best_practices' locked choices. Vendoring requires rewriting them anyway; pulling upstream once into ai_best_practices conventions is simpler than importing + transforming this repo.
5. **The dynamic-context-discovery routing idea is worth keeping.** The `standards-index.md` extension-to-file routing table (lines 7–16 of that file) cleanly reduces context load. ai_best_practices should adopt this routing-table technique inside its own gerund-named skill.
6. **Scope gap is fine.** This skill only covers style/syntax; ai_best_practices will cover architectural/semantic best practices elsewhere. A `reviewing-drupal-coding-standards` skill becomes one of several in the bundle, not the whole thing.

**Concrete absorb actions** (on the ai_best_practices side):
- Create `skills/reviewing-drupal-coding-standards/SKILL.md` (gerund; verb-in-ing).
- Reproduce the `standards-index.md` routing-table idea (public-interest factual mapping; re-expressed).
- Pull `drupal/coding_standards` via the same Composer VCS-repository trick from `composer.json` (lines 11–25 here).
- Use ai_best_practices' locked frontmatter: `drupal-version` + `status`; drop `author`/`version`.
- Drop `.claude/skills/` layout; put skill at `skills/<slug>/` per locked decision.
- Do not import the README, AGENTS.md, or CHANGELOG from this repo — rewrite per ai_best_practices house style.

**Do not**: clone this repo into ai_best_practices, depend on it as a Composer package, or fork it. Author has deprecated it; upstream `drupal/coding_standards` is the real source.

---

**Key file references**
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/INDEX.md`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/README.md` (lines 1–2 "Unmaintained")
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/SKILL.md`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/.claude/skills/drupal-coding-standards/standards-index.md`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/composer.json`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/AGENTS.md`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/CHANGELOG.md`

# ANALYSIS — nonzod-drupaldev-claude-skill (Tier 2 LITE)

**Repo**: `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/`
**Source**: https://github.com/nonzod/drupaldev-claude-skill
**Last commit**: 2025-11-11 15:43 ("Custom commands")
**License**: none declared (INDEX.md line 7: `License: none`)
**Tier**: 2 LITE — direct topic overlap with ai_best_practices; near-twin of ronaldtebrake-drupal-coding-standards-skill
**Questions covered**: Q1, Q2, Q3, Q4, Q7, Q8, Q11, Q13

---

## Q1. Problem solved

Bundles Drupal's canonical coding standards markdown (PHP, JS, CSS, SQL, Twig, YAML, Composer, Accessibility, Spelling, Markup) as a Claude Code skill that auto-activates on Drupal file types and keyword mentions, plus two slash commands that wrap the skill for concrete workflows (refactor-module, user-story). Goal: apply Drupal coding standards automatically during development inside Claude Code, globally (skill is installed to `~/.claude/skills/`).

Unlike ronaldtebrake's version, this skill uses an **always-load routing pattern** inside SKILL.md itself (no separate routing-index file); SKILL.md directly enumerates every standards file to "ALWAYS read" for each context.

## Q2. Primary artefact type

Single Claude-style skill + 2 slash commands + an install script.

- 1 `SKILL.md` at `.claude/skills/drupal-standards/SKILL.md` (189 lines — far larger than ronaldtebrake's 60-line entry)
- 35 standards markdown files under **project-root `coding_standards/`** (NOT nested inside the skill directory)
- 2 custom commands: `.claude/commands/refactor-module.md`, `.claude/commands/user-story.md`
- 1 `install.sh` bash script (copies `.claude/skills/drupal-standards` → `~/.claude/skills/drupal-standards`)
- `CLAUDE.md` + `CLAUDE.sample.md` + `README.md` + `.gitignore` at root
- No AGENTS.md, no composer.json, no package.json, no evals, no tests, no CI, no LICENSE

**Structural quirk:** `coding_standards/` is a sibling of `.claude/`, not inside the skill directory. Means SKILL.md's relative paths (`coding_standards/php/coding.md`) break at install time because `install.sh` only copies `.claude/skills/drupal-standards/` (which is empty of standards files) to `~/.claude/skills/drupal-standards/`. The referenced `coding_standards/` tree is NOT copied. **The skill as shipped cannot read the files SKILL.md tells it to read.** (See Q8.)

## Q3. Distribution model

Manual git clone + bash installer (`install.sh`). No Composer, no Packagist, no symlink. The installer literally `cp -r` from the repo checkout into `~/.claude/skills/drupal-standards`. README also documents a "manual install" equivalent: `cp -r drupal-standards-skill/.claude/skills/drupal-standards ~/.claude/skills/`.

Users must keep the clone around or re-clone to update (`git pull && ./install.sh`).

## Q4. Standards conformance + independent skill-unit convention detection

**Skill unit (observed directly from the repo):**
- Directory: `.claude/skills/drupal-standards/` — Anthropic `.claude/skills/` convention, not `skills/` at project root.
- Slug: `drupal-standards` — kebab-case noun (NOT gerund, NOT `-ing` verb).
- Frontmatter (YAML): exactly two fields
  - `name: drupal-standards`
  - `description:` (single long sentence blending trigger language with file extensions and keywords)
  - **No `metadata:` block, no `author`, no `version`, no `drupal-version`, no `status`.**
- Body shape: `# Drupal Coding Standards` → `## Core Principles` → `## Context Detection & Standard Loading` (per-language sub-sections with "ALWAYS read these standards FIRST" imperatives) → `## Workflow` (ASCII flow) → `## Multi-Context Tasks` → `## Application Rules` → `## Examples` → `## Critical Reminders`.
- **No `assets/` directory** — standards live at `coding_standards/` in project root, referenced by relative paths. Breaks agentskills.io `assets/` convention AND breaks after install.
- Slash commands as a secondary artefact: top-level `.claude/commands/*.md` with a `description:` frontmatter key (refactor-module.md) or no frontmatter (user-story.md). One command explicitly tells the agent to invoke the skill: "you MUST activate the drupal-standards skill by using the Skill tool with command 'drupal-standards'" (refactor-module.md line 7).

**Declared-standards conformance:**
- No claim of conformance with agentskills.io, AGENTS.md spec, or any other spec in README or SKILL.md.
- No CHANGELOG, no semver, no LICENSE.

**Comparison with ai_best_practices LOCKED decisions:**
- Directory `.claude/skills/` vs locked `skills/` at project root — **DIVERGENT**
- Naming `drupal-standards` (noun) vs locked gerund `-ing` verb — **DIVERGENT** (would need e.g. `enforcing-drupal-coding-standards`)
- Frontmatter minimal (`name`, `description` only) — **PARTIALLY ALIGNED with "minimal metadata"** spirit but still missing the locked `drupal-version` + `status` keys.
- Distribution: manual bash install vs locked Composer-installable — **DIVERGENT**
- Universal Drupal guidance vs locked scope — **ALIGNED on scope** (universal, version-independent), but content is style/syntax only (no architecture/security/testing).

## Q7. Coverage — Drupal topics with file paths

Paths relative to project root `coding_standards/`:

| Topic | Files |
|-------|-------|
| PHP | `php/coding.md`, `php/documentation.md`, `php/documentation-examples.md`, `php/namespaces.md`, `php/psr4.md`, `php/naming-services.md`, `php/exceptions.md`, `php/e_all.md`, `php/placeholders-delimiters.md`, `php/index.md` |
| JavaScript | `javascript/coding.md`, `javascript/documentation.md`, `javascript/best-practice.md`, `javascript/eslint.md`, `javascript/jquery.md` |
| CSS | `css/coding.md`, `css/format.md`, `css/file-organization.md`, `css/architecture.md`, `css/csscomb.md`, `css/review.md`, `css/files/` (assets) |
| Twig | `twig/coding.md` |
| YAML | `yaml/configuration-files.md` |
| SQL | `sql/conventions.md`, `sql/keywords.md`, `sql/select-from.md` |
| Markup/HTML | `markup/style.md` |
| Composer | `composer/package-name.md` |
| Accessibility | `accessibility/accessibility.md` |
| Spelling | `spelling/spelling.md` |
| Root index | `coding_standards/index.md` |

**Other languages beyond Drupal/PHP/JS/CSS/Twig/YAML/SQL?** No — the zivtech landscape page's "multi-language" label refers only to the mix of Drupal source file languages (PHP, JS, CSS, Twig, YAML, SQL, Markup). Not polyglot; does not cover Python, Go, Rust, etc.

**Coverage identity with ronaldtebrake**: same 10 subject directories, same file names, same canonical Drupal.org content. Content source is the same upstream `drupal/coding_standards` Drupalcode project (verbatim copy — spot-check of `coding_standards/php/coding.md` matches canonical Drupal coding standards verbatim, "based on PEAR Coding standards" etc.).

**Coverage gaps** vs universal Drupal guidance: no entity API, no service/DI, no hook patterns, no security, no caching, no testing, no config management, no migrations, no SDC, no Drush. Style/syntax only — same gap as ronaldtebrake.

## Q8. Quality signals — missing LICENSE as blocker

- **License: NONE DECLARED — blocker.** Content appears to be a verbatim copy of Drupal.org's coding_standards project (which is GPL-2.0-or-later by Drupal.org convention), but the repo itself has no LICENSE file, no SPDX header, and no mention of GPL. README section "License" says only: "Follow Drupal community standards and licensing." — which is not a license grant. Under default copyright law, ai_best_practices cannot redistribute this repo's content. ai_best_practices must pull from upstream `drupal/coding_standards` directly (where licensing IS clear) rather than from this repo.
- **Broken-as-shipped installation.** `install.sh` copies only `.claude/skills/drupal-standards/` (which contains only SKILL.md — no `coding_standards/` inside it). SKILL.md references `coding_standards/php/coding.md` etc. as relative paths, but after install those paths resolve relative to `~/.claude/skills/drupal-standards/`, where the content does not exist. Either the author tested only from the repo checkout, or the skill silently fails on every file-load instruction. No automated verification catches this.
- **Maintenance**: Last commit 2025-11-11 (5 months old at analysis date 2026-04-17). Only one other repo-level commit subject is visible ("Custom commands"). No CHANGELOG, no versioning, no release tags. No explicit unmaintained flag, but also no signs of active maintenance.
- **Documentation**: README is polished and structured; SKILL.md is thorough and clearly written.
- **No AGENTS.md, no composer.json, no tests, no CI, no evals.**
- **Slash commands are useful additions**: `refactor-module.md` and `user-story.md` go beyond what ronaldtebrake's skill provides. They're project-agnostic and could be lifted as patterns.
- **No secrets, no credentials, no executable code beyond install.sh.**
- **Internal consistency**: CLAUDE.md principles (DRY, SOLID, KISS, YAGNI, Boy Scout Rule) duplicate the README's "Standards" section; CLAUDE.sample.md suggests this CLAUDE.md is a template meant to be customized per-project.

## Q11. Compatibility with ai_best_practices decisions

| Dimension | This repo | ai_best_practices locked | Compat |
|-----------|-----------|--------------------------|--------|
| Skill naming | Noun `drupal-standards` | Gerund / `-ing` verb | No — rename required |
| Skill directory | `.claude/skills/<slug>/` | `skills/` at project root | No — move required |
| Metadata | `name`, `description` only | `drupal-version` + `status` | Partial — already minimal, but missing required keys |
| Distribution | Manual bash `install.sh`, no Composer | Composer-installable | No — must replace install mechanism |
| Content layout | `coding_standards/` at project root (outside skill dir) | Skill-contained | No — restructure required; current layout is also broken-as-shipped |
| Scope | Universal Drupal style/syntax | Universal Drupal guidance | Yes — narrower, fits as subset |
| License | None declared | (implied GPL-2.0+ to match Drupal.org) | Blocker — cannot redistribute verbatim from this repo |
| Content source | Upstream `drupal/coding_standards` copied verbatim | — | Neutral — ai_best_practices can reproduce by pulling upstream directly |
| Slash commands | 2 useful ones (refactor-module, user-story) | Skill-focused | Neutral — commands are orthogonal, can be inspiration |

## Q13. Verdict — IGNORE (prefer ronaldtebrake pattern; absorb nothing directly)

**Recommendation: IGNORE this repo for direct absorption; DO NOT reference it.**

**Coding-standards head-to-head: ronaldtebrake > nonzod.**

Comparison of the two coding-standards skills:

| Criterion | ronaldtebrake | nonzod | Winner |
|-----------|---------------|--------|--------|
| Distribution | Composer + VCS-repo trick pulling `drupal/coding_standards` from Drupalcode | Manual git clone + bash install.sh | ronaldtebrake — aligns with ai_best_practices Composer lock-in |
| Skill layout | Assets inside skill dir (`assets/standards/`) | Assets OUTSIDE skill dir (`coding_standards/` at repo root) | ronaldtebrake — install actually works |
| Context loading | Dynamic: thin SKILL.md (~60 lines) + routing index `standards-index.md` mapping file-extension → files | Always-load: SKILL.md (~189 lines) enumerates every standard to "ALWAYS read" per context | ronaldtebrake — lower token cost, more elegant pattern |
| License | None declared — blocker | None declared — blocker | Tie (both blockers) |
| Upstream-pull discipline | Pulls `drupal/coding_standards` via Composer VCS repo, documented in AGENTS.md runbook | Copies content in-tree; no upstream pull mechanism, no runbook | ronaldtebrake |
| Author intent | Unmaintained; README redirects users to `drupal/ai_best_practices` | No explicit status | ronaldtebrake — clear intent alignment with ai_best_practices |
| Value-add beyond content | Routing-table pattern | Slash commands (`refactor-module`, `user-story`) | Tie — orthogonal contributions |
| Tests/CI/evals | None | None | Tie |

**Justification for IGNORE verdict:**

1. **Strictly inferior to ronaldtebrake on the core job.** Same content, worse packaging, broken-as-shipped install, larger SKILL.md with always-load instead of dynamic routing. ai_best_practices should adopt ronaldtebrake's routing pattern; there's nothing nonzod does better on coding standards proper.
2. **License is a blocker either way.** Both repos lack a LICENSE, so neither can be vendored. ai_best_practices should pull from upstream `drupal/coding_standards` on Drupalcode directly (where GPL-2.0+ is clear).
3. **No unique content.** The standards markdown is identical verbatim Drupal.org content found in ronaldtebrake (and available upstream). Zero net-new material worth absorbing.
4. **The slash commands are not load-bearing.** `refactor-module.md` is a 6-step workflow wrapper that says "run the skill on all files in web/modules/custom/X"; `user-story.md` is a generic plan-then-implement command with nothing Drupal-specific beyond assuming a `user-stories/` directory. Both are easily reproducible; neither is worth pulling into ai_best_practices.
5. **Broken install is a quality smell.** The mismatch between `install.sh`'s copy scope and SKILL.md's path references suggests the author never ran the installed skill in anger. Reusing anything from this repo requires independently verifying it works.
6. **Convention divergence compounds.** Every major locked decision (directory, naming, distribution, layout) diverges. Importing + transforming this repo costs more than pulling upstream fresh.

**Concrete actions on ai_best_practices side:**
- Do NOT clone, vendor, fork, or depend on this repo.
- Use the ronaldtebrake repo's Composer-VCS-repository pattern (its `composer.json` lines 11-25) to pull `drupal/coding_standards` upstream under ai_best_practices' GPL license.
- Adopt ronaldtebrake's `standards-index.md` routing-table approach (not nonzod's always-load SKILL.md approach) inside `skills/enforcing-drupal-coding-standards/` (gerund name, project-root `skills/`, ai_best_practices frontmatter with `drupal-version` + `status`).
- If a "refactor a module end-to-end" workflow is wanted in ai_best_practices, write it from scratch in ai_best_practices house style — nonzod's version is not worth porting.

**Do not reference this repo in ai_best_practices docs** — ronaldtebrake is the better exemplar to cite for the coding-standards-skill pattern, and it has the advantage of the author explicitly deferring to ai_best_practices.

---

**Key file references**
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/INDEX.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/README.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/CLAUDE.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/.claude/skills/drupal-standards/SKILL.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/.claude/commands/refactor-module.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/.claude/commands/user-story.md`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/install.sh`
- `/home/pointblank/research/repos/nonzod-drupaldev-claude-skill/coding_standards/index.md`
- `/home/pointblank/research/repos/ronaldtebrake-drupal-coding-standards-skill/ANALYSIS.md` (head-to-head comparison reference)

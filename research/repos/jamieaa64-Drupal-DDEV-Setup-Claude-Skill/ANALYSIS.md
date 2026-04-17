# ANALYSIS — jamieaa64/Drupal-DDEV-Setup-Claude-Skill (Tier 2 LITE)

**Source**: https://github.com/jamieaa64/Drupal-DDEV-Setup-Claude-Skill
**Last commit**: 2025-11-12
**Default branch**: main
**License**: LICENSE (not inspected in detail)
**Tier**: 2 LITE

---

## Q1. Problem solved

Automates the **complete Drupal project setup and onboarding lifecycle** via a single Claude Code skill. Three primary scenarios:

1. **New project creation** — scaffold a Drupal 11 Core / Drupal CMS / Minimal project with DDEV config, `settings.php`, `.gitignore`, `config/sync/`, common contrib modules (Admin Toolbar, Gin, Pathauto, etc.), GitHub push — in ~30 seconds (Quick Mode) or 5–8 min (Full Mode with SQLite install).
2. **Existing project onboarding** — new team member clones a repo; skill runs `ddev start && ddev composer install && ddev drush site:install --existing-config && ddev launch`.
3. **Sync/reset** — update after `git pull` (composer install + config:import + updb + cache:rebuild), or full reset (ddev delete + reinstall).

Target user: agency/org developers standardising on DDEV + config-first Drupal workflows.

## Q2. Primary artefact type

**Single Claude Code skill** — one skill-unit (`drupal-setup`) containing one instruction file, one bash helper (`init.sh`), and five file templates. Also ships repo-level narrative docs (`plan.md`, `CurrentWorkflow.md`, `HISTORY.md`, `SKILL_IMPROVEMENTS.MD`, `INSTALL.md`) which are not part of the shipped skill payload — they document the design and upload instructions for humans.

## Q3. Distribution model

**Manual copy / ZIP upload** — NOT Composer, NOT packaged.

- CLI install: `cp -r .claude/skills/drupal-setup ~/.claude/skills/`
- Web install: run `./package-skill.sh` to produce `drupal-setup-skill.zip` (zips the `drupal-setup/` directory from inside `.claude/skills/`), then upload via Claude Code Web Skills settings.
- No `composer.json`, no `package.json`, no `skills.yaml`, no release tags inspected. Distribution is "clone the repo and copy the folder" plus a bash packager.

## Q4. Standards conformance + skill-unit convention

**Skill location**: `.claude/skills/drupal-setup/` — user/project `.claude/skills/` path (Anthropic Claude Code convention for user- or project-scoped skills), NOT the `skills/` at project root that PointBlank's LOCKED ai_best_practices decision mandates.

**Skill-unit filename** (independently verified):

```
/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/skill.md
```

File exists as **lowercase `skill.md`** (22,057 bytes). INDEX.md reports "Number of SKILL.md files: 0" — this is a **case-sensitive miscount**; skill content is fully present as `skill.md`. The repo's own `package-skill.sh`, `INSTALL.md`, and `README.md` all consistently reference lowercase `skill.md` as the required filename. This diverges from Anthropic's canonical spec which uses **uppercase `SKILL.md`**.

**Frontmatter** (verified, complete):

```yaml
---
name: drupal-setup
description: Complete Drupal development lifecycle - setup, onboarding, and maintenance
---
```

Only `name` + `description`. No `drupal-version`, no `status`, no `allowed-tools`, no `version`. Naming is **noun-phrase** ("drupal-setup"), not gerund ("setting-up-drupal").

## Q7. Coverage — Drupal topics with file paths

**Single topic**: DDEV-based Drupal project setup / onboarding / maintenance. No Entity API, caching, hooks, security, theming, migrations, or testing guidance.

Files (all absolute paths):

- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/skill.md` — main instructions: scenario detection, Quick/Full Mode flows, update/reset flows, GitHub push
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/init.sh` — bash helper (SQLite-check + Drupal install attempt for Full Mode)
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/README.md` — human-readable skill docs
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/templates/settings.php` — org settings.php template
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/templates/gitignore` — Drupal `.gitignore`
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/templates/ddev-config.yaml` — DDEV config template
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/templates/README.md` — project README template
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/.claude/skills/drupal-setup/templates/CLAUDE.md` — generated project CLAUDE.md template
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/package-skill.sh` — ZIP packager for Web distribution
- `/home/pointblank/research/repos/jamieaa64-Drupal-DDEV-Setup-Claude-Skill/INSTALL.md`, `plan.md`, `CurrentWorkflow.md`, `HISTORY.md`, `SKILL_IMPROVEMENTS.MD` — repo-level narrative docs (not shipped with skill)

## Q8. Quality signals

**Positive**:
- Clear scenario-branching logic (new vs existing vs update vs reset) with explicit detection rules.
- Template-based Quick Mode is pragmatic — avoids the slow `composer install` + `drush site:install` round-trip during scaffolding and defers DB install to DDEV.
- Environment awareness (CLI vs Web) is explicitly encoded.
- `package-skill.sh` is a genuine distribution aid.
- Reflective artefacts present: `HISTORY.md` (19KB) and `SKILL_IMPROVEMENTS.MD` (27KB) suggest iterative polishing and self-critique.

**Negative / concerns**:
- Lowercase `skill.md` diverges from the Anthropic canonical (`SKILL.md`) — may silently fail to register on stricter loaders.
- No `composer.json` for distribution; no semver or release tags inspected; single PR merged (`#1 consolidate-to-main`) suggests very young project.
- One-man skill: 30-second scaffolding is opinionated (Gin admin theme, specific module set) with no configurability surfaced in frontmatter.
- No tests / evals / CI — `.github/` absent.
- Uses `admin/admin` as default credentials in Full Mode (documented, but a foot-gun).
- Pins `drupal/recommended-project:^11` — will not help Drupal 10 users.

## Q11. Compatibility with ai_best_practices LOCKED decisions

| Decision | This repo | Match |
|---|---|---|
| **Skill naming: gerund-prefix, verb-in-ing** | `drupal-setup` (noun phrase) | **DIVERGES** — would be `setting-up-drupal` under PB convention |
| **Directory: `skills/` at project root** | `.claude/skills/drupal-setup/` | **DIVERGES** — uses Claude Code user-scope path, not root `skills/` |
| **Metadata: minimal (`drupal-version` + `status`)** | `name` + `description` only | **DIVERGES** — missing both `drupal-version` and `status` |
| **Distribution: Composer-installable** | Manual `cp -r` / ZIP upload | **DIVERGES** — no `composer.json`, no Packagist |
| **Scope: universal Drupal guidance** | Single narrow topic (DDEV setup) | **PARTIAL** — universal in that it applies to any new Drupal project, but narrow in coverage (setup only, not Drupal development broadly) |

**Case and location both diverge**: (a) lowercase `skill.md` vs PB/Anthropic uppercase `SKILL.md`; (b) `.claude/skills/` vs root-level `skills/`. Adopting any content from this repo would require renaming the file to `SKILL.md`, relocating the skill to `skills/<gerund-name>/`, rewriting frontmatter to `drupal-version` + `status`, and wrapping the distribution in a Composer package.

## Q13. Verdict

**Borrow specific content, reject the packaging.** The scenario-detection logic and the `init.sh` SQLite-probe pattern are reusable. The templates (`settings.php`, `.gitignore`, `ddev-config.yaml`) are a reasonable starting baseline for PointBlank's own setup skill. But as a shipped artefact this is **not compatible with PB LOCKED decisions on naming, location, metadata, or distribution** — it would require a rewrite, not an adoption. The `skill.md` lowercase casing is a risk signal on its own: it implies the author never validated loading under Anthropic's stricter spec, and downstream consumers with case-sensitive loaders will silently skip the file.

**Classification**: useful reference for scaffolding UX and template content; NOT a reusable skill under PB's ai_best_practices contract.

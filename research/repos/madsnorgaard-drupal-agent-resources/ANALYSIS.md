# madsnorgaard/drupal-agent-resources — Semantic Analysis

Source: https://github.com/madsnorgaard/drupal-agent-resources
Last commit: 2026-04-14 (Mads Nørgaard). Active — commits land within the last week; merged PR #12 flags legacy plugin annotations in CI.

## Q0 — Primary mode
**(g) mixed — Claude Code resource bundle.** 5 Skills + 5 Commands + 1 Agent distributed by a third-party package manager. Skill content is the bulk of the payload; the commands/agent are thin glue.
Paths: `.claude/skills/`, `.claude/commands/`, `.claude/agents/drupal-reviewer.md`.

## Q1 — Problem solved (author's framing)
README: "Reusable Claude Code resources for Drupal 10/11 development with DDEV and Docker-based local environments." Vision statement (`README.md`): "set a high standard for how AI coding agents interact with Drupal, by encoding deep Drupal expertise into reusable resources that guide agents toward correct, secure, and maintainable code from the start." Universal Drupal guidance, opinionated toward DDEV/Docker, research-before-build.

## Q2 — Primary artefact type
SKILL.md files with rich embedded code — Drupal 10/11 patterns, DI, OOP hooks, PHP 8 attributes, drush generators. Secondary: slash-command markdown files (workflow instructions) and a sub-agent definition for code review.

## Q3 — Distribution model
Not Composer. Uses **Kasper Junge's `agr` CLI** (`agent-resources` package manager, installed via `uv tool install agr`). Install form: `agr add madsnorgaard/drupal-agent-resources/drupal-expert`. Auto-detects resource type from directory. `agrx` runs temporarily. No `composer.json`, no `package.json`, no `skills.yaml`. Source: `README.md` L94–135.

## Q4 — Standards conformance + skill-unit convention (independent detection)
**Detected convention (independent):**
- Directory: `.claude/skills/<name>/SKILL.md` (Claude Code canonical layout, NOT project-root `skills/`).
- Filename: uppercase `SKILL.md`.
- Frontmatter: **`name` + `description` only** (verified in all 5 SKILL.md files; see `.github/workflows/validate.yml` L42–45 which enforces exactly these two as required).
- No `drupal-version`, no `status`, no `version`, no `allowed-tools`.
- Commands frontmatter: `name`, `description`, optional `arguments` (e.g., `.claude/commands/module-scaffold.md` L1–4).
- Agents frontmatter: `name`, `description`, `tools`, optional `model` (e.g., `.claude/agents/drupal-reviewer.md` L1–6).

**Conformance to ai_best_practices LOCKED decisions:**
- Directory `skills/` at project root → **DIVERGES** — uses `.claude/skills/`.
- Metadata minimal (`drupal-version`, `status`) → **DIVERGES** — uses `name`, `description`; lacks `drupal-version` and `status`.
- Gerund-prefix naming → **DIVERGES** (see Q6).
- Composer distribution → **DIVERGES** — uses `agr` (pip/uv-based).

## Q5 — Architectural pattern (runtime loading)
Claude Code auto-activation via description triggers. Each SKILL.md declares a `description` with natural-language activation cues ("Triggers on mentions of Drupal, Drush, Twig, modules, themes, or Drupal API" — `drupal-expert` L3; "Auto-activates when writing forms, controllers, queries..." — `drupal-security` L3). Slash commands are user-invoked (`/drush-check`, `/module-scaffold`). The sub-agent is dispatched proactively ("Use proactively after writing or modifying Drupal code" — `drupal-reviewer.md` L3). No precedence system, no MCP, no hooks — pure Claude Code convention.

## Q6 — Naming convention vs. gerund-prefix
Documented pattern (`CLAUDE.md` L40–43): **"domain-expert" for skills** (e.g., `drupal-expert`), **"action-noun" for commands** (e.g., `module-scaffold`), **"domain-reviewer" for agents**. All 5 skills match: `drupal-expert`, `drupal-security`, `drupal-migration`, `ddev-expert`, `docker-local`. **Zero gerund prefixes.** Incompatible with ai_best_practices' `writing-automated-tests` convention.

## Q7 — Coverage (topic → path)
- Drupal 10/11 development (hooks, DI, plugins, module structure, translation, twig, drush generators, AI-prompting patterns) — `.claude/skills/drupal-expert/SKILL.md` (1360 lines, the centrepiece)
- Security (SQLi, XSS, access control, CSRF, file uploads) — `.claude/skills/drupal-security/SKILL.md`
- Migrations (D7→D10/11, CSV, JSON, migrate_plus/migrate_tools) — `.claude/skills/drupal-migration/SKILL.md`
- DDEV local dev (start/stop, drush, xdebug, MySQL, custom services) — `.claude/skills/ddev-expert/SKILL.md`
- Generic docker-compose local dev — `.claude/skills/docker-local/SKILL.md`
- Drush health checks — `.claude/commands/drush-check.md`
- Module scaffolding (research-first, interactive) — `.claude/commands/module-scaffold.md`
- Config export workflow — `.claude/commands/config-export.md`
- Security audit walkthrough — `.claude/commands/security-audit.md`
- Performance analysis — `.claude/commands/performance-check.md`
- Code review (security + standards + DI + perf checklist) — `.claude/agents/drupal-reviewer.md`

## Q8 — Quality signals
- **Last commit:** 2026-04-14 (3 days ago relative to 2026-04-17) — **active**.
- **Issues/PRs:** PR #12 merged (CI annotation check) — shows external contributor activity (`derjochenmeyer`).
- **Tests:** No code tests — this is a docs repo. However, there IS a CI validation workflow (`.github/workflows/validate.yml`) that:
  - Validates YAML frontmatter (`name`, `description` required for skills, commands, agents).
  - Enforces `https://` for drupal.org links (L136–145).
  - Blocks legacy `@Block(...)` / `@EntityType(...)` annotations in markdown examples (L147–154).
- **Versioning:** Formal semver (`VERSIONING.md`) with Keep-a-Changelog format. Current: v0.1.1 (2026-03-07). Changelog tracks 0.1.0 (2026-01-28) → 0.1.1.
- **Maintainer:** Single author (Mads Nørgaard) — sole committer in local mirror (note: local clone is shallow, `git log` returns only the merge tip; history inferred from CHANGELOG.md).
- **License:** **NONE** declared — INDEX.md reports `License: none`. This is a liability for redistribution.
- **Docs:** README, CLAUDE.md, ROADMAP.md (28KB, phased plan for D11/PHP 8.4/testing/perf), VERSIONING.md, CHANGELOG.md.

## Q9 — Notable innovations
1. **CI validation for markdown plugin syntax** (`validate.yml` L147–154): regex-greps markdown code examples to ensure they show PHP 8 attribute style, not legacy annotations. Rare and valuable — catches doc drift as Drupal moves to attributes.
2. **CI http→https enforcement on drupal.org links** — a small but professional touch.
3. **"AI-Assisted Development Patterns" section** inside `drupal-expert/SKILL.md` L992–1340 — goes meta: teaches the AI how to prompt, classify tasks (Create/Edit/Information/Composite), scaffold-first via DCG, expect 80% completion + iterate. Cites Rockowitz and Drupal CodeGenerator snippet.
4. **Non-interactive drush generator JSON answers** (`drupal-expert/SKILL.md` L538–706) — explicit, tabulated reference for AI-automation use of `drush generate --answers='{…}'`. Practically useful.
5. **Research-first philosophy** baked into every skill and into the reviewer agent (pre-review check: "Did you check drupal.org for existing modules?").
6. **`agr` as distribution** — cherry-pick single resources across repos; rare in this space.

## Q10 — Weaknesses / gaps
- **No license.** Blocks legal reuse.
- **`drupal-expert/SKILL.md` is 1360 lines** — very large single file; Anthropic skill guidance recommends splitting into progressive-disclosure reference files. Likely consumes context every invocation.
- **Overlap with existing PointBlank `drupal-workflow` plugin** — `drupal-security`, migrations, coding standards, DI patterns, caching, hook patterns all already covered by skills you have.
- **`docker-local` is thin** and generic — little Drupal-specific value over the web.
- **No tests on content itself** beyond frontmatter/link/annotation lint. Code examples are not executed.
- **Naming diverges** from ai_best_practices decision.
- **Distribution via `agr`** adds a non-Drupal dependency (uv + pip) — not friendly for Drupal composer workflows.
- **ROADMAP is ambitious** (Phase 1: D11+PHP 8.4; Phase 2: testing; Phase 3: perf) but so far unrealised (v0.1.x after three months).

## Q11 — Compatibility with ai_best_practices decisions
| Decision | madsnorgaard | Verdict |
|----------|--------------|---------|
| Skill naming: gerund-prefix (`writing-automated-tests`) | `drupal-expert`, `drupal-security` (domain-noun / domain-adjective) | **incompatible** — would need full rename |
| Directory: `skills/` at project root | `.claude/skills/` | **incompatible** — different convention |
| Metadata minimal (`drupal-version` + `status`) | `name` + `description` | **incompatible** — different minimal set |
| Composer-installable | `agr` (pip/uv) | **incompatible** — different distribution |
| Scope: universal Drupal guidance | universal Drupal + DDEV/Docker | **compatible** (scope) |

Content is largely portable; metadata/layout is not.

## Q12 — Relationship to Surge
Both are Drupal-focused Claude Code resource sets. Surge (tier-1 comparable) is generally broader, more structured, and has been referenced as a prior-art contender. madsnorgaard overlaps with Surge in: coding standards, security, DI, hooks. madsnorgaard's `drupal-expert` is a single mega-skill versus Surge's split-by-concern approach. madsnorgaard adds: `ddev-expert`, `docker-local`, migration deep-dive, AI-prompting meta-guidance, research-first philosophy. Surge likely has more mature progressive disclosure (reference/ subdirectories). They would collide if co-installed because both target `.claude/skills/<name>/SKILL.md`.

## Q13 — Verdict
**Reference (selective absorb).**

Rationale:
- Active, semver-disciplined, CI-validated single-maintainer project with real content density — worth mining.
- But divergent on every ai_best_practices LOCKED decision (naming, directory, metadata, distribution) → cannot absorb wholesale without renames/restructure.
- No license → absorbing verbatim text is legally risky; require confirmation with the author or paraphrase.

**Specifically absorb (as inspiration / paraphrased reference):**
1. The `drush generate --answers='{…}'` non-interactive JSON reference table (`drupal-expert/SKILL.md` L663–674) — practical, automatable, fits ai_best_practices scope.
2. The CI check that blocks legacy `@Annotation` plugin syntax in markdown (`.github/workflows/validate.yml` L147–154) — adopt for ai_best_practices CI.
3. Research-first philosophy (check drupal.org contrib before custom) — already present in the community, but nicely codified here.
4. The frontmatter-linter workflow pattern (`.github/workflows/validate.yml` L40–134) — adopt/adapt for ai_best_practices CI with `drupal-version` + `status` instead.

**Do NOT absorb:**
- The 1360-line monolithic `drupal-expert` structure — violates progressive-disclosure guidance.
- `docker-local` skill — too thin, not Drupal-specific enough.
- The `agr` distribution model.
- The `domain-expert` naming pattern.

**Collaborate?** Possible low-value — single maintainer, divergent conventions. Better to cite and move on.

**Ignore?** No — worth a read before writing the analogous ai_best_practices skills, especially for the drush generator + CI patterns.

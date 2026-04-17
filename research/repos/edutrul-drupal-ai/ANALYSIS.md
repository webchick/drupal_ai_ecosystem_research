# Phase 2 Semantic Analysis — edutrul-drupal-ai

**Repo**: `/home/pointblank/research/repos/edutrul-drupal-ai/`
**Upstream**: https://github.com/edutrul/drupal-ai
**Last commit**: 2026-04-15 (`206436b` "Update documentation.") — repo contains a **single commit** (squashed extraction)
**License**: MIT (`/home/pointblank/research/repos/edutrul-drupal-ai/LICENSE`)
**Scope**: 35 `SKILL.md` (1 meta + 34 topical) + 10 agents + 9 commands + 2 hooks + 8 rules + multi-tool glue (`.codex/`, Cursor instructions, Copilot instructions in README).

---

## Q0. Primary mode

**(g) mixed, dominated by (a) skill content + (c) agent-definitions suite.**
Evidence: 34 topical SKILL.md files under `.claude/skills/` (~4,000 lines total, see `wc -l` counts), 10 agent definitions under `.claude/agents/`, 9 slash-commands under `.claude/commands/`, 2 shell hooks, 8 always-on `rules/*.md` files, plus two tool-specific glue files (`.codex/README.md`, Copilot instructions block in `README.md`). It is also partly (b) tooling: the meta `./SKILL.md` advertises a `npx skills add` installer for per-skill consumption (`/home/pointblank/research/repos/edutrul-drupal-ai/SKILL.md:7-9`). There is no PHP module code (file-type counts: 104 md, 6 sh, 3 json, 1 gitignore — `INDEX.md:10-15`), so (e) is N/A.

## Q1. Problem solved (author's framing)

Ship "a production-tested AI toolkit for Drupal 11 development — compatible with Claude Code, OpenAI Codex, Cursor, and GitHub Copilot" (`README.md:9`). The repo is dual-purpose: (1) active `.claude/` config for a real Drupal 11 / DDEV / Acquia Cloud project powering 150+ sites (`README.md:11-14`, `README.md:186-192`), and (2) a reusable project-agnostic drop-in (`README.md:14`). The author explicitly decouples the `.claude/` folder from Drupal codebase so it can be contributed independently (`README.md:192`).

## Q2. Primary artefact type

**Two parallel artefact types coexist:**
1. **Claude Code skill-directory-with-frontmatter** — 34 topical `skills/<slug>/SKILL.md` files with YAML frontmatter `name: + description:` only (grep of `.claude/skills`). Two skills ship with extra asset directories: `drupal-contrib-mgmt` has `references/` (3 files) + `examples/` (4 `.sh` scripts), and `drupal-config` has `references/full-guide.md` (confirmed via `ls`).
2. **Repo-root `./SKILL.md` meta-index** — 139-line installer/README aimed at `npx skills add https://github.com/edutrul/drupal-ai --skill SKILL_NAME` consumption (`SKILL.md:7-9`). This is the **skills.sh** distribution convention (`README.md:7` badge links to `skills.sh/...`).

Secondary artefacts: 10 agents (YAML frontmatter with `name`, `description`, `tools`, `model`, and a novel `skills:` list — see `/home/pointblank/research/repos/edutrul-drupal-ai/.claude/agents/drupal-backend-dev.md:1-21`), 9 slash commands (YAML frontmatter with `name`, `description`, `allowed-tools` — see `/home/pointblank/research/repos/edutrul-drupal-ai/.claude/commands/code-review.md:1-5`), 2 session-lifecycle shell hooks, 8 always-loaded rule files.

## Q3. Distribution model

**Not Composer.** No `composer.json`, no `package.json`, no `skills.yaml` (verified: `INDEX.md:28-32`). Five channels:

1. **`npx skills add` (skills.sh)** — advertised in the meta `SKILL.md:7-9` and in `.codex/README.md:17-19`. This is the [agentskills.io / skills.sh](https://skills.sh) ecosystem.
2. **Manual directory copy** — `cp -r .claude /path/to/project/.claude` (`README.md:124-126`).
3. **Symlink for Codex** — `ln -s ../.claude/skills .codex/skills` (`README.md:192`, `.codex/README.md:11`).
4. **Concat for Copilot** — `cat .claude/skills/*.md >> .github/copilot-instructions.md` (`SKILL.md:113`).
5. **Symlink for Cursor** — `ln -s ../.claude/skills/*.md .cursor/rules/` (`SKILL.md:103`).

## Q4. Standards conformance + independently-detected skill-unit convention

**Frontmatter schema (detected from grep across all 34 topical skills):**
- `name:` — always present (confirmed: 34 matches, one per topical skill, values match directory name exactly)
- `description:` — always present (34 matches)
- No `version:`, `drupal-version:`, `status:`, `license:`, `author:`, or `skills:` fields anywhere in SKILL.md frontmatter (grep returned 0 matches for any of these on skill files).

**This is the minimal Claude Code SKILL.md schema** (exactly `name` + `description`). It **matches ai_best_practices' direction toward minimal metadata**, but not its specific recommendation of `drupal-version + status`.

**File layout convention**: `skills/<slug>/SKILL.md` (directory-per-skill, file always literally `SKILL.md`). 32 of 34 are single-file; 2 (`drupal-contrib-mgmt`, `drupal-config`) use sub-directories for references/examples. This is the **anthropic-skill / agentskills.io convention** — directory-based, SKILL.md capitalised, frontmatter YAML. Consistent with ai_best_practices' locked `skills/` directory structure (though rooted at `.claude/skills/`, not at repo root).

## Q5. Architectural pattern — runtime loading

**Four concurrent loading mechanisms:**

1. **On-demand skill invocation** (Claude Code default) — Claude Code discovers `.claude/skills/*/SKILL.md` automatically; the `description:` field is the retrieval gate. No manifest, no `<SKILL_INDEX>` style aggregation.

2. **Always-on `rules/*.md`** — files in `.claude/rules/` (docblocks, drupal, frontend, php, phpcs, testing, tooling, workflow — 8 files) are loaded every session as persistent context. These are not skills; they are unconditional directives (see the system-reminder dump earlier in this session: each rule file was injected wholesale on session start, confirming they are pulled in automatically rather than on-demand). `README.md:93-107` calls them "Always-loaded context files that shape AI behavior in this project."

3. **Agent-triggered skill bundles** — agents carry a `skills:` array in frontmatter (e.g. `drupal-backend-dev.md:6-20` preloads 14 skills; `drupal-reviewer.md:6-13` preloads 6; `drupal-test-writer.md:6-10` preloads 3). When Claude delegates to the subagent, those skills are scoped in. This is not a stock Claude Code feature — it appears to be an extension the author relies on, or simply a static hint for the orchestrator.

4. **Session-lifecycle hooks** (`.claude/settings.json:2-23`) — `SessionStart` event with matchers `startup|resume` triggers `session-start.sh` (checks git branch, Docker+DDEV readiness, theme dir) and `clear|compact` triggers `session-resume.sh` (lighter PATH and git context reload).

**Meta `./SKILL.md` at repo root** is **not loaded at runtime** by Claude Code — it is a distribution catalog for `skills.sh` / `npx skills add`, plus a human README for multi-tool integration. It explicitly lists the 34 topical skills in tables categorised by domain (Local Development, Drupal Core Patterns, Forms, Fields & Content, Frontend, Data & Search, Configuration & Tooling, Testing — `SKILL.md:13-79`).

## Q6. Naming convention vs. ai_best_practices gerund-prefix

**Severe divergence. Zero of 34 topical skills use gerund-prefix.** Concrete enumeration:

| Pattern | Count | Examples |
|---|---|---|
| `drupal-<noun>` | 32 | `drupal-hooks`, `drupal-services`, `drupal-caching`, `drupal-routes`, `drupal-security`, `drupal-entity-api`, `drupal-migrations`, `drupal-paragraphs`, etc. |
| `<tool>-<noun>` / `<tool>-expert` | 2 | `ddev-expert`, `docker-local` |
| Gerund-prefix (verb-ing) | **0** | — |

ai_best_practices locked-decision form would rename every one. Examples of the required rename:
- `drupal-hooks` -> `implementing-drupal-hooks` or `writing-drupal-hooks`
- `drupal-caching` -> `configuring-drupal-caching` or `adding-cache-metadata`
- `drupal-security` -> `hardening-drupal-security` or `preventing-drupal-vulnerabilities`
- `drupal-migrations` -> `writing-drupal-migrations`
- `ddev-expert` -> `managing-ddev-environments`
- `drupal-dtt` -> `writing-existingsite-tests`

**Quantified divergence**: 34/34 = 100% of topical skills need renaming for gerund-prefix compliance. This is the single biggest integration blocker.

## Q7. Coverage — enumeration of all 35 skills

**Meta skill (1)**:
- `./SKILL.md` — project distribution index (not loaded at runtime; consumed by `skills.sh`).

**Topical skills (34)** — grouped by author's README categorisation (`SKILL.md:13-79`), with file paths:

### Local Development (2)
1. `ddev-expert` — `.claude/skills/ddev-expert/SKILL.md` (157 lines, plus a `README.md`)
2. `docker-local` — `.claude/skills/docker-local/SKILL.md` (72 lines)

### Drupal Core Patterns (13)
3. `drupal-access` — `.claude/skills/drupal-access/SKILL.md` (93 lines)
4. `drupal-caching` — `.claude/skills/drupal-caching/SKILL.md` (81 lines)
5. `drupal-entity-api` — `.claude/skills/drupal-entity-api/SKILL.md` (141 lines)
6. `drupal-events` — `.claude/skills/drupal-events/SKILL.md` (75 lines)
7. `drupal-hooks` — `.claude/skills/drupal-hooks/SKILL.md` (138 lines)
8. `drupal-menus` — `.claude/skills/drupal-menus/SKILL.md` (96 lines)
9. `drupal-plugins` — `.claude/skills/drupal-plugins/SKILL.md` (117 lines)
10. `drupal-render` — `.claude/skills/drupal-render/SKILL.md` (134 lines)
11. `drupal-routes` — `.claude/skills/drupal-routes/SKILL.md` (106 lines)
12. `drupal-security` — `.claude/skills/drupal-security/SKILL.md` (160 lines)
13. `drupal-services` — `.claude/skills/drupal-services/SKILL.md` (108 lines)
14. `drupal-state` — `.claude/skills/drupal-state/SKILL.md` (97 lines)
15. `drupal-taxonomy` — `.claude/skills/drupal-taxonomy/SKILL.md` (100 lines)

### Forms (4)
16. `drupal-form-ajax` — `.claude/skills/drupal-form-ajax/SKILL.md` (86 lines)
17. `drupal-form-alter` — `.claude/skills/drupal-form-alter/SKILL.md` (70 lines)
18. `drupal-form-api` — `.claude/skills/drupal-form-api/SKILL.md` (106 lines)
19. `drupal-form-validation` — `.claude/skills/drupal-form-validation/SKILL.md` (109 lines)

### Fields & Content (2 unique; `drupal-taxonomy` double-listed by author)
20. `drupal-fields` — `.claude/skills/drupal-fields/SKILL.md` (88 lines)
21. `drupal-paragraphs` — `.claude/skills/drupal-paragraphs/SKILL.md` (93 lines)

### Frontend (2)
22. `drupal-javascript` — `.claude/skills/drupal-javascript/SKILL.md` (123 lines)
23. `drupal-twig` — `.claude/skills/drupal-twig/SKILL.md` (103 lines)

### Data & Search (3)
24. `drupal-queries` — `.claude/skills/drupal-queries/SKILL.md` (133 lines)
25. `drupal-search-api` — `.claude/skills/drupal-search-api/SKILL.md` (295 lines — **the largest**)
26. `drupal-migrations` — `.claude/skills/drupal-migrations/SKILL.md` (173 lines)

### Configuration & Tooling (5)
27. `drupal-composer` — `.claude/skills/drupal-composer/SKILL.md` (53 lines — smallest)
28. `drupal-config` — `.claude/skills/drupal-config/SKILL.md` (111 lines, plus `references/full-guide.md`)
29. `drupal-contrib-mgmt` — `.claude/skills/drupal-contrib-mgmt/SKILL.md` (144 lines, plus `references/` (3) + `examples/` (4 shell scripts))
30. `drupal-debugging` — `.claude/skills/drupal-debugging/SKILL.md` (166 lines)
31. `drupal-drush` — `.claude/skills/drupal-drush/SKILL.md` (158 lines)

### Testing (3)
32. `drupal-dtt` — `.claude/skills/drupal-dtt/SKILL.md` (141 lines)
33. `drupal-kernel` — `.claude/skills/drupal-kernel/SKILL.md` (130 lines)
34. `drupal-unit` — `.claude/skills/drupal-unit/SKILL.md` (117 lines)

**Totals**: 34 topical + 1 meta = 35. Total skill-body content ~= 4,074 lines (from `wc -l`). Coverage is comprehensive for Drupal 11 / DDEV / Acquia workflows — content maps cleanly to mainstream Drupal concerns. Visible gaps: no `sdc` skill (SDC covered inside `drupal-twig` and `rules/frontend.md`), no `decoupled`/JSON:API skill, no `layout-builder` skill, no `workflow-api`/`content-moderation` skill, no `views`/`views-plugins` skill, no `cron`/`queue-api` skill, no `file`/`media`/`image-styles` skill beyond what's inside `drupal-entity-api`, no accessibility skill (handled by external `accessibility` skill referenced via the Claude harness).

## Q8. Quality signals

- **Git history**: `git rev-list --count HEAD` = 1. Single squashed commit on 2026-04-15. This means the "production-tested on a real project" claim **cannot be verified from commit history** — no iterative changes, no bug-fix patches, no contributor churn. The repo is an **extraction/snapshot** of a larger internal codebase, not the live project itself.
- **"Battle-tested on a platform powering 150+ sites"** (`SKILL.md:3`) — plausible given the content depth, DDEV/Acquia specificity, and operational details (e.g. `session-start.sh:61-101` handles macOS Docker Desktop restart, Mutagen status recovery — these are details learned from pain, not conjured). But unverifiable from this snapshot.
- **CI / tests**: none in this repo (no `.github/`, no test runner, no `composer.json` — `INDEX.md:29-34`). The `testing.md` rule covers what the consumer project should do (`.claude/rules/testing.md`), but the skill repo itself is not validated by CI.
- **Versioning**: none. No SemVer tag, no version in frontmatter, no CHANGELOG.
- **Maintainer activity**: Author Eduardo Telaya (`README.md:173`), single-author repo. No issue tracker referenced. No contributors file.
- **Content-quality signal**: high. Sampled skills (`drupal-hooks`, `drupal-security`, `ddev-expert`, `drupal-caching`, `drupal-dtt`, `drupal-access`) all show:
  - Correct Drupal 11 idioms: `#[Hook]` attribute, auto-discovery from `src/Hook/`, `final` classes, constructor-injected `readonly` dependencies (`drupal-hooks/SKILL.md:31-37`).
  - Safe/unsafe contrasts with explicit VULNERABLE vs. SAFE labels (`drupal-security/SKILL.md:12-54`).
  - Operational details that smell production-earned: Mutagen-after-Docker-crash recovery (`ddev-expert/SKILL.md:82-90`), Drush-specific `drush.ini` to silence PHP deprecation noise (`ddev-expert/SKILL.md:69-76`).
  - Consistent tone, terse reference-style tables.
- **Rule content discipline**: `rules/phpcs.md` is 5 lines and says the right things; `rules/testing.md` picks an opinionated stack (DTT ExistingSite only — no unit/kernel/functional) and sticks to it (`rules/testing.md:1-15`). This is the work of someone who has argued these positions in real PR reviews.

**Verdict on "production-tested" claim**: The *content* looks production-earned; the *repo* is an opaque snapshot that cannot be independently verified. Treat the claim as plausible but unverified.

## Q9. Notable innovations

1. **Agent frontmatter `skills:` array** (`.claude/agents/drupal-backend-dev.md:6-20`) — pre-loads a curated skill bundle into a subagent's context. Not a stock feature of Claude Code; worth stealing.
2. **`done-gate` agent** (`/home/pointblank/research/repos/edutrul-drupal-ai/.claude/agents/done-gate.md`) — runtime validator distinct from static review. Runs `drush cr`, PHPCS, PHPStan, PHPUnit on changed files and checks "bug-fix regression test" presence (`done-gate.md:52`). Explicitly adversarial: "Assume work is incomplete until proven otherwise" (`done-gate.md:125`).
3. **Two-event `SessionStart` hook** (`.claude/settings.json:3-22`) — distinct startup vs. resume behaviour; `session-start.sh` will auto-launch Docker Desktop and wait up to 20s for it, then `ddev start` if the web service isn't OK (`session-start.sh:61-101`). `session-resume.sh` is a reduced, non-mutating version for `/clear` / `/compact` events — a thoughtful distinction.
4. **Multi-tool story (real, not aspirational)** — README documents four concrete integrations: Claude Code (native), Codex (symlink `.claude/skills` -> `.codex/skills`), Cursor (symlink into `.cursor/rules/`), Copilot (concat into `.github/copilot-instructions.md`). Commands in `SKILL.md:86-113`.
5. **`CLAUDE.example.md` / `AGENTS.example.md` pattern** — ships a sanitised production CLAUDE.md that the consumer uses as a template, with a suggested meta-prompt: "Read CLAUDE.example.md and help me create my own..." (`README.md:132-136`). The final `CLAUDE.md` and `AGENTS.md` are gitignored (`.gitignore:4-5`).
6. **Team-mapping file for PR workflow** (`.claude/data/mappings.example.json`, `.claude/data/mappings.json`) — a GitHub-username -> Jira-name/email lookup table that `/create-pr`, `/ready-pr-in-review`, `/review-pr` consume (`commands/ready-pr-in-review.md:36-42`). This lifts reviewer assignment from Claude-guess into a structured artefact.
7. **Slash-command `allowed-tools:` allowlist** (`commands/code-review.md:4`, `commands/ready-pr-in-review.md:4`) — per-command tool-permission scoping. Each command ships with a curated `Bash(...)` whitelist instead of relying on settings.json globals.
8. **Two skills with extra asset directories** — `drupal-contrib-mgmt/examples/*.sh` (4 shell scripts: `create-custom-patch.sh`, `find-and-apply-patch.sh`, `major-version-upgrade.sh`, `update-with-patch.sh`) and `drupal-config/references/full-guide.md`. Demonstrates Anthropic's "skill as a directory with scripts" pattern in the wild.
9. **Granular `settings.json` permission curation** (`.claude/settings.json:24-120`) — the `allow:` block is ~95 entries, including `sh -c *cat*` sub-patterns to unblock wrapped shell calls. Shows someone who has actually run out of permission-prompt patience and fixed it.

## Q10. Weaknesses / gaps

1. **Naming convention diverges from ai_best_practices gerund-prefix on every single topical skill** (34/34). See Q6.
2. **Directory divergence**: `.claude/skills/` vs. ai_best_practices-locked `skills/` at project root.
3. **No Composer distribution** -> incompatible with ai_best_practices distribution model; would need a `composer.json` that ships the skills to `drupal-root/skills/` or similar.
4. **No version/drupal-version/status metadata** -> not aligned with ai_best_practices' minimal metadata (`drupal-version + status`).
5. **Single-commit snapshot** prevents verification of the "production-tested" claim from history. No CHANGELOG.
6. **No CI, no tests, no linting** on the skill content itself. No way to mechanically catch a broken frontmatter or dead link.
7. **Project-specific leakage in places**: `CLAUDE.example.md` / `AGENTS.example.md` are clearly anonymised from an internal project ("MY_PROJECT", "myproject_"), but `rules/workflow.md` still hardcodes Jira-prefix `COS-XXX` (`rules/workflow.md:16-22`), and base branch `develop` bleeds into two shell hooks (`session-start.sh:41`, `session-resume.sh:35`) with an inline README note telling users to change it (`README.md:116`). A generic consumer has to remember to edit the hooks.
8. **`drupal-taxonomy` double-listed** in meta `SKILL.md` categories (Drupal Core Patterns + Fields & Content) — minor doc hygiene.
9. **No accessibility skill**, **no views skill**, **no SDC-dedicated skill**, **no layout-builder skill**, **no workflow-API / content-moderation skill**, **no JSON:API / decoupled skill**, **no cron/queue-api skill**. Covered partially inside other skills but not first-class.
10. **`skills:` frontmatter field on agents** is not a standard Claude Code feature — consumers who use a plain harness may see it ignored. No documentation of what that field actually triggers.
11. **Installer dependency on `skills.sh`** (`npx skills add`) couples distribution to a third-party service — if skills.sh vanishes, the meta README's install snippet breaks.

## Q11. Concrete changes required for ai_best_practices merge

All changes below assume `ai_best_practices` locked decisions: gerund naming, root `skills/`, minimal `drupal-version + status` metadata, Composer distribution, universal Drupal scope.

**Required (hard blockers):**

| Change | Effort | Notes |
|---|---|---|
| Rename 34 skills to gerund-prefix | High | Bulk-rename directories and update frontmatter `name:`. Also update every cross-reference in agents' `skills:` lists (10 agents x ~3-14 skills each), meta `./SKILL.md`, and README tables. |
| Move `.claude/skills/*` -> `skills/*` at project root | Low | `git mv`, then update the two Codex/Cursor symlink recipes in `SKILL.md`/`.codex/README.md`. |
| Add `drupal-version:` and `status:` to each SKILL.md frontmatter | Medium | 34 files; probably `drupal-version: "11"` and `status: stable` for all. |
| Add a `composer.json` | Low | Declare `type: drupal-recipe` or `type: library` and ship skills into the project's `skills/` dir via `composer/installers` or a custom copy on install. |
| Strip project-specific leakage | Medium | Remove `COS-XXX` from `rules/workflow.md` (or gate it behind an example file), genericise `develop` branch assumptions in the two hooks, move DTT-only opinion from `rules/testing.md` into a skill (since `ai_best_practices` scope is universal). |

**Optional (soft blockers, depends on `ai_best_practices` scope decisions):**

| Change | Notes |
|---|---|
| Consolidate 4 form skills into 1 or 2 | `drupal-form-ajax`, `drupal-form-alter`, `drupal-form-api`, `drupal-form-validation` — ai_best_practices may prefer coarser units. |
| Decide meta `./SKILL.md` fate | `skills.sh` flavour; ai_best_practices has no parallel — probably drop. |
| Decide agent/command/hook fate | ai_best_practices is skill-focused; whether to include the 10 agents + 9 commands + 2 hooks is a scope call. They are genuinely useful but off-scope. |
| Genericise `CLAUDE.example.md` / `AGENTS.example.md` | Already 90% generic; keep or drop based on scope. |

**Estimated net work to merge**: 2-3 days of careful refactoring for one person, most of it mechanical rename work + cross-reference updates. The content is fundamentally sound.

## Q12. Relationship to Surge

**Could Surge aggregate this repo?** Yes with caveats — Surge aggregators typically scan for `skills/<slug>/SKILL.md` at repo root. This repo puts skills at `.claude/skills/<slug>/SKILL.md`. Three options:

1. **Move skills to root `skills/`** — one `git mv` plus updates to the symlink recipes (`.codex/README.md:11`, `SKILL.md:86-113`). Trivial and clean.
2. **Surge allows configurable skill roots** — if Surge's aggregator accepts `.claude/skills/` as a source, no move is needed.
3. **Aggregator walks the tree** — if Surge's SkillValidator scans by SKILL.md filename regardless of path, it would pick them up in place.

**Would Surge's SkillValidator accept this repo's frontmatter?**
- If Surge requires only `name` + `description` — **yes, every single skill passes**.
- If Surge requires `drupal-version` or `status` — **no skill passes** (zero have these fields).
- If Surge flags the "directory-with-hyphens matches `name:` field" rule — **yes, passes** (all 34 match exactly: `.claude/skills/drupal-hooks/SKILL.md` has `name: drupal-hooks`).
- If Surge enforces gerund-prefix naming — **zero pass** (see Q6).

**Surge-specific value**: high. If Surge simply indexes the raw content, this repo is one of the densest concentrations of Drupal 11 skill markdown publicly available (~4,074 lines across 34 skills, all frontmatter-conformant). If Surge normalises naming at aggregation time (e.g. a `gerund_override:` in an ingestion manifest), the rename problem goes away.

## Q13. Verdict

**Absorb (content) + reference (tooling).** This repo is the strongest single-source concentration of Drupal 11 skill content in the research set. The content quality is high — idioms are current (Drupal 11.1 OOP hooks, `final` + `readonly` + constructor DI, `#[Hook]` attributes, DTT ExistingSite), operational details are production-earned (Docker/DDEV recovery flows, Drush deprecation suppression, Mutagen recovery), and the "VULNERABLE vs SAFE" framing in `drupal-security` is exactly the teaching pattern `ai_best_practices` wants. The weakness is 100% naming-convention divergence (34/34 skills need gerund rename) plus non-Composer distribution and `.claude/skills/` directory choice — all mechanical, none content. The innovations worth stealing regardless of absorption outcome: the `skills:` frontmatter array on agents (pre-loaded skill bundles per subagent), the `done-gate` adversarial validator, and the two-event `SessionStart` hook pattern. The 10 agents + 9 commands + 2 hooks should be **referenced as exemplars of the broader Claude Code ecosystem** but not absorbed into `ai_best_practices` unless scope expands past skills. The meta `./SKILL.md` and `skills.sh` installer recipe are orthogonal and can be ignored. **Recommended action**: contact the author (Eduardo Telaya, `README.md:173`) about contributing skill content under `ai_best_practices`' naming convention, with attribution. Fallback: mine the content, rename, and credit in a CHANGELOG entry.

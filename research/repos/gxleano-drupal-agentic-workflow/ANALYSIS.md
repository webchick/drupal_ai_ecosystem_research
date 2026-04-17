# gxleano/drupal-agentic-workflow — Phase 2 Semantic Analysis

**Source**: https://github.com/gxleano/drupal-agentic-workflow
**Last commit**: 2026-03-12 "Update skills" (~1 month before analysis — active)
**License**: none declared (per INDEX.md line 7)

---

## Q0. Primary mode

**(g) mixed — skill-content suite + installer tooling + hooks + project template.**

Ships 20 inline/agent skills (primary content) plus a 36 KB idempotent `bin/setup.sh` installer, three Claude Code hooks (`pre-bash-guard`, `post-generation-lint`, `prompt-context`), a starter Drupal theme scaffold (`assets/theme-template/`), and a `CLAUDE-TEMPLATE.md` that `setup.sh` appends to the target project's `CLAUDE.md`. Skill content is the centre of gravity but the author has built a complete "turn Claude Code into a Drupal dev partner" harness around it — so this is genuinely mixed, not pure (a).

## Q1. Problem solved (author's framing)

From `README.md:3`: "Turn Claude Code into a Drupal-native development partner with 20 AI-powered skills, automated code quality hooks, and security scanning." The README's "Why Use This?" table (lines 7-14) frames the pain as a feedback loop: stock Claude generates code with Drupal coding-standard violations, developers have to run phpcs/phpstan manually, there's no protection against destructive Bash commands, and AI answers are generic. gxleano's answer is: bundle Drupal-specific skills, wire `phpcbf`/`phpcs`/eslint/stylelint/prettier into a post-generation lint hook so Claude sees violations and self-corrects, block destructive commands with a pre-Bash guard, and ship a one-shot `setup.sh` that installs all of it into any Drupal project.

## Q2. Primary artefact type

Claude Code `.claude/skills/<slug>/SKILL.md` files (YAML frontmatter + Markdown body), plus Bash hooks, plus a Bash installer.

## Q3. Distribution model

**Git clone + Bash installer.** No Composer package, no `composer.json`, no npm package, no `skills.yaml` manifest (all absent per INDEX.md lines 35-38). README.md:166-204 instructs users to `git clone` the repo somewhere permanent, then run `~/drupal-agentic-workflow/bin/setup.sh .` from their Drupal project root. The installer (`bin/setup.sh:1-27`) runs 7 phases: validates target is a Drupal project (composer.json with drupal/core), offers to install `drupal/coder`+`phpstan`, copies `.claude/` into the target, appends `CLAUDE-TEMPLATE.md` to the project's CLAUDE.md, drops `.prettierrc.json` and `phpstan.neon`, optionally analyses `web/modules/custom/` and generates `AI_CONTEXT.md`, and auto-populates the Custom Modules section. Idempotent with `--dry-run`, `--force`, `--skip-tools`, `--skip-ai-context` flags. No versioning tag — consumers pin to a git SHA if they want reproducibility.

## Q4. Standards conformance + independently detected skill-unit convention

- **Anthropic Claude Code skills spec**: conforms. Every SKILL.md has YAML frontmatter with `name:` and `description:` (verified via `grep ^name:` across all 20). Directory structure is `.claude/skills/<slug>/SKILL.md` which matches the Anthropic Skill Plugin convention. Three skills have sub-directories with additional files (`code-review/agent-prompt.md`, `generate-tests/agent-prompt.md`, `drupal-expert/references/`, `drupal-frontend-expert/references/*.md`, `drupal-security/references/`, `drupal-site-builder-expert/references/`).
- **Independently detected naming convention**: single-word or hyphenated-noun slugs. Verbs where present are imperative ("scaffold", "refactor", "debug", "migrate"), not gerunds. No gerund-prefix (`writing-`, `generating-`). Domain slugs use bare nouns (`accessibility`, `api`, `entity`, `performance`, `ddev`, `drush`, `doctor`). Expert personas use `-expert` suffix (`drupal-expert`, `drupal-frontend-expert`, `drupal-site-builder-expert`).
- **Metadata convention**: inconsistent. Most skills have `version: 1.0.0`; `generate-tests` has `1.1.0`; `code-review` has `2.1.0`; `api/SKILL.md` additionally carries `status: true` (malformed YAML — likely meant `stable`); `drupal-frontend-expert` uses `status: stable`; several skills (`drupal-expert`, `drush`, `performance`, `refactor`, `update-module`, `config-management`) have **no** version at all. No `drupal-version` field anywhere.

## Q5. Architectural pattern — how guidance loads

Two loading mechanisms stacked:

1. **On-demand via slash commands / auto-trigger**: each skill is a standard Claude Code skill. User types `/scaffold module my_module` or `/drupal-security`, or Claude's skill auto-selector triggers it from the `description:` field (e.g. drupal-expert description: "Triggers on mentions of Drupal, Drush, Twig, modules, themes, or Drupal API" — `.claude/skills/drupal-expert/SKILL.md:3`).
2. **Always-on harness via hooks**: `.claude/settings.json:2-27` registers `pre-bash-guard.sh` (PreToolUse matcher=Bash, 5s timeout, exit 2 blocks) and `post-generation-lint.sh` (PostToolUse matcher=Write|Edit, 120s timeout, exit 2 feeds errors back to Claude for auto-correction). `prompt-context.sh` is an opt-in UserPromptSubmit hook (must be added manually to `settings.local.json`) that injects a 1-2 line git-status summary every prompt.
3. **Two skill execution modes**: most skills are "inline" (Claude reads SKILL.md content directly). `code-review` and `generate-tests` are **agent dispatchers** — their SKILL.md body instructs Claude to spawn a `general-purpose` Task agent in background, feeding it a separate `agent-prompt.md` file plus resolved target/type args (`code-review/SKILL.md:14-35`, `generate-tests/SKILL.md:13-32`). Reports land in `.claude/reviews/<name>.md`.
4. **Project context injection**: `CLAUDE-TEMPLATE.md` is appended to the target project's CLAUDE.md so Drupal coding rules are always in the system prompt; `setup.sh` optionally generates per-module `AI_CONTEXT.md` files with discovered hooks/routes/services.

## Q6. Naming convention vs. ai_best_practices gerund-prefix

**Does not match.** ai_best_practices locked decision is gerund-prefix (e.g. `writing-automated-tests`). gxleano uses bare nouns and imperative verbs:

| gxleano slug | ai_best_practices style |
|---|---|
| `scaffold` | `scaffolding-drupal-code` / `generating-modules` |
| `refactor` | `refactoring-drupal-code` |
| `debug` | `debugging-drupal-issues` |
| `migrate` | `managing-drupal-migrations` |
| `generate-tests` | `writing-automated-tests` (literally the locked example) |
| `update-module` | `updating-contrib-modules` |
| `code-review` | `reviewing-drupal-code` |
| `accessibility` | `ensuring-accessibility` / `applying-wcag` |
| `performance` | `optimizing-performance` |
| `drupal-security` | `securing-drupal-code` |
| `drupal-expert` / `drupal-frontend-expert` / `drupal-site-builder-expert` | no equivalent — ai_best_practices scopes by action not persona |
| `drush` / `ddev` / `solr-setup` | tool references — arguably tool-namespaced (`using-drush`, `using-ddev`, `setting-up-solr`) |

Persona skills (`*-expert`) don't fit the gerund model at all. A merge requires both slug rewrites and a decision on whether "expert" personas survive (ai_best_practices universal-Drupal-guidance scope suggests they should be folded into action-verb skills).

## Q7. Coverage — one line per skill

| # | Skill | File | Scope |
|---|---|---|---|
| 1 | accessibility | `.claude/skills/accessibility/SKILL.md` | WCAG 2.2 AA, ARIA, keyboard nav, axe/pa11y testing |
| 2 | api | `.claude/skills/api/SKILL.md` | JSON:API, REST resources, GraphQL, decoupled auth (OAuth/JWT), CORS |
| 3 | code-review | `.claude/skills/code-review/SKILL.md` | Agent-dispatched architectural review (quick/security/architecture/full/standards/test types); report at `.claude/reviews/<name>.md` |
| 4 | config-management | `.claude/skills/config-management/SKILL.md` | cex/cim workflow, Config Split, config overrides, config schema, Recipes |
| 5 | ddev | `.claude/skills/ddev/SKILL.md` | DDEV start/stop, logs, Xdebug, DB snapshots, port conflicts, add-on services |
| 6 | debug | `.claude/skills/debug/SKILL.md` | Drupal code-logic issues: hooks not firing, ServiceNotFound, cache invalidation, entity queries, routes, permissions |
| 7 | doctor | `.claude/skills/doctor/SKILL.md` | Self-diagnostic for the workflow install itself (hook registration, skill availability, phpcs/phpstan/prettier presence) |
| 8 | drupal-expert | `.claude/skills/drupal-expert/SKILL.md` | Persona: Drupal 10/11 DI, OOP hooks vs event subscribers, PHPCS standards, research-first philosophy (check contrib before custom) |
| 9 | drupal-frontend-expert | `.claude/skills/drupal-frontend-expert/SKILL.md` + `references/theming-reference.md`, `references/sdc-guide.md` | Persona: Twig, SDC, Drupal.behaviors, CSS/JS libraries, theme hooks |
| 10 | drupal-security | `.claude/skills/drupal-security/SKILL.md` + `references/` | XSS, SQLi, CSRF, access control, file upload — proactive during development |
| 11 | drupal-site-builder-expert | `.claude/skills/drupal-site-builder-expert/SKILL.md` + `references/` | Persona: Views, content types, Layout Builder, Paragraphs, taxonomy, workflows |
| 12 | drush | `.claude/skills/drush/SKILL.md` | CLI reference (credits factorial-io/skills — MIT attribution at line 10), SQL, PHP eval, deprecated commands |
| 13 | entity | `.claude/skills/entity/SKILL.md` | Custom content/config entity types, handlers, base fields, queries, views integration |
| 14 | generate-tests | `.claude/skills/generate-tests/SKILL.md` + `agent-prompt.md` | Agent-dispatched PHPUnit test generation (unit/kernel/functional/all) |
| 15 | migrate | `.claude/skills/migrate/SKILL.md` | migrate/migrate_plus/migrate_tools workflows: import, rollback, status, debug |
| 16 | performance | `.claude/skills/performance/SKILL.md` | Cache layers, BigPipe, lazy loading, asset aggregation, DB query optimization |
| 17 | refactor | `.claude/skills/refactor/SKILL.md` | Code smell detection: god classes (>300 lines), fat controllers, missing interfaces, Drupal anti-patterns |
| 18 | scaffold | `.claude/skills/scaffold/SKILL.md` | Generate module/service/plugin/form/controller/hook/event-subscriber/entity with PHP 8.3 + Drupal 11 idioms baked in |
| 19 | solr-setup | `.claude/skills/solr-setup/SKILL.md` | DDEV Solr add-on, Search API Solr config, troubleshoot, reindex |
| 20 | update-module | `.claude/skills/update-module/SKILL.md` | Safe contrib update: DB snapshot -> composer update -> config import -> verify -> rollback plan |

**Plus hooks** (not skills but coverage-relevant):
- `.claude/hooks/pre-bash-guard.sh` — blocks `git reset --hard`, `git checkout .`, `git clean -f`, `git push --force`, `git branch -D`, `rm -rf /`, `rm -rf .`, `ddev delete`, `DROP TABLE`, `DROP DATABASE`
- `.claude/hooks/post-generation-lint.sh` — phpcbf -> phpcs (via `ddev exec`) -> local security-perf-scan (grep for `eval()`, `shell_exec()`, `unserialize()`, `\Drupal::` in `src/`, missing `accessCheck()`) -> prettier -> eslint/stylelint
- `.claude/hooks/prompt-context.sh` — opt-in git-status injection

## Q8. Quality signals

- **Last commit**: 2026-03-12 (~1 month before 2026-04-17 analysis date) — **active**.
- **Commit history depth**: `git log --oneline` in the clone shows only `1ef6e0f Update skills` — either a fresh squash or shallow clone. Flag: limited signal about iteration velocity.
- **License**: **none** (INDEX.md line 7). Red flag — without a license the code is technically "all rights reserved". Impediment to redistribution and Composer packaging.
- **Tests**: none. No `tests/`, no eval harness, no CI.
- **CI**: `.github/` absent (INDEX.md line 39). No workflows, no issue templates.
- **Issues**: not inspectable from the local clone.
- **Versioning**: per-skill `version:` field inconsistent (see Q4). No repo-level version tag, no CHANGELOG.md.
- **Maintainer**: single author (gxleano).
- **Docs**: README is strong (323 lines, clear quick-start, manual-setup fallback, usage table). `.claude/hooks/README.md` is thorough. `CLAUDE-TEMPLATE.md` is well-organised.
- **Idempotency**: `setup.sh` explicitly designed idempotent (README.md:195) — mature installer UX.
- **Attribution**: `drush/SKILL.md:10` credits factorial-io/skills under MIT — shows awareness of prior art.

## Q9. Notable innovations

1. **Post-generation lint hook with `ddev exec` integration.** `post-generation-lint.sh` runs `phpcbf` first (auto-fix what's fixable), then `phpcs`, then a local grep-based security-perf scan — all inside the DDEV container — and on failure returns exit 2 so Claude sees the violations and self-corrects in-session. The tightest "ship code Claude can verify" loop in the research set.
2. **Security-perf grep scan as a hook.** Fast local pattern check for `eval()`, `shell_exec()`, `unserialize()`, `\Drupal::` in `src/`, missing `accessCheck()` on entity queries — runs without phpstan and catches the highest-impact Drupal-specific mistakes.
3. **Two-tier skill execution**: "inline" vs "agent-dispatcher". `code-review` and `generate-tests` offload heavy work to a background `general-purpose` Task agent, freeing the main thread and producing persisted reports at `.claude/reviews/<name>.md`. The agent prompt lives in a sibling `agent-prompt.md` file, cleanly separated from the dispatcher SKILL.md.
4. **`doctor` meta-skill** that audits the workflow install itself (hook registration, phpcs/phpstan presence, skill availability). Rare in the research set — treats the agentic harness as a system to diagnose.
5. **`setup.sh --skip-ai-context` optional module analyser**: walks `web/modules/custom/`, extracts real hooks/routes/services from each module's codebase, and writes per-module `AI_CONTEXT.md` files. Project-specific grounding without the user having to hand-author it.
6. **CLAUDE-TEMPLATE.md append pattern**: doesn't own the user's CLAUDE.md, just appends Drupal coding rules + a skills reference table below their existing content, with a per-project "lessons learned" comment block seeded inline (lines 68-72).
7. **Starter theme scaffold shipped inline** (`assets/theme-template/`): STARTER.info.yml, breakpoints, libraries, .theme, templates — ready for `cp` into a new theme.
8. **Research-first philosophy** baked into persona skills (`drupal-expert/SKILL.md:10-24`, `drupal-frontend-expert/SKILL.md:11-17`, `drupal-site-builder-expert/SKILL.md:11-15`): explicitly tells Claude to ask about contrib modules before generating custom code.

## Q10. Weaknesses / gaps

1. **No license file.** Biggest blocker to merging. Without an explicit OSS license the code cannot safely be absorbed into GPL-compatible Drupal contrib (ai_best_practices).
2. **Naming convention clashes with ai_best_practices gerund-prefix.** All 20 skills need renaming; expert-persona skills have no gerund equivalent at all.
3. **Directory is `.claude/skills/` not `skills/`.** ai_best_practices locked `skills/` at project root (agentskills.io convention). `.claude/skills/` is the Anthropic runtime convention — if ai_best_practices is Composer-installable into `/web/modules/contrib/ai_best_practices/skills/`, the user's Drupal project can't have skills live inside a contrib module's dotfile directory.
4. **Metadata bloat + inconsistency.** `version:`, `status:` fields appear in some skills, not others; `api/SKILL.md` has the malformed `status: true`. ai_best_practices locked minimal metadata (`drupal-version` + `status` only); gxleano has `version` (not in the locked set) and no `drupal-version` anywhere.
5. **Hardcoded DDEV assumption.** `post-generation-lint.sh` runs phpcs via `ddev exec`. Users on Lando, native, nix-shell, or remote-dev are unsupported. No DDEV-detection fallback.
6. **No Composer package.** Requires `git clone` + `bash setup.sh` — not discoverable on packagist.org, no `composer require`, no dependency management, no version pinning.
7. **Persona-shaped skills** (`drupal-expert`, `drupal-frontend-expert`, `drupal-site-builder-expert`) duplicate content that is better expressed as action-scoped skills. Three skills each claim "research-first philosophy" (near-identical text) — drift risk.
8. **No tests, no eval harness, no CI.** Claims like "Post-generation hook lints every file automatically" are unverified.
9. **Single-maintainer solo project with no license and one visible commit in the clone** — sustainability risk.
10. **Scope creep vs. ai_best_practices "universal Drupal guidance"**: `solr-setup` and `ddev` are environment-specific; `code-review` and `generate-tests` are tooling-specific agent dispatchers; `doctor` audits gxleano's own harness. These don't obviously belong in a "universal Drupal best practices" module.

## Q11. Compatibility with ai_best_practices decisions

| Decision | gxleano | Gap | Change needed to merge |
|---|---|---|---|
| Gerund-prefix naming | single-word / imperative (`scaffold`, `debug`, `migrate`, `code-review`) + `*-expert` personas | **Incompatible** | Rename all 20 skills to gerund form; fold `*-expert` personas into action-scoped skills; drop persona framing |
| `skills/` at project root | `.claude/skills/` | **Incompatible** directory | Move skills to `skills/` at repo root; update `setup.sh` copy logic; reconcile with Anthropic runtime expectation (symlink or dual-copy) |
| Metadata: `drupal-version` + `status` only | `version:` (inconsistent), `status:` (one instance, malformed on `api`), no `drupal-version` | **Incompatible** | Strip all `version:` fields; add `drupal-version: "10.3+"` or `"11"` to every SKILL.md; normalise `status: stable` |
| Composer-installable | git-clone + bash | **Incompatible** | Add `composer.json` with type=drupal-module (or `type=metapackage`); publish to packagist; replace `setup.sh` with a Composer post-install script or drop the installer entirely |
| Universal Drupal guidance | mixed — some universal (`drupal-security`, `performance`, `accessibility`, `entity`, `api`), some tool-specific (`ddev`, `solr-setup`, `drush`), some harness-specific (`doctor`) | **Partial** | Keep universal skills; extract `ddev`/`solr-setup`/`doctor`/`code-review`/`generate-tests` into a separate companion package; drop `*-expert` personas |
| License | none | **Blocker** | Relicense as GPL-2.0-or-later (Drupal-compatible) before any absorption |

## Q12. Relationship to Surge

Surge is the "aggregator" project in this research set (alphagov/surge — collects Drupal skills from multiple authors into a single installable meta-package, from Phase 1 context).

- **Does Surge aggregate gxleano today?** Unknown from this repo alone; would need to check Surge's catalogue. gxleano is public on GitHub with 20 skills and an active March 2026 commit, so it is a viable aggregation candidate.
- **Could Surge aggregate it?** Mechanically yes — the SKILL.md files are standard Claude Code format and the author credits factorial-io (MIT) for `drush`, showing awareness of cross-pollination. **But the missing license is a legal blocker** until gxleano adds one.
- **Conflict with Surge?** Low functional conflict: gxleano's 20 skills map cleanly to action domains Surge would want. Naming conflict likely (if Surge also has `scaffold`, `debug`, `migrate`, `code-review` skills from other authors) — Surge's aggregation layer must namespace or deduplicate. Hook overlap is the bigger issue: if Surge also ships `post-generation-lint.sh` with different matchers, two post-Write hooks stacking could slow or block the write pipeline. gxleano's `setup.sh` installer also competes with Surge's own installer — they would have to agree on a single install entry point.

## Q13. Verdict

**Reference + selectively absorb.** gxleano has built the most complete "production-ready Drupal agentic harness" in Tier-1 Batch 3: 20 coherent skills, a tight Write -> lint -> self-correct loop via hooks, a polished idempotent installer, and a research-first philosophy that aligns well with ai_best_practices' values. The three genuine innovations worth absorbing into ai_best_practices are (a) the `post-generation-lint.sh` pattern (phpcbf -> phpcs inside DDEV -> security-perf grep scan, exit 2 feeds errors back to Claude), (b) the `pre-bash-guard.sh` destructive-command blocklist, and (c) the agent-dispatcher pattern for `code-review`/`generate-tests` that offloads heavy work to background Task agents with persisted reports. The skill *content* is solid but the naming convention, directory layout, and metadata are incompatible with ai_best_practices' locked decisions — and the missing license makes direct code absorption legally unsafe until gxleano adds GPL-2.0-or-later (or equivalent). Concrete recommendation: reach out to gxleano to (1) add a license, (2) align on gerund naming, (3) collaborate on contributing the hook scripts as a companion `ai_best_practices_tooling` package rather than trying to shoehorn DDEV/solr/doctor into the universal-guidance scope. Meanwhile, ai_best_practices SPEC (Phase 4) should cite gxleano as the reference implementation for the hook-driven lint-feedback loop and the agent-dispatcher skill pattern. Do not ignore — this is one of the two strongest authors in the research set on delivery quality, behind only Surge.

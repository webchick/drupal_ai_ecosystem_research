# grasmash-drupal-claude-skills — Phase 2 Semantic Analysis

**Repo**: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/`
**Upstream**: https://github.com/grasmash/drupal-claude-skills
**Author**: Matthew Grasmick (creator of BLT, Acquia alum, notable Drupal ecosystem voice)
**Last commit**: 2026-03-20 (`008bd15` — "Add install script and improve Quick Install with 4 options")
**License**: MIT

---

## Q0. Primary mode

**(g) mixed — skill content + agent-definitions suite + installer**, leaning heavily on skill content.

- 9 SKILL.md files in `skills/` (agentskills.io convention).
- 8 Claude Code subagent `.md` files in `.claude/agents/`.
- `install.sh` + multi-option "Quick Install" README.
- `.claude/scripts/sync-*.sh` aggregators that pull upstream docs (d9book, ivangrynenko cursorrules) into reference files.

So simultaneously: skill content + agent suite + aggregator + installer. Not a single-axis repo.

## Q1. Problem solved

Packages Drupal-specific AI-assisted development guidance as a *drop-in* bundle for Claude Code users running against a Drupal project: skills activate contextually, 8 purpose-built subagents handle workflow stages (quality-gate, done-gate, drupal-specialist, etc.), sample `.claude/settings.json` guards destructive drush commands, and a README-level "Agent Workflow Guide" codifies a prescriptive process (parallelization, quality-gate-before-commit, done-gate-before-declaring-done, CI test discipline, contrib-patch policy, "landing the plane" session completion). It is deliberately NOT a Drupal module — it is a distribution repo for agent assets.

## Q2. Primary artefact type

SKILL.md files (9) + Claude Code subagent definitions (8). Secondary: `.claude/settings.json` permission template, two bash sync scripts, `install.sh`, `CONTRIBUTING.md` authoring guide.

## Q3. Distribution model

Four parallel install paths documented in `README.md` lines 124-178:
1. **Prompt-based** — Copy-paste natural-language install instructions to any coding agent.
2. **`install.sh` via curl | bash** — Shell-script installer at `/install.sh`.
3. **`npx skills add grasmash/drupal-claude-skills`** — agentskills.io CLI (skills only, not agents).
4. **Manual `cp -r`**.

`install.sh` clones to tempdir, copies `skills/*` → target `.claude/skills/`, copies `.claude/agents/*` → target `.claude/agents/`, conditionally copies `settings.json`, hints at appending AGENTS.md workflow guide.

NOT Composer-installable. NO `composer.json`, NO `package.json`, NO `skills.yaml` manifest.

## Q4. Standards conformance + independent skill-unit detection

### Claimed conformance
`README.md` line 119 badge: "spec-agentskills.io". `CLAUDE.md` bottom section: "Skills follow the Agent Skills Specification (agentskills.io/specification)". `CONTRIBUTING.md` lines 46-82 formalizes the spec locally.

### Independent detection of skill-unit convention

- **Unit**: one directory per skill under `skills/`, each containing a `SKILL.md` (capital).
- **Frontmatter observed in all 9 files**: `name` + `description` only. No version, no drupal-version, no status, no license inline (license only in attribution prose for sourced skills).
- **Optional subdirs observed**: `references/` (6 of 9 skills), `examples/` (1 of 9 — drupal-contrib-mgmt), `.sync-metadata` plain-text file (2 of 9 — the synced skills).
- **Name discipline**: frontmatter `name` exactly matches directory name in all 9 skills (spot-checked).
- **Progressive disclosure**: spec'd by `CONTRIBUTING.md` line 78 and `skill-developer/SKILL.md` lines 43-48 ("Metadata ~100 tokens, Full instructions <5000 tokens, Supporting files as needed"). Variably executed — see Q10.

Conforms to the stated agentskills.io spec. Frontmatter is *narrower* than ai_best_practices decision (no `drupal-version`, no `status`).

## Q5. Architectural pattern (how guidance loads at runtime)

Pure **description-keyword activation** (no hooks, no triggers, no rule file).

- `skills/*/SKILL.md` frontmatter `description` carries trigger keywords; Claude Code's built-in skill scanner matches user intent against descriptions at session start and auto-loads the relevant SKILL body.
- References (`@references/topic.md`) are lazily loaded on demand — the SKILL.md acts as a router.
- Agents in `.claude/agents/*.md` are invoked explicitly (e.g. "spawn quality-gate") per the `AGENTS.md` workflow guide — they are sub-agent definitions, not auto-triggering skills.
- `settings.json` only contains `permissions.ask` patterns for destructive drush commands (file `/home/pointblank/research/repos/grasmash-drupal-claude-skills/.claude/settings.json`) — no hook wiring.

`skill-developer/SKILL.md` lines 80-103 *describes* hook-based activation as an advanced pattern but this repo itself does not ship any hooks.

## Q6. Naming convention vs. gerund-prefix

**All 9 skills use a `drupal-` (or domain) noun-prefix, NOT gerund-prefix.** The ai_best_practices locked decision (gerund-prefix, verb-in-ing) is *violated by every skill* in this repo:

| Skill name | Gerund-prefix? |
|---|---|
| `drupal-at-your-fingertips` | No |
| `drupal-canvas` | No |
| `drupal-config-mgmt` | No |
| `drupal-contrib-mgmt` | No |
| `drupal-ddev` | No |
| `drupal-search-api` | No |
| `drupal-simple-oauth` | No |
| `ivangrynenko-cursorrules-drupal` | No (author-prefix) |
| `skill-developer` | No |

Grasmash's implicit convention: `{subsystem-or-source}-{topic}`. For a gerund-prefix world these would become e.g. `managing-drupal-config`, `updating-drupal-contrib`, `running-drupal-ddev`, `securing-drupal-oauth`, `boosting-drupal-search-api`, `authoring-drupal-skills`.

## Q7. Coverage — one line per topic

| Skill | Topic | File path |
|---|---|---|
| drupal-at-your-fingertips | 50+ Drupal API/content/theming/testing topics via d9book stub-references | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-at-your-fingertips/SKILL.md` |
| drupal-canvas | Canvas Code Components, Nebula template, Acquia SSB integration | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-canvas/SKILL.md` |
| drupal-config-mgmt | drush cim/cex safety, config splits (complete vs partial), prod-merge workflow | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-config-mgmt/SKILL.md` |
| drupal-contrib-mgmt | Composer updates, patch workflow, D11 compatibility gates, upgrade_status | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-contrib-mgmt/SKILL.md` |
| drupal-ddev | DDEV setup, drush integration, xdebug, Mutagen performance, multisite | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-ddev/SKILL.md` |
| drupal-search-api | Index field typing, boolean vs integer boost, custom boost processors | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-search-api/SKILL.md` |
| drupal-simple-oauth | TokenAuthUser decorator, scope/role intersection, field_permissions, CSRF | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-simple-oauth/SKILL.md` |
| ivangrynenko-cursorrules-drupal | OWASP A01-A10 Drupal patterns, DB standards, file permissions | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/ivangrynenko-cursorrules-drupal/SKILL.md` |
| skill-developer | Meta-skill: agentskills.io spec, 500-line rule, progressive disclosure, hook patterns | `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/skill-developer/SKILL.md` |

Agent coverage (`.claude/agents/`):
- `quality-gate.md` — pre-commit code-review checklist (security, perf, testing, regressions)
- `done-gate.md` — completion validator (builds/tests/deliverables)
- `drupal-specialist.md` — Drupal/PHP implementer
- `frontend-specialist.md` — Twig/SCSS/JS specialist
- `researcher.md` — codebase exploration
- `reviewer.md` — code-review generalist
- `test-runner.md` — test execution
- `test-writer.md` — ExistingSite DTT test writer

## Q8. Quality signals

- **Git history**: 1 commit total (`008bd15` on `2026-03-20` by Matthew Grasmick). The repo was evidently force-pushed / squash-imported; full development history is upstream. Treat as recently-published rather than dead.
- **Contributors**: 1 (Grasmick).
- **Issues / CI**: `.github/` absent (INDEX.md line 36). No GitHub Actions, no tests, no linting. Issue queue status not observable from clone.
- **Tests**: None in repo.
- **License**: MIT (LICENSE file present).
- **Maintainer authority**: High — Grasmick is ex-Acquia, BLT lead, and an established Drupal ecosystem voice; the skills are clearly drawn from real production experience (simple_oauth deep-dive cites file paths and line numbers in `docroot/modules/contrib/simple_oauth/src/Authentication/TokenAuthUser.php`).
- **Freshness**: References `.sync-metadata` last sync `2025-10-31`; repo commit `2026-03-20`. Current as of analysis date (2026-04-17).
- **Documentation quality**: High in the author's own skills (`drupal-config-mgmt`, `drupal-contrib-mgmt`, `drupal-simple-oauth`, `drupal-search-api`). Low in the *synced* `drupal-at-your-fingertips` skill (see Q10).

## Q9. Notable innovations

1. **Four-path install with prompt-based #1** (`README.md` lines 125-138). The "copy this prompt into Claude Code" install option is a genuinely novel distribution UX — the AI *itself* is the package manager. Worth stealing.
2. **Upstream-sync aggregator pattern** (`.claude/scripts/sync-d9book.sh`, `.claude/scripts/sync-ivan-rules.sh` + `.sync-metadata` sidecar). Declarative provenance tracking of which skills are synthesized from upstream sources. Clean pattern.
3. **Agent workflow prose** (`AGENTS.md`). Codifies a five-gate workflow (parallelization → quality-gate → done-gate → local-execution → CI-discipline → session-completion) into prescriptive English that gets appended to the host project's `CLAUDE.md`. This is skill-for-humans rather than skill-for-model.
4. **"Drupal data integrity" checklist** in `quality-gate.md` lines 43-47 — specifically calls out `hook_update_N` vs standalone scripts, and direct-DB-vs-entity-API for large-update-hook OOM. This is hard-won production knowledge.
5. **OAuth skill depth** — `drupal-simple-oauth/SKILL.md` cites exact file paths and line numbers in contrib source, documents the double-intersection of scopes and roles, and names pitfalls. Among the strongest skill bodies in the entire Drupal AI ecosystem surveyed so far.
6. **Meta-skill (`skill-developer`)** ships inside the skill bundle — self-documenting, explains the agentskills.io spec to the model when the user asks for a new skill.
7. **Sample `settings.json`** (`.claude/settings.json`) flags exactly the destructive drush commands that deserve friction (`config:import`, `cim`, `sql-drop`, `site:install`). Small but immediately useful pattern for ai_best_practices.

## Q10. Weaknesses / gaps

1. **`drupal-contrib-mgmt/SKILL.md` is 961 lines**, nearly 2× the 500-line rule that the same repo's `CONTRIBUTING.md` line 78 and `skill-developer/SKILL.md` line 184 mandate. Self-inconsistent.
2. **`drupal-config-mgmt/SKILL.md` is 570 lines**, also over the 500-line rule. `drupal-ddev/SKILL.md` (518 lines) and `drupal-simple-oauth/SKILL.md` (514 lines) are marginally over.
3. **`drupal-at-your-fingertips` references are empty stubs.** Verified `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/drupal-at-your-fingertips/references/services.md` is 22 lines consisting of a URL pointer to `https://drupalatyourfingertips.com/services` plus boilerplate — no actual content. All 53 topic files follow this pattern (generated by `sync-d9book.sh` lines 108-130). The skill is effectively a *table of contents of external URLs*, not a body of guidance. The model gains nothing from loading these references. Major false-advertising risk.
4. **Naming violates the ai_best_practices gerund-prefix decision** — 9/9 skills.
5. **Frontmatter lacks `drupal-version` and `status`** — the two ai_best_practices metadata keys.
6. **No Composer distribution** — ai_best_practices settled on Composer-installable; this repo is bash/curl/npx.
7. **No tests, no CI, no eval harness** for skill activation.
8. **Squashed git history** means authorship provenance of the synced content is rolled into one commit — attribution is prose-only.
9. **`ivangrynenko-cursorrules-drupal` bundles full rule text** (spot-checked `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/ivangrynenko-cursorrules-drupal/references/authentication-security.md`) which is the *correct* way to do upstream sync — contrast with the d9book stubs. Inconsistent execution of the same pattern.
10. **Agent suite `drupal-specialist.md` hardcodes project paths** (`docroot/modules/custom/`, `docroot/themes/custom/`) and a DDEV assumption — reduces portability.
11. **`CLAUDE.md` symlinks to `AGENTS.md`** (verified `ls -la`). Cute but an agent that follows the CLAUDE.md-first convention and a parallel agent that follows AGENTS.md-first won't know they're reading the same file.

## Q11. Compatibility with ai_best_practices decisions

| Decision | grasmash repo | Compatible? |
|---|---|---|
| Skill naming: gerund-prefix, verb-in-ing | `drupal-*` noun-prefix | **No** — 9/9 violations |
| Directory: `skills/` at project root | `skills/` at root | **Yes** |
| Metadata: `drupal-version` + `status` | name + description only | **No** — missing both |
| Distribution: Composer-installable | bash/curl, npx skills, manual cp | **No** |
| Scope: universal Drupal guidance | Mostly universal; drupal-canvas and drupal-simple-oauth lean specific | **Mostly yes** |

Net: **directory convention matches, naming/metadata/distribution all diverge.** Valuable *content* locked inside an incompatible *shell*.

## Q12. Relationship to Surge

Surge (Lullabot) and grasmash are **parallel, non-overlapping in content, overlapping in form**:

- Both adopt agentskills.io SKILL.md directory convention.
- Both use description-keyword activation with no hooks.
- Surge ships as a Composer-installable Drupal module (the ai_best_practices preferred distribution); grasmash ships as npx/curl/manual — *grasmash does NOT solve the Composer-distribution problem Surge solves*.
- Surge scope ≈ universal Drupal meta-guidance; grasmash scope ≈ universal + heavy vertical depth (OAuth, search-api, contrib-mgmt) + 8 Claude Code subagents Surge does not have.
- Grasmash's skills would slot cleanly into Surge's skill inventory if renamed to gerund-prefix and stripped of the 500-line violations. No semantic conflict — topics are disjoint or complementary.
- Grasmash's `quality-gate` / `done-gate` subagents are a valuable *complement* to Surge (Surge is skill-only; grasmash ships opinionated workflow agents).

## Q13. Verdict

**Absorb (content) + reference (distribution/workflow patterns).**

Specific recommendations for ai_best_practices:

- **Absorb** the *body* of `drupal-config-mgmt`, `drupal-contrib-mgmt`, `drupal-simple-oauth`, `drupal-search-api`, and `drupal-ddev` after renaming to gerund-prefix (`managing-drupal-config`, `updating-drupal-contrib`, `securing-drupal-oauth`, `boosting-drupal-search-api`, `running-drupal-ddev`) and splitting the >500-line files via proper progressive disclosure.
- **Absorb** the `.claude/settings.json` destructive-drush `ask` patterns verbatim as a starting point for ai_best_practices' recommended settings.
- **Reference** the `quality-gate` / `done-gate` subagent definitions as exemplars for a future ai_best_practices "workflow agents" tier (not an immediate deliverable).
- **Reference** the prompt-based install path (`README.md` option 1) as a distribution idea alongside Composer.
- **Reference** the `.sync-metadata` provenance pattern for any future upstream-sourced ai_best_practices skills.
- **Ignore** the `drupal-at-your-fingertips` skill — it is table-of-contents, not content. If ai_best_practices wants d9book coverage, sync the actual content or omit.
- **Do NOT adopt** the `drupal-*` noun-prefix naming — violates our locked gerund-prefix decision.
- **Do NOT adopt** the npx/curl distribution — we are Composer.

---

## File-path appendix

- Repo root: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/`
- INDEX: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/INDEX.md`
- README: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/README.md`
- CLAUDE.md (symlinks to AGENTS.md): `/home/pointblank/research/repos/grasmash-drupal-claude-skills/CLAUDE.md`
- Install script: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/install.sh`
- Settings template: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/.claude/settings.json`
- Sync scripts: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/.claude/scripts/sync-d9book.sh`, `sync-ivan-rules.sh`
- Skills: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/skills/{drupal-at-your-fingertips,drupal-canvas,drupal-config-mgmt,drupal-contrib-mgmt,drupal-ddev,drupal-search-api,drupal-simple-oauth,ivangrynenko-cursorrules-drupal,skill-developer}/SKILL.md`
- Agents: `/home/pointblank/research/repos/grasmash-drupal-claude-skills/.claude/agents/{quality-gate,done-gate,drupal-specialist,frontend-specialist,researcher,reviewer,test-runner,test-writer}.md`

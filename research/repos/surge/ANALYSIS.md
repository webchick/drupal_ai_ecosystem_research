# surge — Semantic Analysis

Repo: `/home/pointblank/research/repos/surge/` (drupal/surge, `1.0.x` branch, last commit 2026-04-04).
Ground truth: `/home/pointblank/research/repos/surge/INDEX.md`.

## Q0. Primary mode

**(b) tooling / aggregator / installer.**

Surge ships zero skill content of its own. It is a Composer plugin + CLI that (1) scans a Drupal project's `vendor/*`, `web/modules/*`, `modules/*`, and project-root for directories named `.agents/skills/`, `.claude/skills/`, or `skills/`, (2) validates each discovered skill's `SKILL.md` against the agentskills.io spec, (3) aggregates them into a single configurable output directory, and (4) also generates a project-tailored `AGENTS.md` from modular templates it bundles.

Evidence:
- No `skills/` directory at repo root (INDEX.md:24).
- `src/Skills/SkillsScanner.php:46-98` — scan-all entry point; never loads embedded skills.
- `src/Skills/SkillsAggregator.php:61-191` — copies discovered skills into `output_directory`.
- `composer.json:5` — `"type": "composer-plugin"`.
- `composer.json:7` — `"drupal/ai_skills": "*"` is a hard dependency; surge itself expects a separate content package to supply skills.

The only content surge bundles is in `src/Agents/templates/` (13 section markdown templates + 4 environment template sets), used by `agents-generate` to compose an `AGENTS.md` — not distributed as Agent Skills. Mode is cleanly (b), not (g) mixed.

Consequences: Q5 becomes "how does surge aggregate content?"; Q6 effectively N/A (surge enforces agentskills.io lowercase/hyphenated rules only, see `SkillValidator.php:294-365`); Q7 N/A for skill coverage.

## Q1. Problem solved

Surge frames itself as "an AI coding standard kit for Drupal development" that "gives AI tools the context they need to work *with* Drupal, not around it" (README.md:5-7). The framing is explicit: Surge is *not* a finished product or opinionated skill library; it is "a foundation" and "a forward movement shaped by shared direction and collective effort within the Drupal ecosystem" (README.md:11). Its contribution is glue — an open-standards-based aggregator that lets a Drupal project install skills from multiple packages into one place for consumption by Claude Code, Cursor, OpenCode, etc. (src/Skills/README.md:1-3).

## Q2. Primary artefact type

**Aggregator (Composer plugin + Symfony Console app) + AGENTS.md generator.** Not skills, agents-as-content, commands, hooks, or prompts. Two subsystems:
- `src/Skills/` — discovery/validation/aggregation of externally contributed Agent Skills.
- `src/Agents/` — composition of a per-project `AGENTS.md` from bundled Markdown templates (`src/Agents/templates/sections/*.md`, `src/Agents/templates/environments/{ddev,lando,docker-compose,vanilla}/*.md`).

## Q3. Distribution model

**Composer plugin, installed as a dev dependency.**
- Install: `composer require drupal/surge --dev` (README.md:24).
- Consent: `composer config allow-plugins.drupal/surge true` (README.md:32).
- On install, the plugin auto-rewrites the consumer's `composer.json`: (a) adds a `composer surge` script, (b) adds `@composer surge skills-install` to `post-install-cmd` and `post-update-cmd` (`src/Surge/Composer/SurgePlugin.php:53-211`). It also drops a default `surge.yaml` into the project root if absent (`SurgePlugin.php:129-168`, sourced from `surge.yaml.dist`).
- Runtime commands: `composer surge skills-install`, `composer surge skills-list`, `composer surge agents-generate` (dispatched via `src/Surge/Console/SurgeApplication.php:14-114`).

## Q4. Standards conformance

**agentskills.io SKILL.md spec — validator-enforced.** Multi-tool by design.

Independent detection of this repo's own skill-unit convention: **none.** Surge ships no skill units. Its validator (`SkillValidator.php`) expects `SKILL.md` (capital, see `SkillsConfig.php:41` — `const SKILL_MD_FILENAME = 'SKILL.md'`) with YAML frontmatter containing these allowed fields only: `name`, `description`, `license`, `allowed-tools`, `metadata`, `compatibility` (`SkillValidator.php:32-39`). Extra fields fail validation (`SkillValidator.php:262-278`). Name rules (`SkillValidator.php:294-365`): lowercase, letters/digits/hyphens only, no leading/trailing/consecutive hyphens, max 64 chars, directory name must equal skill name.

AGENTS.md: present at repo root and generated for consumers. Tool-agnostic — README lists "Claude Code, Cursor, and other AI tools" (README.md:48) and "Claude Code, Cursor, OpenCode, and other AI tools" (src/Skills/README.md:3).

INDEX.md's "SKILL.md count = 0" is literally accurate because no skill content exists in this repo — surge's `SkillValidator` is exactly the code that enforces the uppercase spelling in consumer projects.

## Q5. Architectural pattern (reframed: "how does it aggregate?")

**Recursive filesystem scanner + spec-compliant validator + copy-based aggregator.** Loading is build-time, not runtime; there is no semantic index, no routing layer, and no lazy loading. The resulting `.agents/skills/` directory is then consumed by whatever AI tool the developer uses.

Pipeline (`src/Skills/SkillsAggregator.php:61-191`, driven by `src/Skills/SkillsScanner.php`):

1. **Discover.** `SkillsScanner::scanAllSkills` (`SkillsScanner.php:46-98`) walks the project. Container-name priority via `SkillsConfig::getSkillDirectoryNames()` (`SkillsConfig.php:72-78`): `.agents/skills` > `.claude/skills` > `skills`. Sources: project-root > `web/modules/*` and `modules/*` > `vendor/*`. Highest-priority definition of a skill name wins (`SkillsScanner.php:69-74`, 200-206).
2. **Validate.** Each candidate dir must contain `SKILL.md` (`SkillsScanner.php:341-346`). On aggregation, `SkillValidator` parses YAML frontmatter, enforces allowed-fields set, name rules, description ≤1024 chars, compatibility ≤500 chars (`SkillValidator.php:50-130`).
3. **Filter.** `exclude_skills` in `surge.yaml` drops `source:skill-name` identifiers (`SkillsScanner.php:375-397`).
4. **Aggregate.** Copy the skill directory — SKILL.md + optional `scripts/`, `references/`, `assets/` — into `output_directory` (default `.agents/skills/`, configurable via `skills.output_directory` in `surge.yaml`; see `SkillsConfig.php:89-93` and `surge.yaml.dist:5`). Full copy with symlink-skipping and path-traversal defence (`SkillsAggregator.php:204-320`; `src/Surge/PathSecurity.php` underpins every filesystem op).

The `agents-generate` command uses a second, parallel pattern: detect environment (`src/Agents/EnvironmentDetector.php`) → select template sections (`src/Agents/SectionComposer.php`) → substitute placeholders → write `AGENTS.md`. Template composition, not skill loading.

## Q6. Naming convention

**N/A for surge's own content (it has none).** Surge as a *validator* enforces the agentskills.io name rules: lowercase, Unicode letters + digits + hyphens, no leading/trailing/consecutive hyphens (`SkillValidator.php:294-365`). It does **not** mandate gerund vs. noun form — `writing-automated-tests`, `testing`, and `drupal-agents-generator` all pass.

Neutral w.r.t. ai_best_practices' gerund-prefix decision: surge will happily aggregate ai_best_practices skills whatever naming they adopt, provided names are lowercase-hyphenated.

## Q7. Coverage

**No Agent Skill coverage.** The bundled AGENTS.md template sections cover a Drupal-topic set, but these are Markdown fragments assembled into a single AGENTS.md — not skills, not individually loadable, not frontmattered.

Topics in `src/Agents/templates/sections/`:
| Topic | File |
|---|---|
| Project overview | `src/Agents/templates/sections/project-overview.md` |
| Code style | `src/Agents/templates/sections/code-style.md` |
| Entity API | `src/Agents/templates/sections/entity-api.md` |
| Forms API | `src/Agents/templates/sections/forms-api.md` |
| Hooks | `src/Agents/templates/sections/hooks.md` |
| Plugin system | `src/Agents/templates/sections/plugin-system.md` |
| Routes & controllers | `src/Agents/templates/sections/routes-controllers.md` |
| Services & DI | `src/Agents/templates/sections/services-di.md` |
| Caching | `src/Agents/templates/sections/caching.md` |
| Security | `src/Agents/templates/sections/security.md` |
| Testing | `src/Agents/templates/sections/testing.md` |
| Batch / queue / AJAX | `src/Agents/templates/sections/batch-queue-ajax.md` |
| Resources | `src/Agents/templates/sections/resources.md` |

Environment-specific fragments (setup/commands/overview/debugging/troubleshooting) for DDEV, Lando, Docker Compose, Vanilla in `src/Agents/templates/environments/{env}/`. These overlap substantially with what ai_best_practices will cover as skills — a real coexistence question (Q11).

## Q8. Quality signals

- **Last commit**: `c6749be feat: #3583105 Update the default directory for skills`, 2026-04-04 (INDEX.md:5-6). Local clone is shallow — only one commit visible; fuller history on drupal.org.
- **Issue tracking**: commit references drupal.org issue `#3583105`; active issue-queue workflow on drupal.org/project/surge.
- **Tests**: PHPUnit 10, comprehensive. 1,615 lines across 7 files:
  - `tests/Surge/PathSecurityTest.php` (330 lines)
  - `tests/Skills/SkillValidatorTest.php` (393 lines)
  - `tests/Skills/SkillsAggregatorTest.php` (339 lines)
  - `tests/Skills/SkillsScannerTest.php` (132 lines)
  - `tests/Skills/SkillsAggregatorComposerPluginRegressionTest.php` (137 lines)
  - `tests/Agents/EnvironmentDetectorTest.php` (169 lines)
  - `tests/Agents/SectionComposerTest.php` (115 lines)
  - AGENTS.md reports "58 tests total (155 assertions when all suites pass)" (AGENTS.md:45).
  - PHPUnit config is strict: `failOnRisky="true"`, `failOnWarning="true"`, `beStrictAboutOutputDuringTests="true"` (`phpunit.xml:7-10`).
- **Eval harness**: none. Unit/integration tests of the scanner/aggregator/validator only — not evals of AI output quality.
- **CI**: no `.github/` (INDEX.md:37). Presumably drupal.org's GitLab CI; not visible in clone.
- **Versioning**: `"type": "composer-plugin"` with `1.0.x` branch; application announces itself as `1.0.0` (`SurgeApplication.php:19`).
- **Licence**: **none declared in repo** (INDEX.md:7). Significant gap for a Composer package pulled into downstream projects.
- **Maintainer**: Drupal contrib (drupal/surge) — issue queue-driven, active.

## Q9. Notable innovations

1. **Explicit separation of aggregator from content.** Unlike most entries in this research set, surge refuses to ship skill content. `composer.json:7` requires `drupal/ai_skills` as the canonical content source. Natural "bus" for multiple content packages.
2. **Multi-source priority model with explicit precedence.** Project > modules > vendor, and within a source `.agents/skills` > `.claude/skills` > `skills` (`SkillsConfig.php:72-78`, `SkillsScanner.php:67-74`, 200-206). Predictable override path without deleting upstream skills.
3. **Auto-register Composer scripts + auto-drop `surge.yaml`.** On first install, the plugin rewrites the consumer's `composer.json` to hook `skills-install` into `post-install-cmd` / `post-update-cmd` (`SurgePlugin.php:185-211`). Skills stay fresh with no developer action.
4. **Serious path-security posture.** Every filesystem op goes through `src/Surge/PathSecurity.php`. Sanitises components, rejects null bytes and `..`, canonicalises, validates against base, skips symlinks. 330-line dedicated test file (`tests/Surge/PathSecurityTest.php`). Unusual and valuable for a Composer plugin that walks vendor trees.
5. **Alignment with `agentskills#15`.** Default `output_directory` is `.agents/skills/` following the ecosystem convergence issue (README.md:46-50, `SkillsConfig.php:26`). Early public position on the shared location.
6. **XML output mode for file-based tooling.** `skills-list --format=xml` (src/Skills/README.md:105-114) formats results as `<available_skills><skill>…</skill></available_skills>` for pipelines that slurp skill metadata.

## Q10. Weaknesses / gaps

1. **No licence declared** (INDEX.md:7). For a Composer plugin intended for widespread dependency use, a distribution blocker in many organisations.
2. **Hand-rolled YAML frontmatter parser** (`SkillValidator.php:141-222`) despite `symfony/yaml` being a declared dependency (`composer.json:11`). Doesn't handle quoted strings with colons, multi-line scalars, or nested arrays cleanly — the code itself flags this: "For production, consider using symfony/yaml component" (`SkillValidator.php:151`). Risk of false-negative validation on valid SKILL.md files.
3. **Hard dependency on `drupal/ai_skills`** (`composer.json:7`). Even projects that intend to use *only* ai_best_practices are forced to pull ai_skills transitively. Couples surge to a specific content project.
4. **AGENTS.md templates duplicate skill-scope content.** Bundled sections (code-style, entity-api, hooks, security, testing, ...) will drift from parallel Agent Skills content elsewhere in the ecosystem, creating two sources of truth.
5. **No `.github/` CI visible** in the clone (INDEX.md:37); cannot independently verify test-green on each commit from this mirror.
6. **No CLAUDE.md** (INDEX.md:21). Minor documentation gap — the scanner does handle `.claude/skills/`, it's just not called out for Claude Code users.

## Q11. Compatibility with ai_best_practices decisions

| Decision | Surge stance | Gap |
|---|---|---|
| Skill naming: gerund-prefix (`writing-automated-tests`) | Neutral. Validator enforces lowercase + hyphen rules only (`SkillValidator.php:294-365`); gerund form fine. | None. |
| Directory: `skills/` at project root | Surge scans `skills/` as one of three discovery paths (`SkillsConfig.php:72-78`). *Third* priority after `.agents/skills/` and `.claude/skills/`, but fully supported. Default *output* is `.agents/skills/`. | Minor: if ai_best_practices wants installed location to stay `skills/`, consumers need `skills.output_directory: skills` in `surge.yaml` (one line). Source-side `skills/` is supported as-is. |
| Metadata: minimal — `drupal-version` + `status` only | **Direct conflict.** `SkillValidator::ALLOWED_FIELDS` (`SkillValidator.php:32-39`) is: `name`, `description`, `license`, `allowed-tools`, `metadata`, `compatibility`. Surge will **reject** any SKILL.md with `drupal-version` or `status` as top-level frontmatter fields (`SkillValidator.php:262-278`). | ai_best_practices must nest them: `metadata:\n  drupal-version: "10\|11"\n  status: stable` validates. Or encode them in the `compatibility:` string (≤500 chars). |
| Distribution: Composer-installable package | Perfect fit — surge is designed to aggregate Composer packages (`SkillsScanner.php:138-160`). | None. |
| Scope: universal guidance, not project-specific | Surge's scope is broader (also handles project-specific additions). No conflict; ai_best_practices becomes one canonical source among possibly many. | None. |

**What needs to change for clean coexistence:** only the metadata encoding. Put `drupal-version` and `status` inside the nested `metadata:` map or in `compatibility:`. No code changes to either project required beyond convention.

## Q12. Surge's contract with content sources (e.g. ai_best_practices)

Surge positions itself as infrastructure, not content, and the contract is **explicit**:

1. **README framing.** "This is a foundation, not a finished product" (README.md:11). "You can adopt only what you need, extend where it makes sense, and compose your own setup without locking yourself into specific tools or formats" (README.md:9).
2. **Standards orientation.** "Skills follow the Agent Skills specification (https://agentskills.io/) for discoverable, reusable capabilities" (README.md:17). Contract: conform to agentskills.io and surge will discover, validate, and aggregate you.
3. **Composer dependency.** `drupal/ai_skills` is a hard `require` (`composer.json:7`), treating ai_skills as the reference content package. An ai_best_practices package would sit alongside ai_skills in `vendor/` and be picked up by the same recursive scan.

Implicit contract for content sources:
- Ship a directory named `.agents/skills/`, `.claude/skills/`, or `skills/` anywhere under your package (`SkillsConfig.php:72-78`).
- Each skill = subdirectory containing `SKILL.md` with YAML frontmatter validating against `SkillValidator::ALLOWED_FIELDS` (`SkillValidator.php:32-39`).
- Skill directory name must equal the `name` frontmatter field (`SkillValidator.php:351-362`).
- You get precedence rules for free: project > module > vendor (`SkillsScanner.php:200-206`). Name collisions between two vendor packages resolve by scan order (first match wins) — a mild gap with no explicit tie-breaker.

Surge does **not** contract for: skill content quality, naming taxonomy, topic coverage, versioning semantics, or update cadence. Those are content-source responsibilities.

## Q13. Verdict

**Collaborate.**

Surge is the natural delivery substrate for ai_best_practices. Rather than ai_best_practices building its own installer, it should:

1. Publish as a Composer package with skills in `skills/` at package root (already the locked ai_best_practices directory decision).
2. Ensure every SKILL.md uses `metadata:` nested mapping for `drupal-version` and `status` rather than flat top-level fields (otherwise `SkillValidator` rejects them — Q11).
3. Rely on surge for discovery, validation, aggregation, and the `post-install-cmd` auto-update hook.

Why "collaborate" not "absorb":
- Surge has substantial, well-tested infrastructure (1,615 lines of tests, hardened path security, Composer plugin integration) that ai_best_practices shouldn't reimplement.
- Surge's scope explicitly includes multi-source aggregation — ai_best_practices is one source among many.

Why "collaborate" not "reference":
- The integration is mechanical and low-friction (one composer require, one metadata convention). Reference-only would leave ai_best_practices reinventing installer machinery unnecessarily.

Open questions to raise with surge maintainers:
- Swap the hand-rolled YAML parser (`SkillValidator.php:141-222`) for `symfony/yaml` (already a dependency). Reduces risk of false-negative validation on edge-case frontmatter.
- Declare a licence. `composer require drupal/surge --dev` into commercial Drupal projects currently pulls unlicensed code.

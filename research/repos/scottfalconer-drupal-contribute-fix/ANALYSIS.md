# scottfalconer-drupal-contribute-fix — Tier 2 LITE Analysis

**Repo**: https://github.com/scottfalconer/drupal-contribute-fix
**Last commit**: 2026-03-03 ("Use drupalorg-cli when available")
**License**: GPL-2.0-or-later
**Scope**: Single-skill repo (1 SKILL.md at root) that gatekeeps Drupal contrib/core edits by searching drupal.org before generating local diffs.

---

## Q1. Problem Solved

Prevents AI agents from "hacking" Drupal contrib/core files locally and producing duplicate, low-quality, or upstream-diverging fixes. The skill intercepts any edit to `web/modules/contrib/*`, `docroot/modules/contrib/*`, or `core/*` and forces a drupal.org issue-queue search FIRST, only proceeding to generate a local `.diff` + paste-ready issue comment if no existing MR/patch is found. Also enforces PHP lint, PHPCS, hack-pattern detection, and a mandatory human-review step before any submission.

Framed mission from `README.md:103-107`: "High Signal, Zero Noise" — targeted (search first), high-quality (lint/PHPCS/hack-flag), maintainer-first (never auto-posts).

Cited evidence: `SKILL.md:1-14` (trigger description), `SKILL.md:63-87` (FIRST STEP preflight rule), `SKILL.md:249-267` (gatekeeper exit codes).

## Q2. Primary Artefact Type

**Claude Agent Skill (single-skill repo) backed by a Python CLI toolkit.**

- Root-level `SKILL.md` with YAML frontmatter (`name`, `description`, `license`, `metadata.author`, `metadata.version`) — `SKILL.md:1-14`.
- Python script `scripts/contribute_fix.py` implements subcommands `preflight`, `package`, `test`, `reroll` — `scripts/contribute_fix.py:1-25`.
- Supporting library in `lib/` (10 Python modules: `drupalorg_api.py`, `issue_matcher.py`, `patch_packager.py`, `security_detector.py`, `validator.py`, `report_writer.py`, `baseline_repo.py`, `issue_queue_integration.py`, `drupalorg_urls.py`, `__init__.py`) — per `INDEX.md:47-81`.
- References (`references/*.md`) and one example (`examples/sample-report.md`).
- Pytest suite (`tests/test_*.py`, 5 files).

Not a Drupal module, not Composer-installable, no `composer.json` or `package.json` (`INDEX.md:31-33`).

## Q3. Distribution Model

**Git clone + script execution.** No Composer, no npm, no plugin registry.

- `README.md:214-220` instructs `git clone <repository-url>; cd drupal-contribute-fix`.
- Skill is expected to live at `$HOME/.agents/skills/drupal-contribute-fix` or `$HOME/.codex/skills/drupal-contribute-fix` (per `SKILL.md:57-59` discovery loop).
- Python 3.8+ stdlib only, zero pip dependencies — `requirements.txt:1-6`.
- Optional runtime dependency: `drupalorg-cli` (mglaman's PHP PHAR, recommended via DDEV) — `README.md:222-261`.

No composer installer; no `drupal-recipe`, `drupal-module`, or `drupal-skill` type declared anywhere in tree.

## Q4. Standards Conformance + Skill-Unit Convention (Independent Detection)

**Skill-unit convention detected:** Anthropic Claude Agent Skill / Codex skill, SKILL.md at repo root.

Evidence gathered independently:
- Exactly 1 SKILL.md present, at `/SKILL.md` (`INDEX.md:37-45`).
- YAML frontmatter keys: `name`, `description`, `license`, `metadata.{author,version}` — matches Anthropic Skills spec.
- README badge "Agent Skill Compatible" — `README.md:91`.
- Expected install paths `~/.agents/skills/<name>/` and `~/.codex/skills/<name>/` — `SKILL.md:57-59` — indicate both Claude Agent SDK and OpenAI Codex CLI skill loaders.
- No `drupal-version` metadata key (ai_best_practices standard uses `drupal-version` + `status`); instead uses `version: "1.7.0"` (semver of the skill itself) and no explicit Drupal-version pin.
- Skill name `drupal-contribute-fix` is **verb-hyphen-noun** style (`contribute-fix`), NOT gerund/verb-in-ing (ai_best_practices locked convention would be `contributing-fixes` or `fixing-contrib-bugs`).

No `skills/` directory (skill IS the repo). No Composer package metadata to conform with Drupal packagist types.

## Q7. Coverage — Drupal Topics

Narrow, single-purpose coverage of **the drupal.org contribution workflow**, not general Drupal development. Topics covered with file paths:

| Topic | File |
|---|---|
| Drupal.org API (`api-d7`) querying, issue search | `lib/drupalorg_api.py` |
| Drupal.org / git.drupalcode.org URL building | `lib/drupalorg_urls.py` |
| Issue candidate matching / scoring | `lib/issue_matcher.py` |
| Baseline repo detection + checkout for patch generation | `lib/baseline_repo.py` |
| Patch generation + naming | `lib/patch_packager.py` |
| Security-sensitive change detection (access bypass, SQLi sinks, auth) | `lib/security_detector.py` |
| PHP lint + PHPCS validation | `lib/validator.py` |
| Report / ISSUE_COMMENT / WORKFLOW markdown generation | `lib/report_writer.py` |
| Issue queue deep-triage handoff to companion `drupal-issue-queue` | `lib/issue_queue_integration.py` |
| Drupal core testing guidance (Unit/Kernel/Functional, coverage requirement) | `references/core-testing.md` |
| Hack pattern catalog (cache disable, swallowed exceptions, access bypass, hardcoded IDs, DI violations) | `references/hack-patterns.md` |
| Issue status code semantics (needs review, RTBC, fixed, etc.) | `references/issue-status-codes.md` |
| Patch filename / format conventions (lowercase, hyphens, `comment-next`, `do-not-test`) | `references/patch-conventions.md` |
| MR-first vs legacy-patch workflow decision | `SKILL.md:268-284`, emitted `WORKFLOW.md` |
| Security Team escalation (exit 50) | `SKILL.md:452-462` |
| GitLab CI pipeline status checking via `drupalorg-cli` | `SKILL.md:556-574` |
| Local CI parity (`gitlab-ci-local`) evidence archiving | `SKILL.md:434-449`, `SKILL.md:582-592` |

Explicitly **not covered**: entity API, hook patterns, theming, Twig, config management, Views, general D10/D11 site building, DI service definitions, accessibility, performance.

## Q8. Quality Signals

Strong signals:
- **Tests present**: 5 pytest files in `tests/` (`test_contribute_fix_test_command.py`, `test_drupalorg_urls.py`, `test_issue_queue_integration.py`, `test_patch_packager.py`, `test_report_writer_mr_workflow.py`) — `INDEX.md:75-80`.
- **Zero-dependency Python** (stdlib only) — `requirements.txt:1-6`. Reduces install friction and supply-chain surface.
- **Explicit exit-code contract** (0/10/20/30/40/50) documented in both `SKILL.md:256-263` and `scripts/contribute_fix.py:8-14` — enables scripting and agent gating.
- **False-positive guard** requires file-level verification before accepting "already fixed" — `SKILL.md:75-86`. Rare in the corpus; shows attention to LLM confabulation.
- **Security escalation path** with concrete indicators (`security_detector.py`, exit 50) and redirect to Security Team process — `SKILL.md:452-462`.
- **Honest validation**: "Never claims tests passed if they weren't run" — `SKILL.md:481`.
- **Companion-skill awareness**: explicitly splits responsibility with `drupalorg-cli` (execution) and `drupal-issue-queue` (deep triage) — `SKILL.md:22-50`, `SKILL.md:95-106`.
- **Recent activity**: last commit 2026-03-03, adding `drupalorg-cli` integration — demonstrates maintenance.
- **Sample output** provided — `examples/sample-report.md`.
- **MANDATORY `--test-steps`** with concrete format guidance — `SKILL.md:384-402`. Blocks generic-placeholder laziness.

Weak signals:
- GPL-2.0+ license (Drupal-compatible).
- Solo author attribution (`metadata.author: "Drupal Community"` is aspirational; repo is scottfalconer-owned).
- Badge-heavy README is marketing-flavored but backed by actual behavior in code.
- No CI workflow (`.github/` absent — `INDEX.md:35`), so tests are only run locally.

## Q11. Compatibility with ai_best_practices LOCKED Decisions

| ai_best_practices decision | This repo | Match? |
|---|---|---|
| Skill naming: gerund-prefix, verb-in-ing | `drupal-contribute-fix` (verb-noun) | **No** |
| Directory: `skills/` at project root | SKILL.md at repo root; no `skills/` dir | **No** (but this repo IS a single skill) |
| Metadata: minimal — `drupal-version` + `status` only | Uses `license`, `metadata.author`, `metadata.version`; no `drupal-version`, no `status` | **No** |
| Distribution: Composer-installable | Git-clone + Python script; no `composer.json` | **No** |
| Scope: universal Drupal guidance | Single narrow workflow (drupal.org contribution gatekeeping) | **Partial** — universal to Drupal contrib contributors, but single-purpose, not guidance-library |

**Overall compatibility: low on packaging/naming, high on intent.** This repo would need renaming (e.g. `contributing-upstream-fixes`), wrapping its Python toolkit into a Composer-compatible skill package, and reducing frontmatter to `drupal-version`+`status` to align. Functionally, its domain (upstream contribution) is a valuable addition to a universal-guidance library but is an execution-oriented skill (runs Python, hits drupal.org API), not a guidance-only Markdown skill.

## Q13. Verdict — **REFERENCE** (with selective absorption)

**Primary verdict: REFERENCE.** Keep as a pointer, don't absorb wholesale into ai_best_practices.

Rationale:
- **Scope mismatch**: ai_best_practices is universal guidance; this skill is execution tooling (Python + drupal.org API calls + diff generation). Absorbing it would bloat scope and add a Python runtime dependency to a Markdown-guidance project.
- **Naming + packaging mismatch** (Q11): would require rename, frontmatter rewrite, and Composer wrapping to land cleanly.
- **Author is active and upstream-aware**: repo is maintained and already integrates with `drupalorg-cli` (mglaman). Better to link from ai_best_practices' "Contributing upstream" section than to fork.

**Selective absorb candidates** (pull content, attribute, don't take the Python):
1. `references/hack-patterns.md` — the anti-pattern table (cache disable, swallowed exceptions, access-bypass, hardcoded IDs, DI violations) is excellent universal Drupal guidance and fits a `reviewing-drupal-changes` or `avoiding-antipatterns` skill in ai_best_practices.
2. `references/patch-conventions.md` — patch filename/format rules are stable Drupal community conventions worth mirroring.
3. The **"search drupal.org before editing contrib"** heuristic — could become a short ai_best_practices skill (`checking-upstream-before-patching`) without the Python, just guidance and example `drupalorg-cli` invocations.
4. Exit-code discipline / gatekeeper concept — worth documenting as a pattern for other skills that run validation.

**Collaborate signal**: This repo + `drupalorg-cli` + companion `drupal-issue-queue` form a coherent toolkit. ai_best_practices should reference the trio together rather than re-implement any of them.

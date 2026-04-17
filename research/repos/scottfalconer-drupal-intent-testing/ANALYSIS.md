# scottfalconer-drupal-intent-testing — Phase 2 LITE Analysis

**Tier**: LITE (Tier 2)
**Source**: https://github.com/scottfalconer/drupal-intent-testing
**Last commit**: 2026-02-02 ("Rename Legal Tone label example") — current, active within 3 months
**Single maintainer**: scottfalconer
**License**: MIT (per `SKILL.md` frontmatter)

---

## Q1. Problem Solved (author's framing)

Drupal's standard PHPUnit/Kernel/FunctionalJavascript tests verify that code executes without error and that internal logic is correct, but they do not answer the question *"does this actually do what we meant?"* The repo provides an AI-agent-driven exploratory UI testing harness that drives a real Chromium browser (via the external `agent-browser` CLI) to perform the kind of semi-random, intent-focused verification a human QA tester would do — validating UX, "integration glue" between modules, and end-to-end intent for Drupal sites. It is explicitly framed as a *complement*, not a replacement, for PHPUnit. It is especially tuned to verify Drupal.org issue-queue intent (bugfixes / features) in a tight baseline-vs-modified loop, and to extract/assert on AI Agents Explorer output from Drupal AI modules. Source: `README.md:86-103`, `SKILL.md:20-24`.

## Q2. Primary Artefact Type

**Skill** (singular, Anthropic-style `SKILL.md` with YAML frontmatter) **+ Python CLI tooling** that the skill drives.

- One `SKILL.md` at repo root (`/SKILL.md`).
- Backing Python scripts: `scripts/compare_runs.py`, `scripts/explore.py`, `scripts/intent_test.py`, `scripts/judge_intent.py`, `scripts/collectors.py`, `scripts/intent/manifest.py`, `scripts/intent/validate_manifest.py`.
- Test-scenario DSL examples: `scripts/test_scenarios/*.txt`.
- Reference doc: `references/drupal_patterns.md`.

The skill is an operating-procedure document; the Python scripts implement the intent-manifest runner, compare-mode runner, fuzz/monkey explorer, and a judge that emits a verdict.

## Q3. Distribution Model

GitHub-clone / skill-drop. No `composer.json`, no `package.json`, no published package. `requirements.txt` exists at root for Python deps. The skill expects:
- `npm install -g agent-browser` (external runtime, not bundled).
- `pip install -r requirements.txt` for the Python runners.

There is no installer; users clone the repo and either load the skill directly into their agent (Claude Code / Codex) or invoke the Python scripts. INDEX confirms `composer.json: absent`, `package.json: absent`.

## Q4. Standards Conformance + Skill-Unit Convention

**Independently detected skill-unit convention: `SKILL.md` (single, uppercase, at repo root) with YAML frontmatter.**

- INDEX reports `SKILL.md count: 1` at `./SKILL.md`.
- Frontmatter (SKILL.md:1-18) uses: `name`, `description`, `license`, `compatibility`, `metadata.author`, `metadata.version`, `allowed-tools`.
- `name: drupal-intent-testing` — **noun-style, not gerund/verb-in-ing.** It is kebab-case, descriptive of the artefact rather than a verb phrase.
- No `skills/` directory, no `skill.yaml`, no numbered-dir layout, no frontmatter-md-per-subskill.

This is the Anthropic Claude-Code "Agent Skills" convention (single uppercase `SKILL.md`), not the drupal.org `ai_best_practices` `skills/` project-root convention.

## Q7. Coverage — Drupal Topics

One line per topic, with path:

- Login / authentication flow patterns -> `references/drupal_patterns.md:9-27`
- Admin URL-addressable navigation (`/admin/content`, `/node/add`, `/admin/config`, `/admin/modules`) -> `references/drupal_patterns.md:31-45`
- Form interaction (fill by label, dropdowns, Save / Save configuration / Save and publish) -> `references/drupal_patterns.md:49-76`
- AJAX waits and dialog handling (`wait --load networkidle`, `wait "role=dialog"`) -> `references/drupal_patterns.md:80-89`
- Drupal status/alert messages (`role=status`, `role=alert`, "has been saved" / "has been created") -> `references/drupal_patterns.md:93-113`
- AI Agents Explorer DOM extraction (scrape `<pre>` blocks, selected model) -> `references/drupal_patterns.md:117-129`, `SKILL.md:80-83`
- CKEditor / rich-text editing caveat -> `references/drupal_patterns.md:133-143`, `README.md:234`
- Backend probes via Drush watchdog (`drush ws --count=50 --format=json`) -> `references/drupal_patterns.md:147-155`
- DDEV snapshot/restore for baseline isolation (`ddev snapshot --name intent-baseline`) -> `SKILL.md:417-425`
- Canvas AI + Views + Webform integration-glue testing (primary use case) -> `README.md:124-129`
- Drupal.org issue-queue intent extraction (cooperates with `drupal-issue-queue` skill) -> `SKILL.md:199-206, 356-377`
- Intent manifest schema (issue / environment / adr / strategy / steps / assertions / guards) -> `SKILL.md:87-138`
- Scenario-script DSL (`open`, `checkpoint`, `assert-present`, `assert-no-js-errors`, `assert-no-drupal-alerts`, `assert-url`, `assert-count`, `extract eval`, `probe drush`) -> `SKILL.md:466-503`
- Test scenarios: basic content creation -> `scripts/test_scenarios/basic_content_creation.txt`
- Test scenarios: Canvas AI context label -> `scripts/test_scenarios/canvas_ai_context_label.txt`

Scope is **intentionally narrow**: UI-level verification of Drupal sites. It does **not** cover service DI, hook patterns, entity API, config management, coding standards, caching, security patterns, migrations, Twig, or any of the other canonical Drupal topic clusters.

## Q8. Quality Signals

- **Last commit**: 2026-02-02 (per INDEX). Active; within 3 months. **Not abandoned.**
- **Tests**: Python unit tests present — `tests/test_collectors.py`, `tests/test_compare_runs.py`, `tests/test_explore.py`, `tests/test_intent_manifest.py`, `tests/test_intent_test.py`, `tests/test_judge_intent.py`. 6 test modules testing the runners and judge, which is material coverage for a skill-support repo.
- **CI**: **None.** `.github/: absent` per INDEX. No `.gitlab-ci.yml` visible. Tests must be run manually.
- **Maintainer**: Single author — `scottfalconer` (sole author across git log). No corporate or community governance.
- **License**: MIT (in `SKILL.md` frontmatter; `LICENSE` file present at root).
- **Docs**: README is substantial (235 lines) with copy-pasteable prompts; SKILL.md is ~530 lines of runbook + DSL reference; `references/drupal_patterns.md` is a 188-line cookbook.
- **External hard dep**: `agent-browser` npm package — a third-party runtime the skill assumes but does not vendor, ship, or pin.

## Q11. Compatibility with ai_best_practices Decisions

| ai_best_practices decision | This repo | Compatible? |
|---|---|---|
| **Naming**: gerund-prefix, verb-in-ing | `drupal-intent-testing` — noun phrase; *"testing"* is verb-in-ing but **no gerund-prefix verb** ("driving", "verifying", "exploring" would match) | **Partial.** The final token *"testing"* is *-ing* form, but the name reads as a domain label rather than an action. Would need rename (e.g. `testing-drupal-intent`, `verifying-drupal-ui`) to conform strictly. |
| **Directory**: `skills/` at project root | No `skills/` dir; single `SKILL.md` at root | **No.** Uses Anthropic single-`SKILL.md` convention, not the `skills/<name>/SKILL.md` convention locked by ai_best_practices. |
| **Metadata**: minimal — `drupal-version` + `status` only | Frontmatter has `name`, `description`, `license`, `compatibility`, `metadata.author`, `metadata.version`, `allowed-tools`. Missing `drupal-version`, missing `status`. | **No.** Superset in some dimensions (author, version, allowed-tools) and subset in others (no drupal-version, no status). Would need frontmatter rewrite. |
| **Distribution**: Composer-installable | No `composer.json`. Python + npm deps only. | **No.** Would need a composer wrapper or relocation into a Drupal module/recipe to be Composer-installable. |
| **Scope**: universal Drupal guidance | Narrow: UI-level intent testing via one specific external tool (`agent-browser`). Hard-coded to AI Agents Explorer in places (SKILL.md:80-83, 185-186). | **No.** Not universal Drupal guidance — it is a specialized testing harness with opinionated tooling. |

**Net**: The skill's *content* is Drupal-relevant and high-quality, but the *packaging* aligns with Anthropic Claude-Code skill conventions, not with the ai_best_practices drupal.org LOCKED decisions. Absorbing would require repackaging.

## Q13. Verdict

**Reference (with selective absorption of patterns, not structure).** This is a focused, actively maintained, single-author skill that solves a narrow but real problem — agent-driven intent/UX verification for Drupal — and it is genuinely useful as an *exemplar* of a well-written SKILL.md runbook (decision tree, escalation protocol, done criteria, scenario DSL). The `references/drupal_patterns.md` cookbook of login / admin-URL / message-role / AJAX patterns is directly reusable content for an `ai_best_practices` skill on "verifying-drupal-ui" or similar. However, because it (a) uses the Anthropic single-`SKILL.md` convention instead of `skills/<name>/` project-root layout, (b) carries non-minimal frontmatter, (c) is not Composer-installable, and (d) is scoped to a specific external runtime (`agent-browser` + Drupal AI Agents Explorer), it cannot be absorbed wholesale into `ai_best_practices`. Recommend: cite as a reference implementation in any testing-oriented ai_best_practices skill, optionally lift the Drupal UI-pattern cookbook and the intent-manifest schema under a compatible license (MIT permits this with attribution). Do not collaborate as a dependency — the tooling-coupling to `agent-browser` makes it a poor fit for universal Drupal guidance.

# ANALYSIS — ivanboring-drupal-issue-hygiene-helper (Tier 2 LITE)

**Repo**: `/home/pointblank/research/repos/ivanboring-drupal-issue-hygiene-helper/`
**Tier**: 2 LITE
**Last commit**: 2026-04-07
**License**: none
**SKILL.md count**: 0

---

## Q1. Problem solved

A CLI tool that helps maintainers keep Drupal.org issue queues tidy. It fetches
issues from the Drupal.org API, scrapes comments via headless Chrome (because
the API returns incomplete comment content), then runs two layers of checks to
suggest status changes or comments:

- **Deterministic checks** (`src/Service/IssueChecker.php`): patch/MR uploaded
  but status still "Active", failing CI on "Needs Review", stale >5 days,
  unanswered questions >2 weeks.
- **AI checks** (`src/Service/AIService.php`, OpenAI `gpt-5.2`): bug reports
  lacking detail, missing test steps, unexplained status changes, RTBC with
  unresolved discussion, feature requests without use case.

Source: `README.md:77-129`, `CLAUDE.md` (project root).

## Q2. Primary artefact type

**Runnable PHP CLI application** (Symfony Console). Not a Drupal module, not a
skill, not a composer library meant to be embedded.

- Entry point: `issue.php`
- Commands: `src/Command/{Check,GiveSuggestions,Interactive,UpdateIssues}Command.php`
- Services: `src/Service/{AIService,DrupalApiService,IssueChecker}.php`
- State: `src/State/StateHandler.php` + `state/` JSON files

## Q3. Distribution model

**Standalone Composer-install project**, cloned and run in place — not
published on Packagist, not embedded elsewhere.

Evidence (`README.md:83-87`):
```
composer install
cp .env.example .env
php issue.php
```

Dependencies (`composer.json` via CLAUDE.md): `symfony/console ^7.0`,
`guzzlehttp/guzzle ^7.0`, `vlucas/phpdotenv ^5.6`, `chrome-php/chrome ^1.0`,
PHP `^8.2`. No `bin/` entry exposed for global install; users invoke
`php issue.php` from the clone directory.

## Q4. Standards conformance + skill-unit convention detection

- **No `skills/` directory**, no `SKILL.md` files, no `.claude/skills/`, no
  `.claude/` at all (INDEX.md:26-32, 41).
- **One `CLAUDE.md`** at repo root — but it functions as a **project spec /
  design doc for humans and a future Claude session**, not a skill bundle. It
  documents APIs, state layout, dependencies, and sample code — authored as
  "build notes," not as a reusable instruction unit.
- **README itself admits**: "This whole tool is vibe-coded" (`README.md:128`) —
  i.e., no explicit skill convention was intended.

**Independently detected skill-unit convention: NONE.** The repo follows no
Anthropic Skills pattern. It is a conventional Symfony Console application
whose AI usage is in-process OpenAI calls, not Claude skill authoring.

## Q7. Coverage — which Drupal topics (with file paths)

Narrow: only **Drupal.org issue-queue workflow**. Not general Drupal
development.

| Topic | File |
|---|---|
| Drupal.org REST API (`/api-d7/node.json`, `/api-d7/comment.json`) | `src/Service/DrupalApiService.php`, `CLAUDE.md` |
| Drupal.org issue-status numeric codes (1=active…18=closed outdated) | `CLAUDE.md` (Field Issue Status section) |
| Headless Chrome scraping of drupal.org issue pages (bot-evasion flags) | `src/Service/DrupalApiService.php`, `CLAUDE.md` (scraping snippet) |
| Issue-queue hygiene heuristics (patch-but-active, failing-CI, stale, unanswered) | `src/Service/IssueChecker.php` |
| AI semantic checks for RTBC / bug-detail / test-steps | `src/Service/AIService.php` |
| Project-ID config (`DRUPAL_PROJECT_IDS` JSON env var) | `.env.example`, `CLAUDE.md` |

Zero coverage of: Drupal modules, hooks, services/DI, entity API, Twig,
config management, migrations, testing — nothing module-builder-related.

## Q8. Quality signals

**Negative / cautionary:**
- `README.md:128` — self-labeled "vibe-coded."
- `License: none` (INDEX.md:7) — not legally redistributable.
- Model identifier `gpt-5.2` in CLAUDE.md but sample code invokes
  `'gpt-4o-mini'` — inconsistent (`CLAUDE.md` AI section).
- Uses `'headless' => false` in BrowserFactory options yet also passes
  `--headless=new` via customFlags — contradictory / copy-paste residue.
- Last commit subject: "Fix updater" — suggests active tinkering, not a
  stabilised release.

**Neutral / positive:**
- Clear separation of Command / Service / State layers.
- Deterministic checks precede AI checks (cost-aware).
- API pagination and 429/503 retry explicitly handled (`CLAUDE.md` API
  Rate Limiting section).
- State files keyed by `{changed}_{issueId}.json` — enables skipping
  unchanged issues.
- `.env.example` committed, `.env` gitignored.

## Q11. Compatibility with ai_best_practices LOCKED decisions

| Decision | Repo status | Compatible? |
|---|---|---|
| Skill naming: gerund-prefix, verb-in-ing | No skills exist | **N/A** |
| Directory: `skills/` at project root | Absent | **Non-conformant** (nothing to conform) |
| Metadata: `drupal-version` + `status` only | No metadata, no frontmatter | **N/A** |
| Distribution: Composer-installable | Has `composer.json` but as an app, not a library/skill bundle | **Partially** — Composer is used, but for app dependencies, not for shipping skills |
| Scope: universal Drupal guidance | Scope is Drupal.org issue-queue hygiene only — a single, narrow operational workflow | **Incompatible scope** |

**Net**: the repo supplies **zero reusable skill assets** that slot into the
ai_best_practices framework. At best it is a **reference for one workflow
domain** (issue-queue triage) that a future skill could wrap.

## Q13. Verdict

**SKIP for skill extraction.** Keep as a **reference** for one narrow task
only: if/when a "triaging-drupalorg-issues" skill is ever scoped, the
check heuristics in `src/Service/IssueChecker.php` and the status-code
table in `CLAUDE.md` are worth mining. The code itself is vibe-coded,
unlicensed, and out of scope for universal Drupal guidance. No skill units,
no structure to port, no quality baseline to inherit.

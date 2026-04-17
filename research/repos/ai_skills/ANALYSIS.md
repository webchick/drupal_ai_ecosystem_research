# ai_skills — Tier 2 LITE + HISTORICAL Analysis

**Repo**: `/home/pointblank/research/repos/ai_skills/`
**Source**: https://git.drupalcode.org/project/ai_skills.git
**Default branch**: `1.0.x`
**Last commit**: 2026-03-24 ("Add license") — single commit only
**Tag**: `1.0.0-alpha3` (alpha, never GA)
**License**: GPL-2.0-or-later (composer.json)
**drupal.org status**: Flagged UNSUPPORTED — README redirects to `ai_best_practices`
**Ecosystem role**: Hard Composer dependency of `drupal/surge` (canonical skill content source)

---

## Q1. Problem Solved

Community-curated library of Agent Skills for Drupal, conforming to the **Agentskills.io** specification. Distributed via Composer or `npx skills add`. Positioned as the single upstream registry of Drupal agent skills, validated in GitLab CI via `ronaldtebrake/agent-skills-validator-php`.

**Status caveat**: Though drupal.org marks the project UNSUPPORTED (redirecting users to `ai_best_practices`), the repo is alive as a content-host — `drupal/surge` requires it via Composer, so its 3 SKILL.md files are the de facto skill payload shipped by surge today.

## Q2. Primary Artefact Type

**SKILL.md documents** (x3), each in `skills/<skill-name>/` with progressive disclosure via `references/`, `scripts/`, `lib/`, and `assets/`. Python helper scripts back two of the three skills. No Drupal PHP code, no modules — pure skill bundle repository.

## Q3. Distribution Model

Triple distribution:

1. **`npx skills add <gitlab-url>`** (Agentskills.io CLI)
2. **Composer**: `drupal/ai_skills` (library type, PHP >= 8.0, no Drupal runtime dep)
3. **Manual copy-paste** into the agent's skills dir

Surge uses path (2). Repo root has `composer.json`; no `package.json`, no `skills.yaml` manifest, no plugin/theme descriptors.

## Q4. Standards Conformance + Skill-Unit Convention (Independently Detected)

**Declared**: Agentskills.io spec, validated by `ronaldtebrake/agent-skills-validator-php`.

**Independently detected convention** (inspected YAML frontmatter of the 3 SKILL.md files):

| Field          | drupal-coding-standards | drupal-contribute-fix | drupal-issue-queue |
|----------------|-------------------------|-----------------------|--------------------|
| `name`         | kebab-case, noun-prefix | kebab-case, noun-prefix | kebab-case, noun-prefix |
| `description`  | present                 | present (multi-line `>`) | present |
| `license`      | absent                  | `GPL-2.0-or-later`    | absent |
| `metadata.author` | `ronaldtebrake`      | `Drupal Community`    | absent |
| `metadata.version`| `"0.1"`              | `"1.4.0"`             | absent |

**Naming convention**: `drupal-<noun/topic>` (e.g. `drupal-coding-standards`). NOT gerund-prefix, NOT verb-in-ing. This directly conflicts with ai_best_practices' LOCKED `<verb>ing-<object>` rule.

**Structure**: `skills/<kebab-name>/SKILL.md` at project root — matches ai_best_practices' `skills/` at root decision. Progressive disclosure via sibling `references/`, `scripts/`, `lib/`, `examples/`, `assets/`.

**Metadata richness**: Inconsistent across the three skills — none match ai_best_practices' minimal `drupal-version` + `status` convention. All three would need frontmatter rewrites.

## Q7. Coverage — Three SKILL.md Files by Topic + Quality

### 1. `skills/drupal-coding-standards/SKILL.md` (author: ronaldtebrake, v0.1)

**Topic**: Drupal's official coding standards — dynamic context discovery routes file extensions to specific standards files.

**Structure**:
- 37-line SKILL.md (thin router) + `standards-index.md` (routing table)
- `assets/standards/` with **10 sub-directories**: `php/` (10 files: coding, documentation, exceptions, namespaces, naming-services, psr4, e_all, placeholders-delimiters, documentation-examples, index), `javascript/` (coding, best-practice, documentation, eslint, jquery), `css/` (coding, architecture, format, file-organization, csscomb, review), `twig/` (coding.md only), `yaml/`, `sql/`, `markup/`, `composer/`, `accessibility/`, `spelling/`
- Covers: PHP, JS, CSS, Twig, YAML, SQL, HTML markup, composer.json, a11y, spelling

**Quality**: High-volume content — mirror of canonical drupal.org coding-standards pages. Dynamic-discovery pattern (`standards-index.md` as routing table) is a genuinely clever progressive-disclosure design. Content is authoritative but verbose; marked v0.1 (immature). Note: this skill has been **absorbed verbatim into `drupal-workflow` plugin already** (see system skills list: `drupal-workflow:drupal-coding-standards`).

### 2. `skills/drupal-contribute-fix/SKILL.md` (author: Drupal Community, v1.4.0)

**Topic**: Gatekeeper workflow — search drupal.org BEFORE patching contrib/core, then generate properly-named patches + RTBC comments + reports. Forces upstream-first contribution habit.

**Structure**:
- 390-line SKILL.md (extensive behavioural spec, trigger table, 6-outcome exit-code table)
- `scripts/contribute_fix.py` (40KB CLI — preflight, package, test, reroll subcommands)
- `lib/` (8 Python modules: `baseline_repo.py`, `drupalorg_api.py`, `issue_matcher.py`, `patch_packager.py`, `report_writer.py`, `security_detector.py`, `validator.py`, `__init__.py` — ~111KB total)
- `references/` (hack-patterns.md, issue-status-codes.md, patch-conventions.md)
- `examples/sample-report.md`, `requirements.txt`, own LICENSE

**Quality**: Most mature and opinionated of the three (v1.4.0). Excellent "security-issue STOP (exit 50)" pattern. Heavy Python tooling — this is NOT just documentation, it's a full sub-application. Authored by Scott Falconer (the maintainer-per-README and own-repo owner `scottfalconer/drupal-contribute-fix`). Frontmatter description is exemplary — explicit trigger table + negative examples.

### 3. `skills/drupal-issue-queue/SKILL.md` (no metadata author/version)

**Topic**: Read-only drupal.org issue-queue search + issue summarisation via api-d7 endpoints. Triage tool; complementary to `drupal-contribute-fix`.

**Structure**:
- 60-line SKILL.md (thin CLI wrapper doc)
- `scripts/dorg.py` (35KB single-file CLI: `issue`, `search` subcommands with status/priority/version/tag filters, rate limits, cache TTL)
- `references/` (drupalorg-api-d7.md, issue-field-mappings.md, output-schema.md)

**Quality**: Focused, single-responsibility. Frontmatter lacks `metadata` block entirely — arguably cleanest of the three but non-conforming to the sibling convention. Same author (Scott Falconer). Guardrail section ("API only, single-threaded, cached, rate-limited, read-only") is textbook well-behaved-bot hygiene.

## Q8. Quality Signals

**Timeline**:
- Repo initialised and populated end-of-March 2026
- **Exactly one commit**: `11727d4 2026-03-24 ronaldtebrake Add license`
- Single tag: `1.0.0-alpha3` — never hit beta, never hit GA
- Last activity: 2026-03-24 (~3 weeks before today 2026-04-17)
- drupal.org flag: **UNSUPPORTED** + redirect to `ai_best_practices`

**Release state**: Alpha. No 1.0.0 release exists.

**As surge's Composer dependency**: Surge has `require: drupal/ai_skills:*` (or similar). Because ai_skills is marked unsupported AND semi-frozen at alpha3, surge is pinned to content that's not being iterated. The three SKILL.md bundles are effectively **orphaned canonical content** — live in the Composer graph but dead on the project page. This creates an ecosystem trap: the community is directed to `ai_best_practices` for new work, but surge continues shipping ai_skills content on every `composer update`.

**Drupal packaging indicators**: composer.json only requires `php >= 8.0` + dev-only validator. No Drupal core version constraint. Not a module. Pure content library.

**CI**: README mentions "automatically validated on every merge request" via GitLab CI, but no `.github/`, `.gitlab-ci.yml` was not present in the INDEX file-tree listing (only 1 `.yml` in the whole repo — likely that CI file, unlisted by depth 3 but at repo root or absent in this clone).

**External maintenance signal**: README's skill table points each skill at its maintainer's **own GitHub mirror** (`ronaldtebrake/drupal-coding-standards-skill`, `scottfalconer/drupal-issue-queue`, `scottfalconer/drupal-contribute-fix`) — the git.drupalcode.org copy is a mirror, not the development home. Real maintenance, if any, continues in the author repos; the drupal.org project is just the Composer hosting shell.

## Q11. Compatibility with ai_best_practices Decisions

| ai_best_practices LOCKED decision | ai_skills state | Compatible? |
|-----------------------------------|-----------------|-------------|
| Skill naming: gerund-prefix, verb-in-ing | `drupal-<noun>` (`drupal-coding-standards`) | **NO** — rename all three (e.g. `reviewing-coding-standards`, `contributing-fixes`, `searching-issue-queue`) |
| Directory: `skills/` at project root | `skills/<name>/SKILL.md` at root | **YES** |
| Metadata: minimal (`drupal-version` + `status` only) | Rich/inconsistent (`author`, `version`, `license` per skill) | **NO** — strip frontmatter; add `drupal-version`/`status` |
| Distribution: Composer-installable | Composer-installable as `drupal/ai_skills` (library) | **YES** |
| Scope: universal Drupal guidance | Universal Drupal — all three are ecosystem-general, not module-specific | **YES** |

**Net**: Content is scope-compatible and format-compatible at the directory level. Only frontmatter/naming needs normalization — content reuse is feasible.

## Q13. Verdict — Per-Skill Absorption Judgement

Overall: **ABSORB SELECTIVELY**, do not ignore wholesale. Per-skill:

### `drupal-coding-standards` — **ABSORB (with caveats)**
- **Absorb**: The `standards-index.md` routing-table pattern + the 10-category `assets/standards/` content tree is genuinely valuable. It is already mirrored in the `drupal-workflow` plugin, so direct pull-in likely duplicates existing work — **confirm whether the plugin version is a fork of this repo or an independent pull from canonical drupal.org**.
- **Skip**: the `metadata: author/version "0.1"` frontmatter; rename to `reviewing-drupal-coding-standards` under ai_best_practices convention.
- **Action**: Cross-check against `drupal-workflow:drupal-coding-standards` content parity; if not a superset, absorb the `assets/standards/` tree with frontmatter rewrite.

### `drupal-contribute-fix` — **ABSORB, HIGHEST VALUE**
- This is the crown-jewel skill of the repo. The gatekeeper pattern (upstream-search-before-patch, exit-code 10/20/30/40/50 state machine, security-issue auto-stop) is unique and mature (v1.4.0).
- The 111KB of Python tooling (`lib/` + `scripts/`) is usable as-is — pure helpers, no Drupal runtime deps.
- **Action**: Pull the entire skill dir into ai_best_practices as `contributing-drupal-fixes/` (or similar gerund name). Keep `scripts/`, `lib/`, `references/`, `examples/` as-is. Strip the metadata block to `drupal-version` + `status`. Preserve `scottfalconer` author attribution in body text.

### `drupal-issue-queue` — **ABSORB (standalone utility)**
- Clean, focused, read-only drupal.org API wrapper. 35KB single-file CLI (`dorg.py`) with proper rate-limit/cache hygiene.
- Complements `drupal-contribute-fix` (it's the preflight search substrate).
- **Action**: Absorb as `searching-drupal-issue-queue/`. Add minimal frontmatter. Consider whether to factor `drupalorg-api-d7.md` reference into a shared resources pool since `drupal-contribute-fix` also talks to the same API.

### Cross-cutting note on surge's dependency implications

Because surge hard-depends on `drupal/ai_skills` via Composer, and ai_skills is alpha + unsupported, if **ai_best_practices** intends to replace ai_skills as the canonical source:

1. Either ai_best_practices must also publish as `drupal/ai_skills` (namespace squat) — unlikely and politically awkward, OR
2. Surge must be informed / refactored to depend on ai_best_practices instead, OR
3. ai_skills becomes a thin Composer meta-package that pulls from ai_best_practices (dep-reversal bridge).

The three skills here are the ONLY content surge ships today. Absorbing them into ai_best_practices is the prerequisite to any migration path — without absorption, ai_best_practices cannot claim feature-parity with surge's current payload.

---

**File paths referenced**:
- `/home/pointblank/research/repos/ai_skills/composer.json`
- `/home/pointblank/research/repos/ai_skills/README.md`
- `/home/pointblank/research/repos/ai_skills/skills/drupal-coding-standards/SKILL.md`
- `/home/pointblank/research/repos/ai_skills/skills/drupal-coding-standards/standards-index.md`
- `/home/pointblank/research/repos/ai_skills/skills/drupal-coding-standards/assets/standards/` (10 subcategories)
- `/home/pointblank/research/repos/ai_skills/skills/drupal-contribute-fix/SKILL.md` (390 lines)
- `/home/pointblank/research/repos/ai_skills/skills/drupal-contribute-fix/scripts/contribute_fix.py` (40KB)
- `/home/pointblank/research/repos/ai_skills/skills/drupal-contribute-fix/lib/` (8 modules, ~111KB)
- `/home/pointblank/research/repos/ai_skills/skills/drupal-issue-queue/SKILL.md` (60 lines)
- `/home/pointblank/research/repos/ai_skills/skills/drupal-issue-queue/scripts/dorg.py` (35KB)

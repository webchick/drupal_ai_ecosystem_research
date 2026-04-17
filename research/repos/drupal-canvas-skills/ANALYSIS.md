# drupal-canvas-skills — Tier 2 LITE Analysis

**Repo**: `/home/pointblank/research/repos/drupal-canvas-skills/`
**Source**: https://github.com/drupal-canvas/skills
**Last commit**: 2026-04-16
**License**: MIT
**Tier**: 2 LITE (Q1-4, 7, 8, 11, 13)

---

## Q1. Problem solved

Provides a focused skill library for AI coding agents that develop
**Drupal Canvas Code Components** — the React-based component system used
by Drupal Canvas (the Experience Builder / Canvas visual site authoring
tool). The skills encode the canonical component contract
(`index.jsx` + `component.yml`), page JSON spec conventions, Workbench
preview workflow, Canvas CLI push/pull flow, data fetching with
SWR + JSON:API, and Tailwind 4 styling conventions. Target audience is a
coding agent (Claude, Cursor, etc.) working inside a Canvas-enabled repo
authoring components and page specs.

## Q2. Primary artefact type

**SKILL.md files — 9 of them**, one per skill directory, each a
self-contained Markdown procedural skill with YAML frontmatter
(`name`, `description`). A subset (`canvas-component-composability`,
`canvas-component-definition`, `canvas-workbench`) also carry a
`references/` subdirectory for deferred-load deep content (the SKILL.md
explicitly tells the agent which reference file to open on demand).

No agents, no hooks, no slash commands, no evals, no MCP, no composer
plugin — just skills.

## Q3. Distribution model

**npx / npm-based installer**, explicitly NOT Composer. README prescribes:

```
npx skills add drupal-canvas/skills
```

`package.json` is `"private": true` and has no `bin`, `files`, or
`publishConfig` — it is not itself published. The `skills add` command
refers to the **external `agentskills.io` CLI**, which fetches skills
from the repo and copies them into the consuming project's
`.claude/skills/` (or equivalent). Repo tooling (husky, lint-staged,
prettier) is for contributors only; consumers don't install those.

## Q4. Standards conformance + independent skill-unit detection

**Declared standard**: README explicitly claims conformance with the
**Agent Skills format** (https://agentskills.io/).

**Independently detected skill-unit convention** (from reading the 9
SKILL.md files without relying on the declaration):

- One skill = one directory under `skills/`, directory name equals
  skill `name` (e.g., `skills/canvas-component-push/`).
- Each directory contains exactly one `SKILL.md`.
- Frontmatter is **minimal and consistent**: only `name` and
  `description`. No `version`, `author`, `tags`, `allowed-tools`,
  `model`, `drupal-version`, `status` keys — nothing else.
- `description` is multi-line, written for model-as-router: opens with
  the verb/outcome, then an enumerated `Use when (1) ... (2) ...` list
  of triggering conditions. This matches Anthropic's "write descriptions
  that help the router decide" guidance.
- Naming is **noun-phrase with `canvas-` namespace prefix**, NOT gerund
  (`canvas-component-definition`, not `defining-canvas-components`).
- Optional `references/` subdirectory holds deep-dive Markdown loaded
  lazily by the agent on demand; SKILL.md explicitly says "Load
  references only as needed".
- Body style: imperative prose + YAML/code fences; includes explicit
  MUST/MUST-NOT contract sections and activation gates for destructive
  actions (e.g., `canvas-component-push` has an "Activation guard" that
  refuses to run unless user explicitly asks).

Convention is clean, disciplined, and internally consistent.

## Q7. Coverage — Drupal topics with file paths

**Scope flag: PROJECT-SPECIFIC (Drupal Canvas only).** Every one of the
9 skills is about authoring React Code Components for the Drupal Canvas
visual builder. None address generic Drupal topics (hooks, services,
entity API, config management, migrations, theming, Drush, security,
caching, access control, etc.).

| Topic (Canvas-only) | Path |
|---|---|
| React component authoring contract (index.jsx + component.yml) | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-component-definition/SKILL.md` |
| Component composition, props-vs-slots, decomposition | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-component-composability/SKILL.md` (+ `references/repeatable-content.md`) |
| `component.yml` schema — props, slots, enums, CVA mapping | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-component-metadata/SKILL.md` |
| Canvas CLI push/publish workflow, auth env vars, retry on dependency failures | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-component-push/SKILL.md` |
| `FormattedText` and `Image` utility components from `drupal-canvas` package | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-component-utils/SKILL.md` |
| Data fetching with SWR + JSON:API (JsonApiClient, DrupalJsonApiParams) | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-data-fetching/SKILL.md` |
| Canvas page JSON spec authoring (pagesDir, elements tree) | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-page-definition/SKILL.md` |
| Tailwind 4 tokens, CVA, `cn()` utility | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-styling-conventions/SKILL.md` |
| Local Workbench dev server, mock authoring, verification workflow | `/home/pointblank/research/repos/drupal-canvas-skills/skills/canvas-workbench/SKILL.md` (+ `references/`) |

**Gap w.r.t. universal Drupal**: Zero coverage of PHP modules, OOP
hooks, plugins, events, form API, entity API, views, migrate, config
management, Drush, testing, security patterns, performance / caching
layers, multisite, recipes, or site building. This repo is the React /
frontend half of a very specific Drupal initiative and deliberately
ignores everything else.

## Q8. Quality signals

Positive:
- **Prose quality is high** — tight, imperative, MUST/SHOULD lists,
  named code paths, realistic YAML/JSX examples.
- **Descriptions are router-friendly** — explicit "Use when" enumerated
  triggers in every skill.
- **Activation gates** on destructive skills (push skill refuses to run
  without explicit user intent; workbench skill checks installation
  before proceeding).
- **Lazy-load references** pattern — SKILL.md body stays small; deep
  content deferred into `references/` files loaded on demand. This is
  Anthropic's recommended pattern for progressive disclosure.
- **Frontmatter discipline** — only two keys, no metadata bloat.
- **Consistent tooling** — prettier + husky pre-commit ensures
  formatted, reviewable Markdown.
- **Clear scoping** — each skill has one job; no 2000-line mega-skills.
- **Recent** — last commit 2026-04-16 (active).

Negative / missing:
- No evals, tests, or automated validation of skill behaviour.
- No versioning inside frontmatter (no `version:` or `drupal-version:`
  key) — consumers can only track via git SHA.
- No CLAUDE.md or AGENTS.md at repo root — contributors get no
  meta-guidance on how to write a new skill.
- No CI (`.github/` absent) — quality is enforced only locally via
  husky.
- Distribution depends on external `agentskills.io` CLI, which is
  itself a young/unvetted dependency.

## Q11. Compatibility with ai_best_practices decisions

| ai_best_practices LOCKED decision | drupal-canvas-skills | Verdict |
|---|---|---|
| **Gerund-prefix, verb-in-ing naming** | Uses noun-phrase with `canvas-` namespace (e.g., `canvas-component-push`, NOT `pushing-canvas-components`) | **Incompatible — would require renaming all 9 skills** |
| **Directory: `skills/` at project root** | Exactly `skills/` at repo root | **Compatible — matches** |
| **Minimal metadata: `drupal-version` + `status` only** | Only `name` + `description`; no `drupal-version`, no `status` | **Partially compatible — also minimal, but different keys. Would need to add `drupal-version` and `status`.** |
| **Distribution: Composer-installable** | npm / `npx skills add` via `agentskills.io`; no `composer.json` | **Incompatible — would need a `composer.json` with a skill-installer Composer plugin.** |
| **Scope: universal Drupal guidance, not project-specific** | Entirely scoped to Drupal Canvas Code Components (React-only, Canvas-only) | **Incompatible — this is the exact opposite of universal. It's a narrow, project-specific skill pack.** |

Two out of five LOCKED decisions conflict hard (naming, distribution,
scope). One is close-but-not-quite (frontmatter keys). Only one
(`skills/` root directory) matches outright.

## Q13. Verdict

**Excellent reference for skill craftsmanship, wrong model for
ai_best_practices as a whole.** Borrow the shape
(one-skill-per-dir, `references/` for lazy-load, enumerated "Use when"
triggers in description, activation gates on destructive skills, minimal
frontmatter, prettier-enforced prose) — but do NOT use this repo as a
template for naming, distribution, or scope. The project-specific Canvas
focus is structurally incompatible with a universal Drupal skill pack:
you would need to rename every skill (gerund form), add Composer
packaging, and replace all 9 skills' *content* (none of the material
here applies outside Canvas). Treat it as a quality bar, not a seed.

**Recommendation**: SALVAGE PATTERNS, DISCARD CONTENT. Specifically:
copy the SKILL.md frontmatter discipline, the "Use when (1)..." trigger
enumeration style, the activation-gate pattern for push/destructive
skills, and the `references/` lazy-load convention. Rewrite every skill
from scratch against the universal Drupal scope with Composer
distribution and gerund naming.

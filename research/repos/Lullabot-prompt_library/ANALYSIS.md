# Lullabot/prompt_library — Tier 2 LITE Analysis

**Tier**: 2 LITE
**Repo**: Lullabot/prompt_library
**Last commit**: 2026-04-15
**License**: none on disk (README claims ISC — no LICENSE file present)
**Source**: https://github.com/Lullabot/prompt_library

---

## Q1. Problem solved

A **discipline-broad prompt catalogue** for AI assistants (Claude, Cursor, GPT) used across Lullabot's teams — Development, Project Management, Sales & Marketing, Content Strategy, Design, Quality Assurance. Built and deployed as an 11ty (Eleventy) static site on GitHub Pages with search, categorization, and a raw-markdown API for agent consumption. The aim: centralise and version reusable prompts, rules, agents, skills, project-configs, and workflow-states, with GitHub-issue submission workflow and programmatic Slack contribution via `repository_dispatch`.

## Q2. Primary artefact type

Mixed. Inventory (dev discipline):

| Content type | Qty | Notes |
|---|---|---|
| prompts | 3 | five-backtick-fenced text blocks |
| rules | 3 | guideline docs (prose + Cursor `.mdc`) |
| agents | 6 | longform personas with embedded Claude Code agent frontmatter |
| skills | 6 files + 3 resource dirs | Claude-skill style inside fenced blocks |
| project-configs | 3 | setup templates |
| resources | 2 | link dumps |
| workflow-states | 0 | declared in docs, empty placeholders |

6 disciplines × 4–7 content types: a **multi-artefact library**, not a pure prompt library despite the repo name. Skills are a minority; most items are prompts, rules, or agents.

## Q3. Distribution model

- **Primary**: rendered as a **public static site** on GitHub Pages via 11ty build. Per-page "Use with your agent" collapsible exposes raw-markdown URLs (`/<discipline>/<type>/<slug>/SKILL.md` etc.) for copy-paste into agent contexts.
- **Secondary**: raw GitHub clone.
- **NOT a package**: no `composer.json`, no npm-registry `package.json` name, no `skills.yaml`, no release artefacts. `package.json` only serves 11ty tooling.
- Contribution via GitHub issue templates and Slack → `repository_dispatch` webhook.
- Skill companion-resource dirs are copied via 11ty passthrough and offered as a per-skill "Download All Resources (.zip)" button.

**No Composer package, no npm distribution. Consumers fetch markdown URLs.**

## Q4. Standards conformance + independently detected skill-unit convention

**INDEX.md reports 0 `SKILL.md`** — confirmed on disk. But CLAUDE.md explains that `SKILL.md` / `PROMPT.md` / `AGENT.md` are **generated at build time** at URLs like `/development/skills/cloudflare-tunnel/SKILL.md`, stripping the 11ty frontmatter. So "SKILL.md" is a runtime output, not a source file.

**Source-of-truth skill-unit convention** (detected by reading files):

```
development/skills/cloudflare-tunnel.md       # skill source (11ty-frontmatter markdown)
development/skills/cloudflare-tunnel/         # optional companion directory (same basename)
  scripts/
  references/
```

Each skill `.md` uses a **double-layered frontmatter** pattern:

1. **Outer** 11ty Nunjucks frontmatter (required for site build):
   ```yaml
   ---
   title: "..."
   description: "..."
   date: "YYYY-MM-DD"
   layout: "markdown.njk"
   discipline: "development"
   contentType: "skills"
   tags: [...]
   # optional: version, lastUpdated, changelog
   ---
   ```

2. **Inner** five-backtick-fenced block containing the agent-consumable payload. For skills this carries Claude-Code-style inner frontmatter:
   ```
   `````
   ---
   name: cloudflare-tunnel
   description: "This skill should be used when..."
   ---
   # Cloudflare Tunnel
   ... body ...
   `````
   ```

Agents use the same double-wrap with inner `name`/`description`/`model: inherit` (Claude Code subagent format). Prompts and configs use bare five-backtick fences with no inner frontmatter.

**Naming**: kebab-case slugs. **No gerund-prefix convention.** Skills mix gerunds (`resolve-composer-conflicts`) with tool-nouns (`cloudflare-tunnel`, `github-wiki`, `htmx-expert`, `tugboat-cli`, `gws-cli`).

**Standards conformance**:
- Anthropic/Claude skill spec: **partial** — inner fenced block matches Claude Code format but is wrapped inside 11ty frontmatter, so a file cannot be dropped into `.claude/skills/` as-is; requires extraction.
- Drupal coding standards: referenced (PHPCS, DrupalPractice, PSR-12) but as prompt content, not enforced.
- No `skills.yaml`, no `composer.json`, no Composer-installer handling.

## Q7. Coverage — Drupal-relevant topics

**Drupal-relevant items** (~13 artefacts out of ~40+):

| File | Type | Topic |
|---|---|---|
| `development/rules/drupal.md` | rule | Cursor-style `.mdc` core/theme/testing rules — strict_types, final, DI, OOP hooks, Twig/BEM, PHPUnit base classes |
| `development/rules/drupal-standards.md` | rule | Prose bullet list: coding standards, module structure, security, performance, Guzzle JSON helpers |
| `development/rules/code-quality.md` | rule | Generic quality (mentions Drupal tangentially) |
| `development/prompts/drupal-code-review.md` | prompt | Review checklist |
| `development/prompts/adr.md`, `ai-code-review.md` | prompt | Generic but Drupal-usable |
| `development/agents/drupal-backend-specialist.md` | agent | Modules, Schema API, JSON-RPC, typed_entity, `#config_target`, guard clauses |
| `development/agents/drupal-frontend-engineer.md` | agent | Twig / theming persona |
| `development/agents/module-readme-maintainer.md` | agent | README upkeep for Drupal modules |
| `development/agents/testing-qa-engineer.md` | agent | PHPUnit / QA persona |
| `development/project-configs/drupal-setup.md` | config | composer.json + layout scaffold for D11 |
| `development/resources/drupal-and-ddev-links.md` | resource | Link curation |
| `development/skills/resolve-composer-conflicts.md` | skill | composer.lock merge resolution (DDEV-aware) |
| `development/skills/tugboat-cli.md` + `tugboat-cli/` | skill | Tugboat preview environments (Lullabot product) |

**Out-of-scope for this research** (flagged):

- Entire disciplines: `content-strategy/`, `design/`, `sales-marketing/`, `project-management/`, `quality-assurance/` (SEO, voice-and-tone, nano-banana, pencil-designer, meeting-facilitator, RFP→NATM, QA checklists).
- Generic dev tooling skills: `htmx-expert.md`, `gws-cli.md`, `github-wiki.md`, `cloudflare-tunnel.md`.
- `development/project-configs/11ty-setup.md`.
- `memory-bank/`, top-level empty `agents/`, `.cursor/rules/*`.
- All `.njk`, `.eleventy.js`, CSS/JS — 11ty site-build machinery.

**Drupal content is roughly one-third of the library.**

## Q8. Quality signals

**Strong**:
- Active maintenance (last commit 2026-04-15; PR #133 merged).
- Clear `CLAUDE.md` documents content-submission schema, versioning semantics (semver + changelog frontmatter), raw-markdown endpoint contract.
- Tugboat preview environments per PR.
- Per-content semver fields (`version`, `lastUpdated`, `changelog`).
- Multiple GitHub issue templates enforcing a disciplined taxonomy.
- Slack `repository_dispatch` contribution pipeline.
- Auto-generated `llms.txt` compressed snapshot.

**Weak / uneven**:
- **No LICENSE file** despite README claiming ISC — legally ambiguous for verbatim reuse.
- `workflow-states` directories are empty placeholders.
- Drupal content uneven: `drupal.md` (Cursor rule) is tight/opinionated; `drupal-standards.md` is a thin bullet list; `drupal-code-review.md` is a bare checklist with no few-shot examples; `drupal-backend-specialist.md` is the strongest, opinionated, and patterns-aware (typed_entity, `#config_target`, guard clauses, JSON-RPC preference).
- **No evals or tests** — `evals/` absent. Quality is curatorial, not measured.
- **No Drupal-version gating** — most Drupal rules dated 2024-03 / 2024-04 with no automated staleness detection despite `lastUpdated` field being available.
- Skill naming inconsistent (gerund vs. tool-noun).
- Double-frontmatter layering blocks direct Claude-skill reuse.

## Q11. Compatibility with ai_best_practices LOCKED decisions

| Decision | Compatibility | Notes |
|---|---|---|
| Skill naming: **gerund-prefix, verb-in-ing** | **Incompatible** | Lullabot mixes gerunds with tool-nouns. Their one clearly gerund-prefix skill is `resolve-composer-conflicts`. |
| Directory: **`skills/` at project root** | **Incompatible** | Skills live at `<discipline>/skills/*.md`; top-level `skills/` is only an 11ty listing page. |
| Metadata: **minimal — `drupal-version` + `status` only** | **Incompatible** | Lullabot requires a large 11ty frontmatter (title, description, date, layout, discipline, contentType, tags, optional version/lastUpdated/changelog) plus inner Claude-style frontmatter. No `drupal-version` or `status` fields. |
| Distribution: **Composer-installable** | **Incompatible** | No `composer.json`. Distribution is GitHub Pages + raw-markdown URLs + optional resource zip. A Drupal project cannot `composer require` this library. |
| Scope: **universal Drupal guidance** | **Partial** | Drupal is a first-class sub-topic but sits inside a much larger multi-discipline library; cannot be reused wholesale for Drupal-only consumers without curation. |

**Fundamental paradigm mismatch.** Lullabot's library is a **publishing platform** (11ty → GitHub Pages → raw-markdown URL API) optimised for *humans browsing* and *agents copy-pasting*. ai_best_practices targets a **Composer-installed, minimal-metadata, file-on-disk skill library** optimised for *agents auto-loading `skills/` inside a Drupal project*. Convertible by hand, not interchangeable.

## Q13. Verdict

**Limited direct reuse; valuable as a content quarry.**

Lullabot/prompt_library is a well-maintained, discipline-broad **prompt publishing platform** — not a skill library. Its paradigm (11ty static site with double-wrapped frontmatter and raw-markdown URL API) is fundamentally incompatible with ai_best_practices' Composer-installed `skills/` directory model.

**Drupal content worth mining for substance**:
- `development/agents/drupal-backend-specialist.md` — strongest opinionated Drupal guidance in the repo (typed_entity, `#config_target`, JSON-RPC-over-controllers, guard clauses, constructor property promotion). Translate body into ai_best_practices skills.
- `development/rules/drupal.md` — Cursor-flavoured core/theme/testing split is a useful outline for partitioning skills.
- `development/skills/resolve-composer-conflicts.md` — the single drop-in Drupal-adjacent skill (matches gerund naming, usable after stripping outer 11ty frontmatter).

**Action**: do NOT adopt the format. DO mine the Drupal-backend-specialist agent, the `drupal.md` Cursor rules, and the `resolve-composer-conflicts` skill body when authoring ai_best_practices' first-party skills. Flag the missing LICENSE as a legal risk for copy-paste reuse — prefer paraphrasing to verbatim lifts.

**Tier**: reference / content source. Not a structural template.

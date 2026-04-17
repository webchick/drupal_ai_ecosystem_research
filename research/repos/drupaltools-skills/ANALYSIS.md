# drupaltools-skills — Phase 2 Semantic Analysis

Source: https://github.com/drupaltools/skills
Clone path: `/home/pointblank/research/repos/drupaltools-skills/`
Last commit: 2026-04-16 `chore: ignore skills from other vendors` (1 day before analysis — actively maintained)
License: GPL v2 (`LICENSE`)

---

## Q0. Primary mode

**(a) skill content** — a pure, bundled skill library. 27 `SKILL.md` units under `skills/`, each a self-contained authored skill (agentskills.io-style frontmatter + prose), plus 10 Claude sub-agent definitions under `agents/`. No tooling-to-install-others, no installer code, no aggregator. Distribution is "clone or `npx skills add`", not "run this to fetch N upstream skills." The `.gitignore` excluding `skills/drupal-*` and `skills/drupalorg-*` is a *defensive* — not aggregative — marker (see Q8).

Mild (c) overlap via the `agents/` directory (10 persona agents), so strictly this is (a) with a small (c) adjunct, but the skill count (27) dominates.

## Q1. Problem solved — author framing

From `README.md` line 162: *"A collection of AI Skills for Drupal development."* No broader mission statement. The problem is implicitly "Drupal-specific recipes that a generic coding agent does not know": from contrib contribution-readiness, to OOP hook conversion, to module cloning/renaming, to Drupal.org issue summary generation, to `PHPCS`/`PHPStan` checks, to contrib source search via the drupalcode.org GitLab API. The repo is framed as *one* vendor's entry (`drupaltools-*` namespace) in a broader ecosystem — the README "Similar tools" block at lines 235–256 lists ~19 peer repos including Surge, Kanopi toolbox, Lakedrops skills, Omedia, and `ai_best_practices`' cousin `ai_skills`.

## Q2. Primary artefact type

Authored markdown SKILL.md files with YAML frontmatter (`name`, `description`, occasional `allowed-tools`), following the **agentskills.io / Anthropic Claude Skills** convention. Several skills bundle helper Python scripts (`dsearch.py`, `csearch.py`, `fetch-blame.py`, `drupal-module-info.py`, `validate_module.py`, `generate_files.py`). One skill (`drupaltools-contrib-validator/`) has a deeper structure with `references/`, `scripts/`, `DECISIONS.md`, `README.md`, and sub-skill orchestration. Secondary artefact: 10 persona agent definitions in `agents/*.md`.

## Q3. Distribution model

Three documented paths (`README.md` lines 167–181):

1. **`npx skills add`** — `npx skills add https://github.com/drupaltools/skills` — the [skills.sh](https://skills.sh) installer (agentskills.io/skills.sh ecosystem).
2. **Git clone to `~/.claude/skills/`** for Claude Code.
3. **Git clone to `~/.agents/skills/`** for other agents consuming that convention.

No `composer.json`, no `package.json`, no `skills.yaml`, no Drupal module `.info.yml`. Not a Drupal contrib module — it is a tool-side asset pack.

## Q4. Standards conformance

**agentskills.io / Claude Code SKILL.md**, single-tool (Claude/Anthropic-family agents) but designed to also drop into "agents that use `~/.agents/skills`" per README. Evidence:

- Frontmatter shape matches agentskills.io: `name:` and `description:` required, optional `allowed-tools:` (seen in `skills/drupaltools-tip-generator/SKILL.md:4`).
- Filename is always capitalised `SKILL.md` (27/27).
- One skill per directory under `skills/`.
- No `AGENTS.md`, no `CLAUDE.md`, no proprietary wrapper.

**Independently detected skill-unit convention**: **`SKILL.md` (uppercase), one-per-subdirectory, YAML frontmatter**. `INDEX.md` confirms 27 SKILL.md files at depth 3, all matching pattern `skills/<name>/SKILL.md`. No `skill.md` lowercase, no `skill.yaml`, no bare `.md`, no numbered-dir scheme.

## Q5. Architectural pattern

**Skills-manifest + on-demand description-triggered loading.** Pattern:

- Each skill's frontmatter `description:` is a targeted trigger blurb (e.g., `drupaltools-best-practices/SKILL.md:3` has an explicit "Use this skill whenever the user wants to…" block listing verb triggers).
- The agent runtime (Claude Code / skills.sh) scans skill descriptions and invokes matching skills on demand.
- Some skills **delegate to sub-skills** by name: `drupaltools-contrib-validator/SKILL.md:13-18` orchestrates `drupaltools-contrib-readme`, `drupaltools-contrib-gitlab-ci`, `drupaltools-coding-standards` as a mini-pipeline.
- Scripts are invoked from within skill prose (e.g., `drupaltools-code-search/dsearch.py`).
- No routing layer, no semantic index, no 3-layer deterministic-then-semantic system, no aggregator-scanner.

Contrast with Surge (Drupal module aggregator) and `ai_best_practices` (universal-guidance minimal-metadata single library): this repo is closer in philosophy to `ai_best_practices` but with heavier skill bodies and per-skill frontmatter triggers instead of minimal metadata.

## Q6. Naming convention

**`drupaltools-` vendor prefix + hyphenated noun/verb phrase**, e.g., `drupaltools-best-practices`, `drupaltools-oop-hooks`, `drupaltools-issue-generate`, `drupaltools-module-rename`.

**Divergence from ai_best_practices gerund-prefix rule**: `ai_best_practices` mandates gerund-verb-in-ing (`writing-automated-tests`). drupaltools uses vendor-namespaced imperative/noun phrases. Concrete examples of divergence:

- `drupaltools-issue-generate` (imperative) vs. ai_best_practices style `generating-drupal-issues`.
- `drupaltools-code-search` (noun compound) vs. `searching-contrib-code`.
- `drupaltools-best-practices` (noun phrase) vs. `auditing-code-against-best-practices`.

The vendor prefix is a deliberate namespace-collision strategy (their `.gitignore` excludes other vendors by `drupal-*` / `drupalorg-*` prefix match) — incompatible with ai_best_practices' flat, non-namespaced gerund scheme.

## Q7. Coverage — Drupal topics enumerated

| # | Skill path | Topic |
|---|-----------|-------|
| 1 | `skills/drupaltools-best-practices/SKILL.md` | Audit code/folder against Drupal best practices (naming, site-building, theming, coding, scaffolding, 3rd-party libs, infrastructure) |
| 2 | `skills/drupaltools-checklist-development/SKILL.md` | Drupal project dev lifecycle checklist (planning → launch → maintenance) |
| 3 | `skills/drupaltools-code-search/SKILL.md` | Search Drupal contrib source via git.drupalcode.org GitLab API (bundled `dsearch.py`) |
| 4 | `skills/drupaltools-coding-standards/SKILL.md` | PHPCS + PHPStan against Drupal standards |
| 5 | `skills/drupaltools-contrib-gitlab-ci/SKILL.md` | Generate Drupal.org `.gitlab-ci.yml` |
| 6 | `skills/drupaltools-contrib-lookup/SKILL.md` | Reverse-lookup contrib source URL from a snippet |
| 7 | `skills/drupaltools-contrib-readme/SKILL.md` | Generate/validate contrib `README.md` |
| 8 | `skills/drupaltools-contrib-search/SKILL.md` | Search contrib+core via `search.tresbien.tech` API (bundled `csearch.py`) |
| 9 | `skills/drupaltools-contrib-validator/SKILL.md` | Contribution-readiness validator orchestrating 5–8, 4 (sub-skills) |
| 10 | `skills/drupaltools-cost-estimation/SKILL.md` | Estimate cost/timeline for Drupal projects |
| 11 | `skills/drupaltools-developer-setup/SKILL.md` | Optimise developer machine tooling |
| 12 | `skills/drupaltools-git-blame/SKILL.md` | Build git.drupalcode.org blame URL + fetch commit (bundled `fetch-blame.py`) |
| 13 | `skills/drupaltools-issue-generate/SKILL.md` | Draft Drupal.org issue summaries for issue forms |
| 14 | `skills/drupaltools-maintenance-contract/SKILL.md` | Drupal maintenance/support contract templates |
| 15 | `skills/drupaltools-migration-plan/SKILL.md` | Plan Drupal site migration/upgrade |
| 16 | `skills/drupaltools-module-clone/SKILL.md` | Clone module as scaffold with renamed machine name |
| 17 | `skills/drupaltools-module-info/SKILL.md` | Identify which module owns a file/snippet (bundled `drupal-module-info.py`) |
| 18 | `skills/drupaltools-module-rename/SKILL.md` | Rename module machine name across its codebase |
| 19 | `skills/drupaltools-onboarding/SKILL.md` | Step-by-step Drupal newcomer onboarding |
| 20 | `skills/drupaltools-oop-hooks/SKILL.md` | Drupal 11 OOP hooks/plugins/events/attributes generator |
| 21 | `skills/drupaltools-optimize/SKILL.md` | Optimise Drupal PHP for current version |
| 22 | `skills/drupaltools-patch/SKILL.md` | Apply patches from URL / d.o issue / MR / commit / file |
| 23 | `skills/drupaltools-postmortem/SKILL.md` | Generate post-mortem reports (3 example files in `examples/`) |
| 24 | `skills/drupaltools-site-audit/SKILL.md` | Drupal site audit reports for RFP/proposals |
| 25 | `skills/drupaltools-site-clone/SKILL.md` | Clone Drupal project as clean starter template |
| 26 | `skills/drupaltools-tip-generator/SKILL.md` | Random Drupal tip (external pip package `drupaltools-tip-generator`) |
| 27 | `skills/drupaltools-translations/SKILL.md` | Drupal multilingual + translation workflow |

Plus `agents/` (10 persona agents — backend dev, frontend dev, DevOps, security, performance, tech lead, core contributor, content architect, documentation expert, code archaeologist). Example: `agents/drupal-backend-dev.md` is a ~170-line system-prompt persona with explicit DI rules, caching rules, PSR-12 style, Drupal 10/11 target.

## Q8. Quality signals

- **Last commit**: 2026-04-16 — one day before analysis. Actively maintained.
- **Commit graph**: `git log` shows only **1 commit** (`68ef0c4 chore: ignore skills from other vendors`). Either (a) squashed-history recently, (b) force-pushed to `master`, or (c) brand-new public repo. Means near-zero visible commit history for analysis.
- **Tests / eval harness**: none. No `evals/`, no `tests/`, no `spec/`.
- **CI**: `.github/workflows/opencode.yml` only — responds to `/oc` or `/opencode` comments on issues/PRs by running the `anomalyco/opencode/github@latest` action with `OPENCODE_API_KEY` secret. This is an *interactive AI review bot trigger*, not a quality CI.
- **Versioning**: none. No tags, no `CHANGELOG`, no semver.
- **Issues**: not checked via GitHub API; repo was cloned fine so presumably public.
- **Maintainer activity**: single commit means either very fresh or history rewritten. Freshness is real (1-day-old commit).

**`.gitignore` flag — confirmed and explained.** Contents (4 lines total):

```
# Ignore skills from other vendors
skills/drupalorg-*
skills/drupal-*

*.env
```

This is **defensive**, not aggregative. Implication: someone (a developer, a human installer, or a skill like their own `drupaltools-contrib-validator`) is expected to **locally drop other vendors' skills into `skills/`** (e.g., from `drupalorg-cli`, `drupal-claude-skills`, `drupaldev-claude-skill`) — and the `.gitignore` prevents them from being accidentally committed. This reveals the repo is designed to **coexist in a shared `~/.claude/skills/` or `~/.agents/skills/` directory with competitor libraries** (listed in the README "Similar tools" block). It is NOT a meta-repo that aggregates others; it is a single-vendor pack that expects peer packs to sit alongside it.

## Q9. Notable innovations

1. **Sub-skill orchestration pattern** — `drupaltools-contrib-validator/SKILL.md:13-18` explicitly names three sub-skills to delegate to (`drupaltools-contrib-readme`, `drupaltools-contrib-gitlab-ci`, `drupaltools-coding-standards`). A small "skill pipeline" concept, built purely in prose + naming convention — no YAML graph required.
2. **Bundled Python scripts per skill** — 6 `.py` files co-located with SKILL.md (e.g., `dsearch.py` for GitLab contrib search, `csearch.py` for tresbien.tech search, `fetch-blame.py`). Pattern: skill text tells Claude to invoke the script; script encodes deterministic API calls.
3. **External API integration as skill surface** — `drupaltools-contrib-search` uses `search.tresbien.tech`, `drupaltools-code-search` uses the drupal.org GitLab API (`https://git.drupalcode.org/api/v4/groups/2/search?scope=blobs`). Skills are thin wrappers over real external services.
4. **Agents + Skills in one repo** — 10 persona agents (`agents/`) alongside the 27 skills. The personas are temperature-tuned and colour-tagged (e.g., `drupal-backend-dev.md:5` has `color: "#AFEEEE"`, `temperature: 0.2`). Unusual combo; most peer repos are one or the other.
5. **Opencode GitHub-comment bot** — `.github/workflows/opencode.yml` triggers the `anomalyco/opencode` AI reviewer on `/oc` PR comments. Automates AI-assisted review of the skills themselves.
6. **`drupaltools-tip-generator`** distributes a separate pip package as the backing implementation — a clean pattern for skills that need a binary/CLI underneath (`SKILL.md:4` declares `allowed-tools: Bash(pip *), Bash(pipx *), Bash(drupaltools-tip-generator *)`).
7. **Vendor-namespaced `.gitignore` coexistence pattern** — see Q8. Non-obvious design choice that anticipates user-side multi-vendor installs.

## Q10. Weaknesses / gaps

1. **Single commit history** — impossible to trace evolution, see reviewers, or judge contributor diversity. Could be intentional fresh-open-source, but opaque.
2. **No tests / no eval harness** — skill behaviour is unvalidated. 27 skills × 0 evals = quality unmeasured.
3. **No versioning** — no tags, no `CHANGELOG`. Consumers install `master` unpinned.
4. **Vendor prefix locks out ecosystem alignment** — `drupaltools-` prefix on all 27 skills is incompatible with the `ai_best_practices` gerund scheme AND non-mergeable with other libraries that use flat namespaces. If someone installs drupaltools + Surge + Kanopi toolbox, they'll have 3 prefixing philosophies side-by-side.
5. **Frontmatter is not ai_best_practices-minimal** — zero `drupal-version`, zero `status`. Many skills embed Drupal-version claims in prose (e.g., `drupaltools-best-practices/SKILL.md:9` says "Covers Drupal 8.x and above") rather than as structured metadata. Downstream filtering/indexing is blocked.
6. **Opinionated best-practices without citation cascade** — `drupaltools-best-practices/SKILL.md` sources from *one* upstream (theodorosploumis/drupal-best-practices at line 8). Some items are contested (e.g., "`drupal/recommended-project` as base"). No disagreement surface.
7. **No Drupal version matrix per skill** — skills uniformly assume Drupal 10/11 without machine-readable compatibility fields.
8. **10 persona agents overlap with 10+ competitor persona packs** (Kanopi, gkastanis sub-agent-collective, madsnorgaard). Duplication of effort.
9. **Python-script dependency without setup instructions** — `drupaltools-code-search/dsearch.py`, etc. No requirements, no interpreter check documented at repo root.
10. **`drupaltools-tip-generator` backed by external pip package** — skill works only after `pip install drupaltools-tip-generator`, creating install friction not signalled by the `npx skills add` path.

## Q11. Compatibility with ai_best_practices decisions

| Decision | drupaltools | Delta |
|---|---|---|
| **Skill naming (gerund + verb-in-ing)** | `drupaltools-` vendor prefix + noun/imperative | **Incompatible**. All 27 must be renamed (e.g., `drupaltools-oop-hooks` → `generating-oop-hooks`; `drupaltools-issue-generate` → `generating-drupal-issues`; `drupaltools-coding-standards` → `enforcing-coding-standards`). |
| **Directory `skills/` at project root** | `skills/` at project root | **Compatible**. Already matches. |
| **Minimal metadata — `drupal-version` + `status` only** | Free-form `description:`, no `drupal-version`, no `status`, occasional `allowed-tools:` | **Partial**. Needs metadata simplification — strip trigger-heavy descriptions OR keep them but add `drupal-version` and `status` fields. |
| **Composer-installable** | `npx skills add` + `git clone` | **Incompatible**. No `composer.json`. Would need to add a Composer package wrapper. |
| **Scope: universal guidance across Drupal projects** | Mix — some universal (best-practices, oop-hooks, coding-standards), some task-specific (tip-generator, postmortem-examples, maintenance-contract-templates), some vendor-specific (site-clone/site-audit for agency RFPs) | **Partial**. Filter needed — drop RFP/contract-template skills, keep universal-guidance skills. |

**Changes to merge into ai_best_practices:**

- Rename all skills to gerund scheme.
- Strip or relocate the 10 persona agents (ai_best_practices is skill-scoped, not agent-scoped).
- Add `drupal-version` + `status` frontmatter; remove trigger-blurb-heavy descriptions.
- Add `composer.json` (or defer to ai_best_practices' own packaging).
- Drop vendor-specific skills (`maintenance-contract`, `cost-estimation`, `site-audit`, `onboarding`, `tip-generator`) — keep universal-guidance skills (`best-practices`, `coding-standards`, `oop-hooks`, `patch`, `migration-plan`, `translations`, `optimize`, `code-search`).
- Convert Python-script-bundled skills to plain-markdown guidance or isolate the scripts as an opt-in tool-pack.

## Q12. Relationship to Surge

Surge is a Drupal contrib **module** (Drupal-runtime) that exposes AI-assisted development tooling inside a Drupal site. drupaltools-skills is a **client-side skills pack** consumed by external coding agents (Claude Code, skills.sh, `~/.agents/skills/`).

- **Does Surge aggregate this?** No evidence. Surge lives at `drupal.org/project/surge`; this repo is GitHub `drupaltools/skills`. The README *lists* Surge under "Similar tools" at line 255 but does not declare it as an installer or aggregator.
- **Could Surge aggregate it?** Technically yes — Surge could ship a composer package that clones drupaltools' `skills/` directory into the user's skills dir (similar to how drupaltools' `.gitignore` anticipates peer vendors). Would require Surge to adopt the `npx skills`/agentskills.io convention.
- **Conflict?** Light. Surge operates server-side (inside Drupal). drupaltools operates client-side (agent skill dir). They occupy orthogonal layers. The *only* real conflict surface is if Surge also publishes to `~/.claude/skills/` with colliding skill names — which the README "similar tools" list suggests is a real ecosystem hazard.

## Q13. Verdict — **Reference (partial absorb)**

drupaltools-skills is the **widest skill-topic coverage** in the research set (27 SKILL.md units, confirmed by `INDEX.md:39`) and the content quality in the skills I sampled (`drupaltools-best-practices`, `drupaltools-oop-hooks`, `drupaltools-contrib-validator`, `drupaltools-backend-dev` agent) is genuinely strong — real Drupal expertise, concrete examples, version-accurate advice. But the **vendor-namespaced naming, bloated per-skill frontmatter triggers, missing minimal-metadata fields, zero eval/test coverage, single-commit opaque history, and bundled Python scripts** make it non-mergeable as-is into `ai_best_practices`. The right move is **reference + cherry-pick**: absorb the *content* of universal-guidance skills (best-practices, oop-hooks, coding-standards, patch, migration-plan, translations, optimize, code-search) after renaming to gerund scheme and stripping vendor prefix, drop vendor/agency-specific skills (maintenance-contract, cost-estimation, site-audit, onboarding, tip-generator), and leave the 10 persona agents out of scope (they belong in an agents-suite, not a skills-library). Collaboration with the maintainer is worthwhile if they are willing to re-base to ai_best_practices' conventions — but given the vendor-prefix design intent revealed by the `.gitignore` (deliberate coexistence with peer vendor packs rather than merging into a canonical pack), collaboration seems philosophically at odds with `ai_best_practices`' consolidation goal. **Do not ignore** — this is Tier 1 content — but absorb selectively, not wholesale.

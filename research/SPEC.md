# SPEC — `ai_best_practices` as Drupal AI Skill Canon

Discussion draft for the drupal.org issue queue of [`ai_best_practices`](https://www.drupal.org/project/ai_best_practices). Not a final design — a starting point for contributor challenge. Evidence grounded in `/home/pointblank/research/SYNTHESIS.md` (hereafter §N). Corroborating detail in the 25 Phase-2 `ANALYSIS.md` files.

---

## 1. Problem statement

The Drupal AI-skills ecosystem is a fragmented archipelago. Across 25 surveyed repositories we count **~193 authored `SKILL.md` files** (§1) — 27 from drupaltools, 37 from drupal_devkit, 35 from edutrul, 20 from gxleano, 19 from gkastanis, plus long-tail single-skill repos. Same topics are reimplemented 6–12 times: coding standards in at least 8 places (§5.1), security/OWASP in 12 (§5.2), OOP hooks in ~8 (§5.3). Exactly **one** authored SKILL.md strictly matches `ai_best_practices`' gerund-prefix naming convention (`gkastanis/writing-plans`) — the ecosystem has drifted from every convention `ai_best_practices` has locked (§2, §7 "naming-drift epidemic"). Four repositories already defer to `ai_best_practices` by name (ronaldtebrake, drupal_devkit, scottfalconer via `ai_skills`, `ai_skills` itself — §7). The opportunity and the obligation is the same: become the community canon so that duplicate effort collapses into a single reviewable corpus.

## 2. Current `ai_best_practices` decisions — recap (locked)

Not open for re-litigation in this spec. Listed so contributors know what is assumed:

- **Naming**: gerund-prefix, verb-in-ing form (`writing-automated-tests`, `avoiding-security-vulnerabilities`).
- **Directory**: `skills/` at project root (agentskills.io convention, mirrors `ai_skills` / `drupaltools-skills` / `gkastanis` / `grasmash`).
- **Frontmatter metadata**: minimal — `drupal-version` and `status` only. `last-reviewed` was rejected.
- **Distribution**: Composer-installable package (`drupal/ai_best_practices`).
- **Scope**: universal Drupal guidance. No project-specific content; no runtime module code; no harness-specific installers.

## 3. Proposed architecture

`ai_best_practices` is a **content source** — a Composer-installable library of `SKILL.md` files that downstream aggregators discover and distribute. It does not ship a scanner, a CLI, or a harness adapter. Those layers already exist and work.

### 3.1 Content source for ecosystem aggregators
Two upstreams should discover `ai_best_practices` content unchanged:
- **Surge** scans `vendor/*/*/skills/`, `vendor/*/*/.claude/skills/`, and `vendor/*/*/.agents/skills/` via its `SkillsScanner` (§5.7, §6 "best distribution"). Publishing `drupal/ai_best_practices` with `skills/` at root makes us directly scannable.
- **drupal_devkit** registers `ai_best_practices` as a default marketplace source on every install (§7 item 3; `drupal_devkit/install.sh:95-100`). devkit is self-declared as a reference implementation of `ai_best_practices` and its `AGENTS.md:43-49` states "if a skill in devkit disagrees with a guidance document in ai_best_practices, the guidance wins."

### 3.2 Routing pattern (ronaldtebrake, adapted)
Each absorbed skill follows the thin-SKILL.md + routing-table pattern (§6 "best structural / routing pattern"): `~60-line` activation body + sibling `standards-index.md` (or equivalently named routing file) mapping extensions or topics to deep content loaded on demand. Adapt to gerund-prefix names (e.g. `writing-drupal-coding-standards/standards-index.md`). This keeps activation token cost low and aligns with `ai_skills`' identical reinvention of the same pattern.

### 3.3 Quality gates (gxleano, adapted)
Ship a **recommended** `scripts/post-generation-lint.sh` and `scripts/pre-bash-guard.sh` as copy-paste examples (§6 "best hooks / quality gates"). The critical loop — phpcbf auto-fix → phpcs → targeted greps for `eval()`, `shell_exec()`, `\Drupal::` in `src/`, missing `accessCheck()` — with non-zero exit feeding errors back to the agent is the tightest verification loop in the corpus. Do not ship as required infrastructure; do not force a settings.json on users. They are illustrative companions.

### 3.4 Eval coverage (drupal_devkit L3 conformance)
Adopt devkit's assertion-file pattern (§6 "best eval / testing approach"): `evals/<skill>/evals.json` with 4 assertion types (`must_contain_any`, `must_not_contain`, `syntax_check`, `check_markdown_structure`). devkit's 3-tier runner (Gemma-L1 / Haiku-L2 / Opus-L3) executes these. Contributors without API keys can still land skills graded on Gemma-3-4B via Ollama. This is the only portable, CI-friendly eval format in the survey.

### 3.5 Optional `drupal-marketplace.json` root manifest
Ship a `drupal-marketplace.json` at repo root (§3 Cluster C; drupal_devkit's conformance ladder L0–L3). This promotes `ai_best_practices` to L1 under devkit's schema and makes discovery explicit rather than inferred. Non-blocking for Composer/Surge paths.

Architectural line: **`ai_best_practices` owns the content contract. It does not own runtime, installer, harness, or scanner.**

## 4. Per-repo disposition

One line per repo. `D` = Phase-2 disposition (§ Appendix). Column 3 is the specific action.

### Infrastructure (collaborate)

| repo | recommendation | action |
|---|---|---|
| surge | collaborate | nest `drupal-version`/`status` under `metadata:` in frontmatter to pass `SkillsScanner`'s allow-list (§5.7, §5 row "surge"); open issue proposing surge swap `require drupal/ai_skills` → `drupal/ai_best_practices` once parity hits. |
| drupal_devkit | collaborate | keep the `default-marketplace-source` registration; align `drupal-marketplace.json` at our root; file bugs on divergent guidance per devkit's own policy (`AGENTS.md:43-49`). |

### Absorb content

| repo | recommendation | action |
|---|---|---|
| zivtech-a11y-meta-skills | absorb unconditionally | absorb all 4 skills — `a11y-planner`, `a11y-critic`, `a11y-test`, `perspective-audit` — verbatim (license permits). Only a11y source in the corpus (§4, §6 pick 7). Rename to gerund form. |
| zivtech-drupal-meta-skills | absorb (highest quality) | absorb `drupal-critic` → `reviewing-drupal-changes`; `drupal-planner` → `planning-drupal-architecture` (§6 picks 5–6). Carry the paired `.claude/agents/*.md` as companion reference; skill-as-router / agent-as-protocol split. |
| scottfalconer drupal-contribute-fix (via `ai_skills`) | absorb | absorb `drupal-contribute-fix` skill + `scripts/contribute_fix.py` + `lib/` stdlib-only tooling (§6 pick 8). Rename to `contributing-upstream-fixes`. Crown jewel — this is the content parity needed to unblock the surge dependency swap. |
| scottfalconer drupal-intent-testing | absorb (selective) | extract intent-testing pattern into `testing-drupal-intent` (§6 pick, §5 row). Pytest scaffolding is illustrative only. |
| ablerz CI pattern | reference + borrow CI | copy `.github/workflows/check-versions.yml` staleness-monitor idea (§6 "best eval / testing"). Not an eval — a freshness gate. |
| gxleano lint hook | absorb scripts | ship `post-generation-lint.sh` + `pre-bash-guard.sh` (§6 "best hooks / quality gates") as recommended companions, paraphrased (no LICENSE — §7 "license-missing epidemic"). |
| gkastanis routing / doc pyramid | absorb selectively | pull `verification-before-completion` → `verifying-before-declaring-done` (§6 pick 10); `drupal-caching`, `drupal-config-management` (honourable mentions). Reject `drupal-rules` mega-skill — conflicts with one-topic principle (§5.5). |
| grasmash (selected) | absorb content | `drupal-simple-oauth` → `securing-drupal-oauth` (§6 pick 3); `drupal-search-api` → `tuning-drupal-search-api` (§6 pick 4); `drupal-contrib-mgmt` → `managing-drupal-contrib`. Reference distribution; reference `quality-gate.md`/`done-gate.md` agent split (§6 "best agent definitions"). |
| madsnorgaard (selected) | reference / paraphrase | no LICENSE — paraphrase only (§7). Entity-API framing worth mining. |
| edutrul (selected) | absorb content | `drupal-hooks` → `writing-drupal-hooks` (§6 pick 1, tightest D11 `#[Hook]` body); `drupal-security` → `hardening-drupal-security` (§6 pick 2, VULNERABLE/SAFE framing) — pair with zivtech's calibration gate (§5.2). `drupal-menus`, `drupal-state`, `drupal-batch` fill gaps no one else fills (§4). |

### Reference (pattern only; no bulk content)

| repo | recommendation | action |
|---|---|---|
| drupal-canvas-skills | reference pattern only | Canvas content is project-specific (§Appendix). Borrow the routing shape. |
| aldunchev | harvest rules only | figma→SDC rules only; multi-tool claims are not backed (§6 "best multi-tool"). |
| Omedia | reference | README-claimed MIT, LICENSE absent (§7). Paraphrase-only. |
| jamieaa64 | reference only | lowercase `skill.md` → silent-fail risk. Ignore install path; read content. |
| ronaldtebrake (pattern) | reference | already redirects to `ai_best_practices`; use his `standards-index.md` as the canonical routing reference (§6 "best structural"). |

### Historical / dependency

| repo | recommendation | action |
|---|---|---|
| ai_skills | migration target | treat as deprecated upstream; publish content parity, then propose surge repoint (§5). See §5 of this spec. |
| ronaldtebrake (author) | honour the redirect | coordinate a pointer edit once parity skill lands. |

### Ignore

| repo | recommendation | action |
|---|---|---|
| aidev | ignore | Drupal contrib module, not skill library (§3 Cluster E). |
| nonzod | ignore | broken install; strictly inferior to ronaldtebrake (§Appendix). |
| ivanboring | ignore | Symfony Console CLI, not skill library (§3 Cluster E). |
| Simply007 | ignore | CKEditor-playground demo; one DLL/UMD nugget at most (§Appendix). |
| Lullabot (as whole) | ignore as substrate | content quarry only — paradigm mismatch (§3 Cluster C). Mine individual rules, never the framework. |
| drupaltools-skills wholesale | partial only | 27 skills bundled with vendor prefix that would break on merge (§2 row). Cherry-pick, don't absorb wholesale. |
| drupal-canvas-skills wholesale | pattern only | content is project-specific to Canvas. |

## 5. Relationship with Surge

**Position**: `ai_best_practices` is a **content source** that both Surge and drupal_devkit aggregate. It is **not** a competitor to Surge's Composer-plugin scanner, nor to drupal_devkit's marketplace-of-marketplaces Python CLI. Three layers, three owners:

1. **Content** — `ai_best_practices` (this project). Ships `skills/` at root + `drupal-marketplace.json` + `evals/`.
2. **Drupal-native distribution** — Surge. Owns `SkillsScanner`, `PathSecurity`, `post-install-cmd` Composer hook wiring (§6 "best distribution"; Q8 surge: 1,615 lines of tests).
3. **Multi-harness distribution** — drupal_devkit. Owns the 8 harness emitters (Claude, Copilot, Codex, Cursor, Gemini, Kiro, OpenCode, Hermes), the `portability-audit.py` enforcement, and the curl-bash universal installer (§6 "best multi-tool").

### 5.1 Frontmatter compatibility with Surge

Surge's validator enforces `name`, `description`, `license`, `allowed-tools`, `metadata`, `compatibility` (§2 row "surge"). Our locked `drupal-version` + `status` must nest under `metadata:` to pass:

```yaml
---
name: writing-drupal-hooks
description: OOP hooks in Drupal 11 with #[Hook] attribute...
license: GPL-2.0-or-later
metadata:
  drupal-version: "10 || 11"
  status: stable
---
```

This is a one-line presentation detail of the same minimal-metadata decision. Open for contributor review (see §7 Q1) — but the substantive minimalism is locked.

### 5.2 The `drupal/ai_skills` transition problem

Surge hard-requires `drupal/ai_skills` via Composer (§5.7, §7 self-deference chain). `ai_skills` is flagged UNSUPPORTED on drupal.org and redirects to `ai_best_practices`. Three resolution paths:

- **(a) namespace squat** — publish `ai_best_practices` as `drupal/ai_skills`. Politically awkward; rejected by evidence bar.
- **(b) Surge repoints** — Surge swaps `require drupal/ai_skills` → `drupal/ai_best_practices` after we hit content parity. **Preferred.** Requires us to ship `contributing-upstream-fixes` (§6 pick 8) before the swap is credible.
- **(c) `ai_skills` becomes a thin meta-package** re-exposing `ai_best_practices` content. Acceptable fallback.

**Recommended path**: land `contributing-upstream-fixes` in v0.1, open a Surge issue proposing (b), hold (c) as a fallback if upstream timing doesn't align.

## 6. Migration / compatibility story

Four populations, four stories.

**`ai_skills` users.** Most downstream use is transitive — users installed Surge, Surge pulled `drupal/ai_skills`. Once Surge repoints (§5.2 path b), their `composer update` does the migration. Individual direct installers of `drupal/ai_skills` get a Composer deprecation notice in `ai_skills`' next tagged release plus a README pointer. Zero skill renames for them because `ai_skills`' 3-skill surface (`drupal-coding-standards`, `drupal-contribute-fix`, `drupal-issue-queue`) maps cleanly to the 3 gerund-renamed skills we ship.

**`gkastanis-drupal-workflow` users.** Keep the plugin — it is a harness bundle (commands, hooks, agents — Cluster B) and is out of scope for `ai_best_practices`. Add `drupal/ai_best_practices` as an **optional** Composer dependency in their project; `gkastanis` can then reference our gerund-named skills from its commands rather than duplicating content. `drupal-rules` (the mega-skill, §5.5) stays in `gkastanis`; we don't absorb it.

**`grasmash` / `drupaltools-skills` / `edutrul` users.** Parallel run while `ai_best_practices` matures. For skills we absorb, publish an alias in our frontmatter (e.g. `aliases: [drupal-simple-oauth]`) if downstream routers support it; otherwise the migration is "uninstall upstream, install `drupal/ai_best_practices`, adjust any hard-coded skill-name references." Each of these three projects has a Phase-2 absorb list — §4 of this spec — so users can cross-check what they lose (nothing authored uniquely; all absorbed content is preserved).

**`ronaldtebrake` users.** The author already redirects users to `ai_best_practices` (§7 item 1). Once we ship `writing-drupal-coding-standards` with his `standards-index.md` routing pattern, the redirect becomes concrete. No migration action required of users; they follow the redirect.

Common across all four: gerund-prefix rename is the migration friction. Four repos (ronaldtebrake, drupal_devkit, `ai_skills`, scottfalconer) already defer to us — they can coordinate rename pointers in their own READMEs at the v0.1 release.

## 7. Open questions for the issue queue

Not rhetorical. Each is a real decision point:

1. **Surge `metadata:` nesting vs. "minimal"** (§5.1). Is nesting under `metadata:` a violation of the "minimal" spirit or a purely presentational concession? I read it as presentational; the substantive minimalism (two keys: `drupal-version`, `status`) survives. Open for challenge.
2. **Ship `drupal-marketplace.json` at root** for drupal_devkit L1 (§3.5)? Adds 30 lines to repo root. Gains L1 conformance. Cost seems trivial; raise for sign-off.
3. **Parity-with-`ai_skills` timeline** to unblock the Surge dependency swap (§5.2). Must `contributing-upstream-fixes` land in v0.1? Or can v0.1 ship without it and we stage the Surge repoint for v0.2? I favour v0.1 parity; earlier swap reduces transition risk.
4. **Scope of `contributing-upstream-fixes`** — absorb `scottfalconer/drupal-contribute-fix` verbatim (its current home is `scottfalconer/drupal-contribute-fix`, mirrored via `ai_skills`), or rewrite in gerund-prefix with adapted tooling? Verbatim is faster; rewrite risks bit-rot against upstream.
5. **Licence policy** (§7 "license-missing epidemic"). Half the corpus is license-absent. Do we require `Apache-2.0` or `MIT` on absorbed content? For license-missing source material: (a) ask authors to add a license before absorbing, or (b) paraphrase only? I favour (a) with (b) as fallback.
6. **Eval coverage floor** (§3.4). What percentage of skills must ship `evals/<skill>/evals.json` at v0.1? 100% seems aggressive given we're absorbing 10+ skills. 50% with a CI target of 100% by v0.2?
7. **Meta-orchestration scope** (§6 picks 5–6). Absorb zivtech-meta's `drupal-critic` / `drupal-planner` into `ai_best_practices`, or defer to a separate `drupal/ai_best_practices_meta` package? Arg for inclusion: only credible meta-skill substrate in the corpus. Arg for defer: meta-orchestration is paired with agents, which are arguably out of scope.
8. **Non-English / i18n coverage.** Entire corpus is English. Open question for community: do we solicit translated prose, or keep English-only with separate translation projects?
9. **Accessibility skill ownership** (§6 pick 7). Absorb zivtech-a11y verbatim into our corpus, or maintain it as a referenced external package since its author (Zivtech) is active? My read: absorb with attribution; Zivtech's content is explicitly licensed and the only a11y source in the ecosystem.
10. **Recipe-based delivery** alongside Composer package. Should we ship a Drupal Recipe that wires `ai_best_practices` into a site's `composer.json` + installs Surge? Scope creep or natural onboarding?

## 8. Out of scope — explicit

To keep the review tight, these are **not** the project:

- **Runtime module code.** `aidev`'s model (Drupal contrib module that embeds an AI chat) is a different product category (§3 Cluster E).
- **Project-specific skills.** Canvas Code Components as a project (`drupal-canvas-skills`), or edutrul-application specifics outside universal Drupal patterns, are downstream content.
- **Prompt libraries.** Lullabot's `prompt_library` is a different paradigm (11ty site serving generated `SKILL.md` + raw-markdown URL API). Mine it as a quarry; don't replicate it (§3 Cluster C).
- **CKEditor-in-browser AI.** The `drupal_ai` contrib module is site-side; tier3.md notes an empty placeholder repo. Out of scope.
- **Non-Drupal skills.** This is `ai_best_practices` for Drupal. Adjacent Symfony/PHP content is referenced, not authored.
- **Harness-specific installer engineering.** drupal_devkit owns the 8-harness emitter matrix, per-harness Claude-syntax stripping, and the curl-bash installer (§6 "best multi-tool"). We do not re-implement.
- **Scanner / Composer-plugin engineering.** Surge owns `SkillsScanner`, `PathSecurity`, Composer-plugin hooks (§6 "best distribution"). We do not re-implement.
- **Commands / hooks / agents as first-class assets.** Locked scope is skills-only. Commands, hooks, and agents are *referenced* (§3.3 ships sample scripts) but are not authored assets of this project. The harness-bundle repos (Cluster B) remain the right home for those layers.

---

*Draft. Challenge anything. Open in the issue queue.*

# opus-4-7 — Claude Code + Claude Opus 4.7 (1M) + high-effort reasoning

Research snapshot produced 2026-04-17 for the prompt in `PROMPT.md` on `main`.

## Run metadata

| Field | Value |
|---|---|
| Tool | Claude Code (Anthropic's official CLI) |
| Model | `claude-opus-4-7` (Claude Opus 4.7, knowledge cutoff 2026-01) |
| Context | 1M tokens |
| Reasoning mode | `effortLevel: "high"` (user global setting) |
| Orchestration | Main agent + ~30 spawned sub-agents (general-purpose) for Phase 1 indexing and Phase 2 per-repo analysis |
| Run date | 2026-04-17 |
| Contributor | gkastanis (branch author) |

## What's in this branch

Follows the `Expected Branch Structure` from `main`:

- `research/SPEC.md` — proposal draft for the `ai_best_practices` issue queue (2457 words, 8 sections, 10 open questions).
- `research/SYNTHESIS.md` — cross-repo synthesis (6002 words, 7 sections: landscape map, standards conformance map, pattern clusters, coverage matrix, overlap analysis, best-in-class picks, meta-observations).
- `research/tier3.md` — lighter scans of adjacent/index-style resources (5 entries).
- `research/acquisition-failures.md` — acquisition log. **Empty** — 25/25 target repos cloned successfully.
- `research/repos/<slug>/INDEX.md` × 25 — deterministic Phase 1 acquisition output (file tree, file-type counts, key-file presence, SKILL.md count, README head, last commit).
- `research/repos/<slug>/ANALYSIS.md` × 25 — Phase 2 semantic analysis against a Q0–Q13 rubric (Tier 1 full) or Q1/2/3/4/7/8/11/13 subset (Tier 2 lite).

## Scope expansion from the original prompt

Three groups of repositories were added to the clone list during the run, with user approval at checkpoints:

- **`drupal_devkit`** — promoted from Tier 3 to full Tier 1 analysis after initial scan revealed it positions itself as the "reference implementation of `ai_best_practices`" and registers `ai_best_practices` as a default marketplace source.
- **`edutrul/drupal-ai`** — added (full Tier 1) on user pointer; 35 `SKILL.md` files, multi-tool (Claude/Codex/Cursor/Copilot).
- **`nonzod/drupaldev-claude-skill`, `zivtech/drupal-meta-skills`, `zivtech/a11y-meta-skills`** — added (Tier 2 lite) after they surfaced in the zivtech landscape page scan.

Final count: **25 repos indexed + analysed** (9 Tier 1 full, 16 Tier 2 lite) + **5 Tier 3 entries**.

## Headline findings

From `research/SYNTHESIS.md`:

- **Near-total naming drift**: of ~193 authored `SKILL.md` files across the 25 repos, exactly **one** (`gkastanis/writing-plans`) matches `ai_best_practices`' locked gerund-prefix convention.
- **`ai_best_practices` is a content source, not a competitor**: Surge (Composer-plugin scanner) and drupal_devkit (Python marketplace-of-marketplaces) both aggregate it. drupal_devkit already registers it as a default marketplace source.
- **Dependency transition trap**: Surge hard-requires frozen `drupal/ai_skills`. `ai_best_practices` must reach parity (ship `contributing-upstream-fixes` content) before Surge can swap `require drupal/ai_skills` → `require drupal/ai_best_practices`.
- **Biggest coverage gap**: accessibility is covered by exactly one repo (zivtech-a11y-meta-skills). Zero ecosystem coverage for JSON:API/REST/decoupled, state API, batch/queue, recipes.
- **Licence-missing epidemic**: ~half the corpus ships no `LICENSE` file — blocks verbatim absorption.

## Top SPEC recommendations

From `research/SPEC.md`:

1. Publish `drupal/ai_best_practices` as a Composer package with `skills/` at root + `metadata:`-nested frontmatter (passes Surge's `SkillValidator`, compatible with drupal_devkit).
2. Land `contributing-upstream-fixes` (absorbed from `scottfalconer/drupal-contribute-fix` via `ai_skills`) in v0.1 as the parity gate for Surge's dependency swap.
3. Unconditionally absorb `zivtech-a11y-meta-skills` (only accessibility source). Selectively absorb `zivtech-drupal-meta-skills` critic/planner, `edutrul-drupal-ai` hook pattern, `gxleano-drupal-agentic-workflow` post-generation-lint hook, `gkastanis-drupal-workflow` routing/doc-pyramid.

See `research/SPEC.md` §7 for 10 open questions surfaced for the issue queue.

## Limitations

- **Time-bound**: captures the ecosystem as of 2026-04-17. Some repos (`drupal_ai` on drupal.org) were created in the last 24 hours and had empty git histories at scan time.
- **Sub-agent variance**: Phase 2 analyses were produced by ~20 parallel general-purpose sub-agents with a shared rubric. Writing style and depth vary across analyses. Q0–Q13 citations were spot-checked but not exhaustively re-verified.
- **Content quality not evaluated at line level**: the "best-in-class" picks in `SYNTHESIS.md §6` are grounded in Phase 2 ANALYSIS.md claims, not in end-to-end eval runs of the skills themselves.
- **No PR filed**: this branch is a research artefact. Translating it into concrete `ai_best_practices` issues/PRs is next-step work.

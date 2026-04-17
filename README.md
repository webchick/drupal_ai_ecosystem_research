# codex-gpt-5.4-high-reasoning — Codex + GPT-5.4 + high reasoning

Research snapshot produced on 2026-04-17 for the Drupal AI tooling landscape prompt focused on what `ai_best_practices` should absorb, reference, collaborate with, or ignore.

## Run metadata

| Field | Value |
|---|---|
| Tool | Codex |
| Model | `gpt-5.4` |
| Reasoning mode | high |
| Run date | 2026-04-17 |
| Output style | deterministic indexing + per-repo analysis + synthesis + spec draft |

## What's in this branch

- `research/SPEC.md`
  947-word proposal draft for `ai_best_practices`
- `research/SYNTHESIS.md`
  2382-word cross-repo synthesis
- `research/tier3.md`
  721-word scan of adjacent/index-style resources
- `research/acquisition-failures.md`
  acquisition log; empty for this run
- `research/repos/<slug>/INDEX.md` × 19
  deterministic acquisition output for each cloned repo
- `research/repos/<slug>/ANALYSIS.md` × 19
  semantic analysis for each Tier 1 / Tier 2 repo

## Scope of this run

This branch covers:

- 19 cloned and indexed repos
- 19 matching analyses
- 1 cross-repo synthesis
- 1 spec draft
- 1 Tier 3 scan covering adjacent ecosystem context

Compared with later / larger runs, this branch is intentionally tighter. It focuses on the original Tier 1 and Tier 2 landscape and produces a concise synthesis rather than the expanded 25-repo corpus seen in other branches.

## TL;DR of the prompt

The underlying task was:

> Survey the Drupal AI tooling landscape, especially repos dealing with agent skills, contribution helpers, workflow integrations, prompt libraries, and testing harnesses, then determine what `ai_best_practices` should absorb, reference, collaborate with, or ignore.

Operationally, that meant:

- acquire and index a fixed list of Drupal-related repos
- analyze each repo against a common rubric
- compare overlap, divergence, and standards conformance
- identify best-in-class patterns and content
- produce a synthesis and a draft proposal for `ai_best_practices`

## Headline findings

From `research/SYNTHESIS.md` and `research/SPEC.md`:

- The ecosystem does not lack Drupal AI guidance; it lacks **convergence**.
- The strongest direct absorb candidates in this run were:
  - `drupal-claude-skills`
  - `drupaltools-skills`
  - `drupal-contribute-fix`
  - `drupal-coding-standards-skill`
  - `omedia-drupal-skill`
- The strongest architectural inputs came from repos that should mostly be **referenced**, not merged wholesale:
  - `drupal-workflow` for routing, evals, and quality gates
  - `drupal-agentic-workflow` for hook ideas
  - `drupal-agent-resources` for mixed skills/commands structure
  - `drupal-critic` for review-rubric ideas
- The most duplicated universal topics were:
  - coding standards
  - testing
  - contribution workflow
  - DDEV / Drush / local tooling
  - security
- The main recommendation of this run was that `ai_best_practices` should become the canonical Drupal-wide **content source**, while distribution and aggregation concerns should stay distinct at the architectural level.

## Structural takeaways

This run identified a few especially strong patterns:

- **Best structural / routing pattern**: `drupal-workflow`
- **Best eval / testing pattern**: `drupal-workflow`
- **Best standards-native packaging**: `drupal-canvas-skills`
- **Best distribution / install story**: `surge`
- **Best narrow contribution workflow skill**: `drupal-contribute-fix`
- **Best coding-standards routing pattern**: `drupal-coding-standards-skill`

## Limitations

- This branch covers a **19-repo corpus**, not the later expanded 25-repo set.
- One external landscape page in Tier 3 could not be fully fetched from this environment, so it was treated cautiously as a discovery aid rather than as a fully inspected primary source.
- The synthesis reflects the architectural framing used during this run; some conclusions were later refined in discussion, especially around whether `ai_best_practices` and Surge should be separate *projects* versus separate *concerns*.

## Intended use

Treat this branch as a time-bound research artefact tied to:

- the Codex + GPT-5.4 tool/model combination
- the source set available on 2026-04-17
- the judgment calls made during this specific run

It is useful as a comparable snapshot, not as permanent canonical truth.

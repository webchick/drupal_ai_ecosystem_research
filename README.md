# Drupal AI Ecosystem Research

This repository is a holding space for Drupal AI ecosystem research snapshots produced with different tool and model combinations.

## How This Repo Is Organized

- `main` is intentionally lightweight and acts as the landing page for the repository.
- Full research outputs live in branches named after the tool + model combination that produced them.
- Other runs should be published to similarly named branches so the provenance of each research snapshot stays obvious.

## What A Branch Means

Each non-`main` branch is intended to be a self-contained research snapshot produced by one specific tool/model/reasoning setup.

A branch name should tell you:

- which tool produced the research
- which model was used
- what reasoning mode or depth was used, if that matters

In other words, a branch is not just a working branch. It is a publishable record of one complete run so that outputs can be compared across different tool/model combinations.

## Current Branches

- `codex-gpt-5.4-high-reasoning`: full research corpus produced with Codex using GPT-5.4 at high reasoning

## Expected Branch Structure

Research branches should generally contain a structure like this:

- `README.md`
  explains the branch at a high level if needed
- `research/SPEC.md`
  a proposal or decision draft derived from the research
- `research/SYNTHESIS.md`
  a cross-repo or cross-source synthesis
- `research/tier3.md`
  lighter scans of adjacent or index-style resources
- `research/acquisition-failures.md`
  a record of any missing, failed, or unverifiable inputs
- `research/repos/<slug>/INDEX.md`
  deterministic acquisition/indexing output for a specific repo
- `research/repos/<slug>/ANALYSIS.md`
  semantic analysis of that repo based on the indexed evidence

Not every branch has to contain exactly the same files, but branches should try to follow this layout so they are easy to compare.

## What You Should Expect To Find In Research Branches

Research branches may include:

- deterministic repo indexes
- per-repo analyses
- cross-repo syntheses
- spec drafts
- acquisition logs and supporting notes

They should not be treated as canonical truth forever. They are time-bound research artefacts, tied to:

- the tool and model that produced them
- the sources available at the time
- the judgment calls made during that specific run

The intent is to compare outputs across tool/model combinations without mixing their artefacts together on `main`.

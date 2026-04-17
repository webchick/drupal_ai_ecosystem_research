# zivtech-drupal-meta-skills — Structural Index

**Source URL**: https://github.com/zivtech/drupal-meta-skills
**Clone URL used**: https://github.com/zivtech/drupal-meta-skills
**Last commit**: 2026-03-29 21:11:19 -0400
**Last commit subject**: feat: add Canvas Code Component sub-planner and Experience Builder support
**License**: LICENSE (present)
**Default branch**: refs/heads/main

## File type counts

```
     42 md
      4 json
      3 py
      2 yml
      2 yaml
      1 txt
      1 tsv
      1 log
      1 /LICENSE
      1 html
      1 gitignore
      1 csv
```

## Presence of key files/dirs

- CLAUDE.md: ✓ present
- AGENTS.md: ✓ present
- README: ✓ present (README.md)
- skills/ : ✗ absent
- .claude/ : ✓ present
- .claude/skills/ : ✓ present
- agents/ : ✗ absent (note: `.claude/agents/` is present)
- commands/ : ✗ absent
- hooks/ : ✗ absent
- prompts/ : ✗ absent
- evals/ : ✗ absent
- composer.json: ✗ absent
- package.json: ✗ absent
- skills.yaml: ✗ absent
- .cursorrules / .cursor/ : ✗ absent
- .github/ : ✓ present

## SKILL.md count

Number of SKILL.md files (case-sensitive): **8**

Lowercase `skill.md` count: 0 (none — not flagged)

Paths:
- `./.claude/skills/drupal-critic/SKILL.md`
- `./.claude/skills/drupal-planner.search/SKILL.md`
- `./.claude/skills/drupal-planner.content-model/SKILL.md`
- `./.claude/skills/drupal-planner.taxonomy/SKILL.md`
- `./.claude/skills/drupal-config-executor/SKILL.md`
- `./.claude/skills/drupal-planner.theme/SKILL.md`
- `./.claude/skills/drupal-planner/SKILL.md`
- `./.claude/skills/drupal-planner.canvas/SKILL.md`

## File tree (depth 3)

```
.
./AGENTS.md
./.claude
./.claude/agents
./.claude/agents/drupal-canvas-planner.md
./.claude/agents/drupal-config-executor.md
./.claude/agents/drupal-content-model-planner.md
./.claude/agents/drupal-critic.md
./.claude/agents/drupal-planner.md
./.claude/agents/drupal-search-planner.md
./.claude/agents/drupal-taxonomy-planner.md
./.claude/agents/drupal-theme-planner.md
./CLAUDE.md
./.claude/skills
./.claude/skills/drupal-config-executor
./.claude/skills/drupal-critic
./.claude/skills/drupal-planner
./.claude/skills/drupal-planner.canvas
./.claude/skills/drupal-planner.content-model
./.claude/skills/drupal-planner.search
./.claude/skills/drupal-planner.taxonomy
./.claude/skills/drupal-planner.theme
./CONTRIBUTING.md
./docs
./docs/drupal-config-executor
./docs/drupal-config-executor/AGENTS.md
./docs/drupal-config-executor/CLAUDE.md
./docs/drupal-critic
./docs/drupal-critic/AGENTS.md
./docs/drupal-critic/CLAUDE.md
./docs/drupal-planner
./docs/drupal-planner/AGENTS.md
./docs/drupal-planner/CLAUDE.md
./docs/index.html
./LICENSE
./README.md
./research
./research/drupal-skills
./research/drupal-skills/raw
./research/drupal-skills/reports
./research/drupal-skills/scripts
./scripts
./scripts/refresh_external_skills.py
./scripts/verify_no_copied_skills.py
./templates
./templates/critic-base-protocol.md
./templates/executor-base-protocol.md
./templates/planner-base-protocol.md
```

## README first 200 lines

Source: README.md

```
# drupal-meta-skills

Drupal planner-critic-executor bundle for Claude Code.

**[Visual Explainer](https://zivtech.github.io/drupal-meta-skills/)**  
This repo consolidates the work that previously lived across `drupal-planner` and `drupal-critic`, plus the `drupal-config-executor` generation step.

## Why this bundle exists

Drupal work breaks when planning, implementation, and review are disconnected.

- Entity structures are expensive to reverse after content exists.
- Cache tags, contexts, and max-age decisions are easy to get “mostly right” and still ship stale or personalized content bugs.
- Config workflow mistakes often look fine locally and fail on deploy.
- Teams reimplement contrib behavior as custom code because the evaluation happened too late or not at all.
- Migration and update-path mistakes are usually discovered after real data is at risk.

This bundle closes that loop:

1. **Plan the architecture** before implementation.
2. **Generate config YAML** from planner output when that artifact should be deterministic.
3. **Review the result** with Drupal-specific rigor rather than generic code review heuristics.

## What’s in the bundle

### `drupal-planner`

`drupal-planner` is the architecture surface for full Drupal implementations. It covers:

1. Scope and context
2. Existing architecture analysis
3. Data model design
4. Module architecture
5. Configuration schema
6. Permission and access model
7. Cache strategy
8. Migration and update path
9. Theme and render design
10. Implementation tasks and review checkpoints

It also ships focused sub-planners:

- `/drupal-planner.content-model`
- `/drupal-planner.taxonomy`
- `/drupal-planner.theme`
- `/drupal-planner.canvas`
- `/drupal-planner.search`

Use the main planner for full features or cross-cutting work. Use sub-planners when the scope is clearly limited to one subsystem.

### `drupal-critic`

`drupal-critic` is the review surface. It layers Drupal-specific checks on top of a structured investigation protocol so reviews do not stop at generic code quality commentary.

It checks Drupal-specific dimensions such as:

- security
- architecture and contrib-first decisions
- operational safety
- configuration workflow stability
- cache correctness
- migration idempotency
- site builder and editor experience
- testing adequacy

It also activates context-driven perspectives such as Open Source Contributor, Site Builder, and Content Editor when the review target warrants them.

### `drupal-config-executor`

`drupal-config-executor` is the deterministic generation step between planning and review. It consumes structured planner output and produces Drupal config YAML for cases like:

- content types
- fields and field storage
- form and view displays
- taxonomy structures
- Search API and facet configuration

## Commands

- `/drupal-planner`
- `/drupal-planner.content-model`
- `/drupal-planner.taxonomy`
- `/drupal-planner.theme`
- `/drupal-planner.canvas`
- `/drupal-planner.search`
- `/drupal-critic`
- `/drupal-config-executor`

## How the workflow fits together

1. Use `/drupal-planner` or the appropriate sub-planner to design the architecture.
2. Use `/drupal-config-executor` when you need YAML generated from the planner spec.
3. Use `/drupal-critic` to review the implementation or generated artifacts.

This is the core bundle workflow:

```text
drupal-planner.* -> drupal-config-executor -> drupal-critic
```

And for full-feature planning:

```text
drupal-planner -> implementation -> drupal-critic
```

## Install

```bash
npx claude-skills add https://github.com/zivtech/drupal-meta-skills
```

Manual install:

```bash
git clone https://github.com/zivtech/drupal-meta-skills.git
cp -r drupal-meta-skills/.claude/skills/* ~/.claude/skills/
cp drupal-meta-skills/.claude/agents/*.md ~/.claude/agents/
```

## Quick examples

### Full feature planning

```text
/drupal-planner Plan a product review system with ratings, moderation, and search
```

### Content model planning

```text
/drupal-planner.content-model Redesign our content model for landing pages, blogs, and case studies
```

### Theme planning

```text
/drupal-planner.theme Plan theme architecture for a Drupal 11 site using SDC
```

### Canvas component planning

```text
/drupal-planner.canvas Plan Canvas Code Component architecture for a Drupal CMS events site
```

### Search planning

```text
/drupal-planner.search Plan search for a 100k+ article content site with facets
```

### Review

```text
/drupal-critic web/modules/custom/my_module/
```

### Config generation

```text
/drupal-config-executor Generate config YAML from this drupal-planner.content-model spec
```

## Repository Layout

```text
.claude/
  agents/
  skills/
docs/
research/
scripts/
templates/
.github/workflows/
```

Root `.claude/` assets are the installable skill and agent files. `research/` and `scripts/` carry over the Drupal ecosystem and supply-chain tooling that supports the critic.

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
```

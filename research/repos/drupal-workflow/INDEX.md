# drupal-workflow Index

## Repo Facts

- Path: /Users/webchick/Documents/Codex/2026-04-17-research-drupal-ai-tooling-landscape-synthesis-2/research/repos/drupal-workflow
- Last commit date: 2026-04-15 15:03:03 +0300
- Skill count (SKILL.md): 19

## Presence / Absence

- CLAUDE.md: yes
- AGENTS.md: no
- skills/: yes
- .claude/skills/: no
- agents/: yes
- commands/: yes
- hooks/: yes
- .claude/: no
- prompts/: no
- evals/: no
- composer.json: no
- package.json: no
- skills.yaml: no
- Any SKILL.md files: yes

## File Tree (Depth 3)

~~~text
.
./.claude-plugin
./.claude-plugin/marketplace.json
./.claude-plugin/plugin.json
./.gitignore
./CHANGELOG.md
./CLAUDE.md
./INDEX.md
./README.md
./agents
./agents/drupal-builder.md
./agents/drupal-reviewer.md
./agents/drupal-verifier.md
./agents/semantic-architect.md
./commands
./commands/drupal-blast-radius.md
./commands/drupal-bootstrap.md
./commands/drupal-prime.md
./commands/drupal-refresh.md
./commands/drupal-semantic.md
./commands/drupal-status.md
./commands/drupal-test.md
./commands/drupal-verify.md
./commands/implement.md
./commands/verify-changes.md
./docs
./docs/AUTOPILOT_SPEC.md
./docs/DEVELOPER_DEPLOYMENT_GUIDE.md
./docs/PLUGIN_REVIEW_REPORT.md
./eval
./eval/behavioral
./eval/behavioral/drupal-caching
./eval/behavioral/drupal-entity-api
./eval/behavioral/drupal-hook-patterns
./eval/behavioral/drupal-rules
./eval/behavioral/drupal-security-patterns
./eval/behavioral/drupal-service-di
./eval/behavioral/workflow-patterns
./eval/compare.py
./eval/eval-agents.py
./eval/eval-builder-agent.py
./eval/eval-hooks-integration.sh
./eval/eval-hooks.py
./eval/eval-reviewer-agent.py
./eval/eval-semantic-architect.py
./eval/eval-semantic-docs.py
./eval/eval-skills.py
./eval/eval-verifier-agent.py
./eval/evals
./eval/evals/eval.json
./eval/run-behavioral.py
./eval/session-replay
./eval/session-replay/__pycache__
./eval/session-replay/extract-prompts.py
./eval/session-replay/pattern-score.py
./eval/session-replay/replay-eval.py
./eval/skill_improvement_log.md
./hooks
./hooks/hooks.json
./playground-agents.html
./playground-discover.html
./playground-workflow.html
./scripts
./scripts/autopilot-monitor.sh
./scripts/block-sensitive-files.sh
./scripts/inject-claude-md.sh
./scripts/lib
./scripts/lib/hook-utils.sh
./scripts/php-lint-on-save.sh
./scripts/plan-mode-inject.sh
./scripts/policies
./scripts/policies/debugging.json
./scripts/policies/documentation.json
./scripts/policies/implementation.json
./scripts/policies/investigation.json
./scripts/policies/maintenance.json
./scripts/policies/refactoring.json
./scripts/project-state-check.sh
./scripts/session-analysis
./scripts/session-analysis/_common.py
./scripts/session-analysis/analyze-replays.py
./scripts/session-analysis/session-branches.py
./scripts/session-analysis/session-costs.py
./scripts/session-analysis/session-dashboard.py
./scripts/session-analysis/session-overview.py
./scripts/session-analysis/session-quality.py
./scripts/session-analysis/session-search.py
./scripts/session-analysis/session-subagents.py
./scripts/session-analysis/session-thinking.py
./scripts/session-analysis/session-timeline.py
./scripts/session-analysis/session-tools.py
./scripts/staleness-check.sh
./scripts/stop-verification-gate.sh
./scripts/subagent-context-inject.sh
./scripts/task-classifier.sh
./scripts/teammate-quality-gate.sh
./scripts/tests
./scripts/tests/test-autopilot-phase2.sh
./scripts/validate-semantic-docs.sh
./scripts/validate-tech-specs.sh
./scripts/workflow-nudge.sh
./scripts/workflow-reset.sh
./skills
./skills/autopilot-tuner
./skills/autopilot-tuner/SKILL.md
./skills/autopilot-tuner/evals
./skills/autopilot-tuner/scripts
./skills/discover
./skills/discover/SKILL.md
./skills/discover/scripts
./skills/drupal-brainstorming
./skills/drupal-brainstorming/SKILL.md
./skills/drupal-caching
./skills/drupal-caching/SKILL.md
./skills/drupal-coding-standards
./skills/drupal-coding-standards/SKILL.md
./skills/drupal-config-management
./skills/drupal-config-management/SKILL.md
./skills/drupal-conventions
./skills/drupal-conventions/SKILL.md
./skills/drupal-delegation
./skills/drupal-delegation/SKILL.md
./skills/drupal-entity-api
./skills/drupal-entity-api/SKILL.md
./skills/drupal-hook-patterns
./skills/drupal-hook-patterns/SKILL.md
./skills/drupal-rules
./skills/drupal-rules/SKILL.md
./skills/drupal-security-patterns
./skills/drupal-security-patterns/SKILL.md
./skills/drupal-service-di
./skills/drupal-service-di/SKILL.md
./skills/drupal-testing
./skills/drupal-testing/SKILL.md
./skills/drupal-testing/references
./skills/semantic-docs
./skills/semantic-docs/ENTITY-LOOKUP.md
./skills/semantic-docs/SEARCH.md
./skills/semantic-docs/SKILL.md
./skills/semantic-docs/scripts
./skills/structural-index
./skills/structural-index/SKILL.md
./skills/structural-index/scripts
./skills/twig-templating
./skills/twig-templating/SKILL.md
./skills/verification-before-completion
./skills/verification-before-completion/SKILL.md
./skills/writing-plans
./skills/writing-plans/SKILL.md
~~~

## File Type Counts

~~~text
.html	3
.json	24
.md	45
.py	26
.pyc	3
.sh	39
[dotfile-no-ext]	1
~~~

## README (First 200 Lines)

Source: README.md

~~~text
# drupal-workflow

A Claude Code plugin for Drupal development with live workflow optimization. Provides 19 skills, 4 specialized agents, 10 commands, behavioral evals, session analysis, and the Magic Loop Autopilot — a live policy engine that classifies tasks, detects drift via weighted scoring, escalates interventions (hint → command → suppress), and self-tunes based on session replay data.

## Installation

### As a local plugin

```bash
claude --plugin-dir ./drupal-workflow
```

### As an npm package (future)

```bash
npm install drupal-workflow
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- [DDEV](https://ddev.readthedocs.io/) local development environment
- Drupal 10+ or 11+ project
- PHP 8.2+

## Skills (19)

Skills provide domain knowledge that Claude can consult during development.

| Skill | Description |
|-------|-------------|
| **drupal-brainstorming** | Explore requirements and design options before implementing. Entity design, service architecture, hook/event strategy. |
| **drupal-delegation** | Execute plans by dispatching specialized agents in parallel. Structured agent dispatch with tracking. |
| **drupal-rules** | Core development rules: code quality, security, services, testing. Auto-consulted when writing Drupal code. |
| **drupal-testing** | Practical testing patterns: curl smoke tests, drush eval, test scripts. Verifies implementations actually work. |
| **drupal-service-di** | Service definitions, dependency injection patterns, and interface design. |
| **drupal-entity-api** | Field types, entity CRUD, view modes, access control handlers, and content modeling. |
| **drupal-caching** | Cache bins, tags, contexts, CacheableMetadata, lazy builders, invalidation, and external caching. |
| **drupal-hook-patterns** | OOP hooks (Drupal 11), form alters, entity hooks, install/update hooks, and legacy bridges. |
| **drupal-security-patterns** | OWASP prevention patterns, access control, input sanitization, XSS protection. |
| **drupal-coding-standards** | PHPCS, PHPStan, naming conventions, and code style enforcement. |
| **drupal-conventions** | Translations, CSS conventions, error handling patterns. |
| **drupal-config-management** | Config split, config ignore, config readonly, environments, import/export workflows. |
| **twig-templating** | Twig template patterns, filters, theme suggestions, and component architecture. |
| **verification-before-completion** | Gate function preventing untested claims. Validates work before marking complete. |
| **semantic-docs** | Navigate business-logic-to-code mappings in `docs/semantic/`. Search by Logic ID, feature code, or entity schema. |
| **discover** | Docs-first codebase discovery. Use before Glob/Grep to get Logic IDs and file paths from semantic documentation. Now supports structural queries (`service:`, `hook:`, `deps:`, etc.). |
| **structural-index** | Auto-generated structural awareness for Drupal projects. Parses `*.services.yml`, `*.routing.yml`, hooks, plugins, and entity types to build dependency graphs and feature maps. |
| **writing-plans** | Write comprehensive implementation plans for sub-agents or complex tasks. |
| **autopilot-tuner** | Analyze autopilot effectiveness and self-tune the plugin. Reads session data, computes acceptance rates, and proposes policy/threshold/classifier changes. |

## Agents (4)

Four focused agents covering the full Drupal development lifecycle: build, review, verify, document.

| Agent | Description |
|-------|-------------|
| **drupal-builder** | Full-stack implementation: modules, themes, config, migrations, performance. |
| **drupal-reviewer** | Architecture, security audit, coding standards, and test writing. |
| **drupal-verifier** | Implementation verification via ddev drush eval, curl smoke tests, config checks. |
| **semantic-architect** | Generates semantic docs (Layer 3): business index, tech specs with Logic IDs, business schemas. |

## Commands (10)

Slash commands for common development workflows.

| Command | Usage | Description |
|---------|-------|-------------|
| `/drupal-test` | `/drupal-test service` | Run Drupal verification tests (services, entities, routes, config). |
| `/drupal-verify` | `/drupal-verify` | Verify implementation using smoke tests and drush checks. |
| `/implement` | `/implement` | Implement changes across all affected files with validation. |
| `/verify-changes` | `/verify-changes` | Verify code changes are complete and consistent. |
| `/drupal-bootstrap` | `/drupal-bootstrap` | Auto-detect project state, run the 3-step pipeline as needed. |
| `/drupal-prime` | `/drupal-prime` | Load full project overview into session (~2500 tokens, debug/overview). |
| `/drupal-refresh` | `/drupal-refresh` | Regenerate structural index and update CLAUDE.md hint. |
| `/drupal-status` | `/drupal-status` | Check documentation, structural index, and staleness status. |
| `/drupal-blast-radius` | `/drupal-blast-radius AUTH` | Analyze dependencies and blast radius for a feature or module. |
| `/drupal-semantic` | `/drupal-semantic init` | Generate/manage semantic docs. Subcommands: `init`, `feature FEAT`, `index`, `schema ENTITY`, `status`, `validate [--fix]`, `inject`. |

## Hooks

The plugin registers hooks for quality gates:

| Event | Trigger | Action |
|-------|---------|--------|
| **SessionStart** | Plugin loaded | Displays activation message. Auto-regenerates structural index if stale. Classifies task type (implementation/maintenance/debugging/investigation/refactoring/documentation) and loads matching policy. |
| **PreToolUse** | `Read` or `Grep` | Blocks access to sensitive files (`settings.php`, `.env`, credentials). |
| **PostToolUse** | `Edit` or `Write` | Runs `php -l` lint on modified PHP files. Advisory staleness warning when structural source files are edited. |
| **PostToolUse** | Any tool | **Autopilot monitor**: tracks session state (edits, delegations, skills, phase), computes weighted drift score, fires 3-level escalation interventions (hint → command → suppress), enforces phase budgets. |
| **SubagentStart** | Any subagent | Injects Drupal context (version detection, agent memory paths). |
| **TaskCompleted** | Task marked done | Runs quality gate checks on completed work. |

## Project Structure

```
drupal-workflow/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── skills/                   # 19 skills (18 Drupal + 1 autopilot)
│   ├── structural-index/     # Auto-generated structural awareness
│   │   └── scripts/          # 13 generator + check scripts
│   ├── autopilot-tuner/      # Self-improvement: diagnose.py + SKILL.md
│   └── ...                   # 17 other skills
├── agents/                   # 4 specialized agents
├── commands/                 # 10 slash commands
├── hooks/
│   └── hooks.json            # Hook event definitions
├── scripts/                  # Hook + utility scripts
│   ├── autopilot-monitor.sh  # PostToolUse: drift detection, escalation, phase budgets
│   ├── task-classifier.sh    # SessionStart: task type classification
│   ├── workflow-reset.sh     # SessionStart: state reset + outcome archival
│   ├── block-sensitive-files.sh
│   ├── php-lint-on-save.sh
│   ├── staleness-check.sh
│   ├── subagent-context-inject.sh
│   ├── teammate-quality-gate.sh
│   ├── policies/             # Per-task-type policy configs (6 types)
│   ├── session-analysis/     # analyze-replays.py, session-quality.py, etc.
│   ├── tests/                # test-autopilot-phase2.sh (10 behavioral cases)
│   └── lib/
│       └── hook-utils.sh
└── README.md
```

## Workflow

Documentation is generated in three layers. Each layer builds on the previous one.

```
Step 1: /drupal-refresh          → Structural index (Layer 2, deterministic bash scripts)
Step 2: /drupal-semantic init    → Semantic docs (Layer 3, AI-generated tech specs + business index)
Step 3: /drupal-semantic inject  → CLAUDE.md hint (compact pointer that drives +61% speed improvement)
```

**Step 1** parses `*.services.yml`, `*.routing.yml`, hooks, plugins, and entities via bash scripts. No AI involved. Produces `docs/semantic/structural/`.

**Step 2** spawns the `@semantic-architect` agent per feature to read structural data + source code and produce tech specs with Logic IDs. Produces `docs/semantic/tech/` and `docs/semantic/00_BUSINESS_INDEX.md`.

**Step 3** reads the generated tech specs and injects a compact `## Codebase` section into the project's CLAUDE.md — feature counts, Logic ID totals, and CODE:Name pairs. This is the prompt hint that tells the agent "these docs exist, read them first." Step 3 runs automatically at the end of Step 2, but can also be run standalone.

### Getting started

| Scenario | Command |
|----------|---------|
| Fresh project (no docs) | `/drupal-bootstrap` (runs Step 1, nudges you to run Steps 2-3) |
| Docs exist, check staleness | `/drupal-status` then `/drupal-refresh` if needed |
| Quick session, docs are fresh | CLAUDE.md hint handles it automatically. `/drupal-prime` for full debug dump. |
| Just update CLAUDE.md counts | `/drupal-semantic inject` |
| Validate tech spec format | `/drupal-semantic validate` (add `--fix` to auto-repair) |

### Context efficiency

On a real Drupal project (~85k LOC custom code, 26 features, 433 Logic IDs), `/discover --prime` outputs **~2,500 tokens** (~190 lines) covering:

- Full feature map with structural counts and hotspot scoring
- Cross-cutting module dependencies
- Feature registry with descriptions
- Key entities and core capabilities
- Logic ID counts per feature (26 tech specs)
- Available tech specs and query commands

That's ~1.2% of a 200k context window — roughly **34 lines of code awareness per token spent**.

## Semantic Documentation (Optional)

For large Drupal projects, create `docs/semantic/` in your project root to enable logic-to-code mapping:

```
docs/semantic/
├── 00_BUSINESS_INDEX.md      # Master feature index
├── tech/*.md                 # Logic-to-code mappings
├── schemas/*.json            # Config field schemas (auto-generated per bundle)
├── schemas/*.base-fields.json # Base field schemas (auto-generated from PHP)
├── schemas/*.business.json   # Business schemas (AI-authored: rules, relationships)
├── structural/               # Auto-generated by structural-index
│   ├── services.md           # Service graph
│   ├── routes.md             # Route map
│   ├── hooks.md              # Hook registry
│   ├── plugins.md            # Plugin registry
│   ├── entities.md           # Entity map (with Fields column)
│   ├── schemas.md            # Entity schema summary
│   ├── base-fields.md        # Base field registry
│   ├── permissions.md        # Permission registry
│   ├── methods.md            # Method index (Service/Controller/Form)
│   └── .generated-at         # Generation timestamp
├── DEPENDENCY_GRAPH.md       # Auto-generated cross-references
└── FEATURE_MAP.md            # Auto-generated feature overview
```

The `semantic-docs` and `discover` skills automatically use this documentation when available.

<details>
<summary><strong>Structural Index</strong> — automated Drupal structural awareness</summary>

### Overview

The structural index is a script-generated **Layer 2** that sits between human-authored semantic docs and raw codebase searches:

```
Layer 3: Semantic docs       (AI-generated, business "why")

~~~

## License

No top-level license file found.

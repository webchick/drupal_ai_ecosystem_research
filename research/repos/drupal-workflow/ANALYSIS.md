# Analysis: drupal-workflow

1. **What problem does it solve?** 
According to the `README.md`, it solves the problem of unstructured AI interactions by providing a "Claude Code plugin for Drupal development with live workflow optimization." It introduces a "Magic Loop Autopilot — a live policy engine that classifies tasks, detects drift via weighted scoring, escalates interventions (hint → command → suppress), and self-tunes based on session replay data."

2. **Primary artefact type**: 
It is primarily a **Claude Code plugin**. It aggregates skills, specialized agents, slash commands, and hook scripts into a cohesive ecosystem for a single CLI tool.

3. **Distribution model**: 
It is distributed as a standalone git repo that is loaded locally as a Claude Code plugin (`claude --plugin-dir ./drupal-workflow`), with future plans for npm distribution (`npm install drupal-workflow`) per the `README.md`.

4. **Standards conformance**: 
It uses the `skills/<name>/SKILL.md` format (19 skills found), but lacks an `AGENTS.md` file (noted in `INDEX.md`). It is strictly **single-tool compatible**, relying heavily on Claude Code's `.claude-plugin/plugin.json`, slash commands, and custom hook events.

5. **Architectural pattern**: 
It uses a highly complex **3-layer deterministic-then-semantic** pattern paired with an **autopilot policy engine**. Context is loaded at runtime via a compact pointer injected into the project's `CLAUDE.md`. The three layers consist of raw codebase access (Layer 1), deterministic bash-script parsing (`skills/structural-index/scripts/generate-all.sh`) for structural awareness (Layer 2), and AI-generated tech specs (`skills/semantic-docs/SKILL.md`) for business logic (Layer 3). It also uses hook-based interventions (`hooks/hooks.json`, `scripts/autopilot-monitor.sh`) to enforce workflows.

6. **Naming convention**: 
It primarily uses a **hyphenated noun/gerund prefix** convention (`drupal-testing`, `drupal-rules`, `twig-templating`, `semantic-docs`). It diverges from the strict gerund-first approach (e.g., `writing-tests`) favoured by `ai_best_practices`.

7. **Coverage**: 
It covers a wide array of core Drupal topics:
- Brainstorming (`skills/drupal-brainstorming/SKILL.md`)
- Caching (`skills/drupal-caching/SKILL.md`)
- Coding Standards (`skills/drupal-coding-standards/SKILL.md`)
- Config Management (`skills/drupal-config-management/SKILL.md`)
- Conventions (`skills/drupal-conventions/SKILL.md`)
- Entity API (`skills/drupal-entity-api/SKILL.md`)
- Hook Patterns (`skills/drupal-hook-patterns/SKILL.md`)
- Rules (`skills/drupal-rules/SKILL.md`)
- Security Patterns (`skills/drupal-security-patterns/SKILL.md`)
- Service DI (`skills/drupal-service-di/SKILL.md`)
- Testing (`skills/drupal-testing/SKILL.md`)
- Twig Templating (`skills/twig-templating/SKILL.md`)

8. **Quality signals**: 
The `INDEX.md` indicates an active (or artificially futuristic) last commit date of `2026-04-15`. The repository contains a highly sophisticated evaluation harness with behavioral evals (`eval/behavioral/`), automated LLM-as-judge scoring (`eval/eval-agents.py`), and extensive session analysis tools (`scripts/session-analysis/`).

9. **Notable innovations**: 
- **Magic Loop Autopilot**: A live, hook-driven policy engine (`scripts/autopilot-monitor.sh`) that tracks session drift and proactively intervenes during Claude Code usage.
- **Structural Indexing**: Deterministic bash scripts (`skills/structural-index/scripts/generate-all.sh`) that parse YAML files to build a dependency graph without AI overhead.
- **Session Replay & Tuning**: Tools to analyze past AI sessions and self-tune policies (`skills/autopilot-tuner/SKILL.md`, `scripts/session-analysis/analyze-replays.py`).

10. **Weaknesses / gaps**: 
Extreme **single-tool lock-in**. The entire workflow relies on Claude Code's specific plugin architecture, hook lifecycle (`PreToolUse`, `PostToolUse`), and slash commands. The complexity is very high, making it difficult to port to tools like Cursor, Roo, or Gemini.

11. **Compatibility with ai_best_practices' decisions**: 
It conflicts significantly. The naming convention (`drupal-*`) would need to change to gerunds. More fundamentally, the architecture relies on deeply integrated Claude Code hooks rather than portable markdown context. Extracting the `SKILL.md` files would strip them of the engine that makes them powerful here.

12. **Relationship to Surge**: 
Surge could aggregate the underlying `SKILL.md` files, but doing so would break the intended architecture, as these skills are designed to work alongside the `structural-index`, `discover` command, and hook interventions. There is an architectural conflict between Surge's flat aggregation and this repo's dynamic plugin structure.

13. **One-paragraph verdict**: 
**Reference**. `drupal-workflow` is an advanced, highly opinionated reference implementation of an agentic workflow tailored specifically for Claude Code. While its raw Drupal knowledge could technically be absorbed, doing so would decouple the content from the complex hook system, structural indexers, and autopilot engine that give the project its value. It should be linked to as an example of an extreme "thick client" AI plugin, but its architecture is too tool-specific to merge directly into a generalized best-practices repository.
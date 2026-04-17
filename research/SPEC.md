# Implementation Specification

## 1. Problem Statement

The Drupal AI tooling ecosystem is highly fragmented, with knowledge, skills, and agents scattered across dozens of overlapping repositories. Many of these repositories suffer from single-tool lock-in (particularly to Claude Code), duplicate common functionalities like DDEV setup and coding standards, and use conflicting distribution methods (e.g., `npx`, `agr`, shell scripts, Composer). This fragmentation causes context window bloat, duplicate effort, and poor developer experience as users struggle to discover and standardize AI capabilities. A unified, tool-agnostic architecture is needed to aggregate the best reference knowledge, standardize distribution, and seamlessly integrate into existing Drupal developer workflows.

## 2. Current ai_best_practices Decisions Recap

`ai_best_practices` has standardized on the `agentskills.io` specification. It uses declarative `SKILL.md` and `AGENTS.md` formats to ensure multi-tool compatibility across Claude, Cursor, GitHub Copilot, and Gemini. It mandates a flat, modular directory structure under `skills/`, enforces a "gerund-prefix" naming convention (e.g., `writing-tests`) for optimal actionability, and explicitly rejects proprietary tool lock-in—such as Claude Code-specific bash hooks or `.claude/` plugins—in favor of portable markdown context.

## 3. Proposed Architecture

The proposed architecture establishes a clear separation of concerns between the **Aggregator Engine** and the **Skill Repository**:

- **Aggregator Engine (`drupal/surge`)**: Surge will serve as the native Composer-based aggregator. It will automatically discover standard skills, detect the local environment (e.g., DDEV, Lando), and generate the project's centralized `AGENTS.md` context file.
- **Skill Repository (`ai_best_practices`)**: This repository will act as the canonical upstream provider of tool-agnostic skills. 
  - We will incorporate a **"progressive disclosure" pattern** (inspired by `claude-skill-drupal-module` and `drupal-coding-standards-skill`) to dynamically load deep context based on file extensions or specific tasks, keeping the initial context window light.
  - Agentic quality gates and autonomous linting concepts will be generalized into portable CLI instructions or standard pre-commit hooks, avoiding proprietary `.claude/hooks/` implementations.

## 4. Per-Repo Disposition Table

| Repository | Recommendation | Specific Action Items |
| :--- | :--- | :--- |
| `drupal-skill` | Absorb | Extract reference MDs; convert to standard `SKILL.md` formats; rename to gerunds. |
| `Drupal-DDEV-Setup-Claude-Skill` | Absorb / Ignore | Extract DDEV config workflows into a standard skill; ignore untested bash wrappers. |
| `ai-fe-skills` | Absorb | Directly port the `drupal-figma-to-canvas-sdc` skill. |
| `drupal-canvas-skills` | Reference | Link as the standard for Canvas component dev; avoid absorbing to prevent repo bloat. |
| `prompt_library` | Absorb / Ignore | Extract Drupal rules (`development/rules/drupal.md`); ignore 11ty static site architecture. |
| `drupal-critic` | Ignore | Superseded by `drupal-meta-skills`; reference the consolidated project instead. |
| `drupal-issue-hygiene-helper` | Absorb | Extract issue triage heuristics into markdown skills; ignore bespoke PHP scraping codebase. |
| `drupal-coding-standards-skill` | Absorb | Pull the dynamic routing logic (`standards-index.md`) mapping extensions to standards. |
| `drupalcon-chicago-26-ckeditor-ai-playground` | Absorb | Extract CKEditor 5 DLL instructions (`SKILL.md`) into a standard gerund-prefixed skill. |
| `drupal-intent-testing` | Reference | Recommend as the dedicated Python UI testing harness without absorbing its dependencies. |
| `drupal-contribute-fix` | Reference | Link as the recommended CLI utility for enforcing lint-first contrib workflows. |
| `drupaltools-skills` | Absorb | Extract executable script concepts; translate high-value skills to the gerund naming convention. |
| `claude-skill-drupal-module` | Absorb / Ignore | Absorb the progressive disclosure pattern and `references/*.md`; ignore the Claude-specific monolithic shell. |
| `drupal-agentic-workflow` | Absorb | Extract core knowledge; adapt its post-generation bash hooks into generic CI/pre-commit workflows. |
| `drupal-agent-resources` | Reference | Acknowledge as an advanced Claude/agr implementation; do not merge due to tight coupling. |
| `drupal-workflow` | Reference | Showcase as a complex thick-client plugin reference; too deeply tied to Claude for direct absorption. |
| `drupal-claude-skills` | Absorb | Extract tool-agnostic skills (e.g., config management); generalize the quality gate agent patterns. |
| `aidev` | Ignore | Abandoned PHP context-gathering utility; fundamentally incompatible with declarative agent workflows. |
| `surge` | Collaborate | Rely on Surge as the primary Composer-based aggregator and environmental template generator. |

## 5. Relationship with Surge

`ai_best_practices` and Surge are strictly complementary. There is no conflict. Surge acts as the framework and distribution engine—discovering skills, detecting environments, and compiling `AGENTS.md`. `ai_best_practices` acts as the definitive content library. By conforming to the `agentskills.io` standard, `ai_best_practices` ensures its skills are natively discoverable by Surge, providing a seamless `composer require drupal/surge` developer experience.

## 6. Migration and Compatibility Story

For users currently relying on fragmented, single-tool setups (like Claude Code plugins installed via `agr` or custom shell scripts), the migration path is streamlined through Composer. Users will transition to a `composer require drupal/surge --dev` workflow, which automatically indexes `ai_best_practices` skills. Existing proprietary `.claude/skills/` directories can be mapped or flattened into the standard `.agents/skills/` format. Because the architecture outputs standardized `AGENTS.md` and `SKILL.md` files, it guarantees out-of-the-box compatibility with Cursor, Copilot, and Gemini CLI, while retaining full functionality in Claude Code.

## 7. Open Questions

- **Executable Packaging**: How can we safely package external Python or shell scripts (e.g., those from `drupal-intent-testing` or `drupaltools-skills`) within the `agentskills.io` standard without requiring messy global system installations?
- **Routing Standardisation**: What is the most effective way to represent the "progressive disclosure" routing table (e.g., mapping `.module` files to hook standards) within a single `AGENTS.md` without overwhelming the context window?

## 8. Out of Scope

- Building full migration scripts for legacy proprietary `.claude` hook setups.
- Absorbing non-development or generalized workflows (e.g., sales/marketing prompts from `prompt_library`).
- Maintaining separate, duplicated versions of skills tailored for specific AI tools (all content must remain tool-agnostic).
- Executing arbitrary PHP aggregation code within the Drupal runtime (as attempted by `aidev`).
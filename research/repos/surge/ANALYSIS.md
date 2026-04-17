# Analysis of Surge

1. **What problem does it solve?** 
According to the `README.md`, Surge provides "an AI coding standard kit for Drupal development." It aims to give AI tools the necessary context to work within Drupal's conventions by "combining discoverable skills and open standards," helping the AI understand the codebase and environment without tool lock-in.

2. **Primary artefact type**: 
Composer plugin and CLI tool. The `composer.json` defines its type as `"composer-plugin"`, and it exposes CLI commands (`composer surge`) via Composer scripts to aggregate skills and generate context files (`README.md`).

3. **Distribution model**: 
Composer package (`drupal/surge`). It is installed via `composer require drupal/surge --dev` (`README.md`).

4. **Standards conformance**: 
It strictly follows the [agentskills.io](https://agentskills.io/) specification for discoverable skills and uses `AGENTS.md` for project context. It is explicitly designed to be multi-tool compatible, outputting to `.agents/skills/` for use with "Claude Code, Cursor, and other AI tools" (`README.md`).

5. **Architectural pattern**: 
Aggregator and template composer. It uses a routing/aggregation layer that discovers skills across the project (`discover_composer` and `discover_modules` in `surge.yaml.dist`) and copies them to a centralized `.agents/skills/` directory. For context, it generates an `AGENTS.md` file using a template composition engine that detects the local environment (e.g., DDEV, Lando) and stitches together relevant markdown sections (`src/Agents/templates/`) while replacing environment placeholders (`README.md`).

6. **Naming convention**: 
For its templates, it uses hyphenated nouns and topics (e.g., `batch-queue-ajax.md`, `entity-api.md`, `code-style.md`, `testing.md`), rather than strict gerund prefixes. This diverges from the gerund-centric naming convention (`writing-tests`) favoured by ai_best_practices (`src/Agents/templates/sections/`).

7. **Coverage**: 
Surge provides foundational templates for generating `AGENTS.md` context, covering:
- **Batch, Queue, AJAX**: `src/Agents/templates/sections/batch-queue-ajax.md`
- **Caching**: `src/Agents/templates/sections/caching.md`
- **Code Style**: `src/Agents/templates/sections/code-style.md`
- **Entity API**: `src/Agents/templates/sections/entity-api.md`
- **Forms API**: `src/Agents/templates/sections/forms-api.md`
- **Hooks**: `src/Agents/templates/sections/hooks.md`
- **Plugin System**: `src/Agents/templates/sections/plugin-system.md`
- **Routes & Controllers**: `src/Agents/templates/sections/routes-controllers.md`
- **Security**: `src/Agents/templates/sections/security.md`
- **Services & Dependency Injection**: `src/Agents/templates/sections/services-di.md`
- **Testing**: `src/Agents/templates/sections/testing.md`
- **Local Environments**: DDEV, Lando, and Docker Compose configurations (`src/Agents/templates/environments/`)

8. **Quality signals**: 
- **Last commit date**: 2026-04-04 (Mock future date in git history)
- **Tests**: Comprehensive testing setup with `phpunit.xml`. The `AGENTS.md` documentation notes "58 tests total (155 assertions)" including unit and integration tests (`tests/Surge/`, `tests/Skills/`, `tests/Agents/`).
- **CI**: Not visible in the provided tree (`INDEX.md`).
- **Versioning**: Uses standard Composer versioning.
- **Active maintainer**: Yes, based on the recent commit history.

9. **Notable innovations**: 
- **Environment Auto-Detection**: It actively scans the project for `.ddev/`, `.lando.yml`, or `compose.yaml` to dynamically assemble an `AGENTS.md` file with the correct local development commands and placeholders (`README.md`).
- **Composer Plugin Integration**: By running as a Composer plugin, it seamlessly integrates into the standard PHP developer workflow, automatically providing scripts and configuration without requiring a separate CLI binary (`composer.json`, `README.md`).

10. **Weaknesses / gaps**: 
- **Empty Skill Library**: The framework is robust but lacks its own payload of skills (0 `SKILL.md` files found per `INDEX.md`). It relies entirely on other packages or the host project to provide the actual Agent Skills.
- **PHP Ecosystem Lock-in**: Its architecture is heavily tied to Composer. While the output is tool-agnostic, the generation and aggregation require a PHP/Composer environment.

11. **Compatibility with ai_best_practices' decisions**: 
- **Naming convention**: Templates use hyphenated nouns instead of gerunds; these would need renaming to align with ai_best_practices.
- **Directory & Metadata**: Highly compatible. It already targets `.agents/skills/` and supports the agentskills.io standard.
- To merge or align, ai_best_practices would need to adopt Surge's Composer-driven aggregation approach or simply ensure its skills are discoverable by Surge's scanner.

12. **Relationship to Surge**: 
This repository *is* the Surge framework itself (`drupal/surge`). It serves as the core engine that aggregates skills and generates the context files. 

13. **One-paragraph verdict**: 
ai_best_practices should **collaborate** with this repository. Since Surge acts as the robust, Composer-native aggregator and templating engine, and ai_best_practices serves as the comprehensive library of content, they are perfectly complementary. Surge can handle the plumbing, environment detection, and file generation, while ai_best_practices can be distributed as a skill provider package that Surge discovers and aggregates into the final project workspace.

# Analysis: claude-skill-drupal-module

1. **What problem does it solve?**
According to the `README.md`, it "transforms Claude into a senior Drupal architect — generating production-ready, installable Drupal 11 modules using modern PHP 8.4+ syntax, proper dependency injection, and current Drupal 11 APIs."

2. **Primary artefact type**:
Skill / Claude Code plugin. It is explicitly defined in `composer.json` as `"type": "claude-skill"` and described in `README.md` as "A Claude Code skill".

3. **Distribution model**:
Composer package and standalone git repository. `README.md` states it can be installed via Composer (`composer require ablerz/claude-skill-drupal-module:dev-11.x`) which installs it directly to `.claude/skills/custom-drupal-module/` using `composer-installers-extender`, or it can be installed via `git clone`.

4. **Standards conformance**:
It uses the `SKILL.md` format (with frontmatter defining `name`, `description`, and custom `metadata` like `drupal_version` and `php_version`). It does not use `AGENTS.md` (noted as "Absent" in `INDEX.md`). It is a single-tool solution targeting only Claude Code, as evidenced by instructions like "invoke the skill in Claude Code using: /custom-drupal-module" (`README.md`).

5. **Architectural pattern**:
Routing layer + selective load (Progressive Disclosure). `SKILL.md` instructs the LLM: "This SKILL.md provides the core workflow and principles. Reference documentation in `references/` is loaded as needed based on the specific subsystem being worked on. This keeps the initial context light while providing deep expertise when required."

6. **Naming convention**:
Hyphenated noun phrase. The installer name in `composer.json` is `custom-drupal-module`, and the skill name in `SKILL.md` is `custom-drupal-module`. This diverges from the `ai_best_practices` gerund-prefix choice (e.g., `writing-tests`).

7. **Coverage**:
Based on `INDEX.md`, `README.md`, and `SKILL.md`, it covers:
- Entity API: `references/entity-api.md`
- Plugin API: `references/plugin-api.md`
- Configuration API: `references/configuration-api.md`
- Cache API / Performance: `references/cache-api.md`
- Routing System: `references/routing-system.md`
- Form API: `references/form-api.md`
- Database API: `references/database-api.md`
- Render API & Theming: `references/render-theming.md`
- Event System: `references/event-system.md`
- Dependency Injection: `references/dependency-injection.md`
- Security: `references/security.md`
- Testing & Quality: `references/testing-quality.md`
- Hooks: `references/hooks.md`
- DDEV: `ddev-commands/` directory and `README.md` setup instructions.
- Coding Standards: enforced via `ddev-commands/phpcs` and `SKILL.md`.

8. **Quality signals**:
- Last commit date: 2026-02-10 (from git log).
- Issue count / Stars: Not available locally.
- Tests: The repository lacks an internal test suite for the skill itself, though `INDEX.md` shows it ships with user-facing DDEV testing wrappers in `ddev-commands/`.
- Eval harness: Absent (`INDEX.md`).
- CI: Present via `.github/workflows/check-versions.yml` (for "automated staleness detection" as per `CHANGELOG.md`).
- Versioning discipline: High; uses git tags (`1.0.0`), a `CHANGELOG.md`, and a `VERSIONS.md` compatibility matrix.
- Active maintainer: Yes (Martijn de Wit).

9. **Notable innovations**:
- **Progressive Disclosure:** `SKILL.md` explicitly maps tasks to 13 separate reference markdown files in `references/` (e.g., loading `references/entity-api.md` only when creating an entity), significantly optimizing context windows.
- **WebFetch Integration:** `SKILL.md` leverages tool usage by instructing Claude to use WebFetch to dynamically read `api.drupal.org`, parse `drupal.org/list-changes`, and fetch live examples directly from the official `git.drupalcode.org/project/examples` repository.
- **Composer Installer Extensibility:** Uses `oomphinc/composer-installers-extender` in `composer.json` to seamlessly route the skill into the exact `.claude/skills/` directory on `composer require`.

10. **Weaknesses / gaps**:
- Single-tool lock-in: Strictly targets Claude Code (`README.md`, `SKILL.md`), ignoring Cursor, Copilot, or Gemini.
- Version lock-in: Hardcoded and tailored for Drupal 11.x and PHP 8.4+ (`SKILL.md` frontmatter and `README.md`), making it unhelpful for legacy Drupal 10 projects.
- Manual setup: The DDEV wrappers in `ddev-commands/` must be manually copied into the host project's `.ddev/commands/web/` directory (`README.md`).

11. **Compatibility with ai_best_practices' decisions**:
- Naming convention: Diverges (`custom-drupal-module` instead of gerund).
- Directory: Relies on `.claude/skills/` (`README.md`) instead of a generic multi-tool directory structure.
- Scope: Acts as a monolithic "architect" instead of providing discrete atomic tasks.
- To merge it in: The skill would need to be renamed to a gerund (e.g., `building-modules`), stripped of Claude-specific syntax and file paths to support multi-tool environments, and its 13 reference files would need to be integrated into `ai_best_practices`'s overarching semantic index or routing structure.

12. **Relationship to Surge**:
Surge aggregates agents/skills. While Surge could theoretically aggregate this via Git or Composer, there is a conflict in the installation path (`.claude/skills/` vs Surge's expected structure) and its single-tool focus limits its utility in a generic aggregator.

13. **One-paragraph verdict**:
`ai_best_practices` should **absorb** the architectural innovations and reference content from this repository, while choosing to **ignore** its monolithic, single-tool distribution shell. The "Progressive Disclosure" pattern—mapping tasks to 13 specific `references/*.md` files—and the strategy of using `WebFetch` to pull from the official `examples` module repository are highly advanced and should be integrated into our generic gerund-based skills. However, its strict lock-in to Claude Code, reliance on `.claude/skills/` paths via Composer (`composer.json`), and monolithic `custom-drupal-module` naming diverge too heavily from a multi-tool, multi-agent standard to be referenced or collaborated on as a direct dependency.